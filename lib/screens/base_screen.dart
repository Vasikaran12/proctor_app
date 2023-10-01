import 'package:foss/constants/color.dart';
import 'package:foss/constants/size.dart';
import 'package:foss/supabase/constants.dart';
import 'package:foss/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'exam_screen.dart';
import 'message_screen.dart';
import 'profile_screen.dart';
import 'package:intl/intl.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _index = 0;

  List _list = [
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
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home_filled,
                size: kBottomNavigationBarItemSize,
              ),
              icon: Icon(
                Icons.home_outlined,
                size: kBottomNavigationBarItemSize,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.article_rounded,
                size: kBottomNavigationBarItemSize,
              ),
              icon: Icon(
                Icons.article_outlined,
                size: kBottomNavigationBarItemSize,
              ),
              label: "Exams",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.message,
                size: kBottomNavigationBarItemSize,
              ),
              icon: Icon(
                Icons.message_outlined,
                size: kBottomNavigationBarItemSize,
              ),
              label: "Message",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.account_box_rounded,
                size: kBottomNavigationBarItemSize,
              ),
              icon: Icon(
                Icons.account_box_outlined,
                size: kBottomNavigationBarItemSize,
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
  int hr = DateTime.now().hour;

  fetchData() async {
    await sb.from('proctor').select().eq('mail_id', user!['proctor']);
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
                                "Hello ${user != null ? user!['first_name'] : ""} 👋",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(
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
                                  "Dr. K. Indira",
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
                const Expanded(child: Center(child: Text("home"))),
              ],
            ),
          );
  }
}
