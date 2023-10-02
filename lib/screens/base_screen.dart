import 'package:foss/constants/color.dart';
import 'package:foss/supabase/constants.dart';
import 'package:foss/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'exam_screen.dart';
import 'message_screen.dart';
import 'profile_screen.dart';
import 'package:flip_card/flip_card.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  BaseScreenState createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  int _index = 0;

  final List _list = [
    const HomeScreen(),
    const ExamScreen(),
    const MessageScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _list[_index],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                size: 24,
              ),
              icon: Icon(
                Icons.home_outlined,
                size: 24,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.article_rounded,
                size: 24,
              ),
              icon: Icon(
                Icons.article_outlined,
                size: 24,
              ),
              label: "Exams",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.message,
                size: 24,
              ),
              icon: Icon(
                Icons.message_outlined,
                size: 24,
              ),
              label: "Message",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.account_box_rounded,
                size: 24,
              ),
              icon: Icon(
                Icons.account_box_outlined,
                size: 24,
              ),
              label: "Profile",
            ),
          ],
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
          }),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPageLoading = true;

  final user = sb.auth.currentUser!.userMetadata;
  late String proctor;
  late String name;
  int hr = DateTime.now().hour;

  fetchData() async {
    var udata =
        await sb.from('student').select('''*, proctor: proctor(name)''');
    var list = List<Map<String, dynamic>>.from(udata);
    if (list.isEmpty) {
      try {
        await sb.from('student').insert({
          'first_name': user!['first_name'],
          'last_name': user!['last_name'],
          'roll_number': user!['roll_number'],
          'register_number': user!['register_number'],
          'phone_number': user!['phone_number'],
          'email': sb.auth.currentUser!.email,
          'proctor_id': user!['proctor'],
        });
        udata = await sb
            .from('student')
            .select('''first_name, proctor: proctor(name)''');
        list = List<Map<String, dynamic>>.from(udata);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    name = list[0]['first_name'];
    proctor = list[0]['proctor']['name'] as String;

    setState(() {
      isPageLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? Expanded(
            child: Container(
                color: Colors.white,
                child: Center(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 30,
                  child: const LinearProgressIndicator(),
                ))),
          )
        : Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  height: MediaQuery.sizeOf(context).height / 3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.5],
                      colors: [
                        Color(0xff886ff2),
                        Color(0xff6849ef),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello $name 👋",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                (hr >= 16)
                                    ? "Good Evening 🌥️"
                                    : (hr >= 12)
                                        ? "Good Noon 🌞"
                                        : "Good Morning 🌥️",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          CircleButton(
                            icon: Icons.notifications,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Proctor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  proctor,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL,
                          side: CardSide.FRONT,
                          speed: 1000,
                          onFlipDone: (status) {
                            print(status);
                          },
                          front: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFF006666),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'ID Card',
                                ),
                                Text(
                                  'Front',
                                ),
                              ],
                            ),
                          ),
                          back: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFF006666),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('ID Card'),
                                Text('Back'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
