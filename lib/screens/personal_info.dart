import 'package:flutter/material.dart';
import 'package:foss/screens/profile_screen.dart';
import 'package:foss/widgets/info_box.dart';
import 'package:foss/supabase/constants.dart';
import 'package:foss/constants/color.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool editable = false;
  bool isCompleted = false;
  bool isLoading = false;
  bool isPageLoading = true;
  late final List list;
  TextEditingController _fnamecontroller = TextEditingController();
  TextEditingController _lnamecontroller = TextEditingController();
  TextEditingController _rollcontroller = TextEditingController();
  TextEditingController _regcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _proctorcontroller = TextEditingController();

  fetchData() async {
    try {
      final udata =
          await sb.from('student').select('''*, proctor: proctor(name)''');
      list = List<Map<String, dynamic>>.from(udata);
      _fnamecontroller.text = list[0]['first_name'];
      _lnamecontroller.text = list[0]['last_name'];
      _rollcontroller.text = list[0]['roll_number'];
      _regcontroller.text = list[0]['register_number'];
      _phonecontroller.text = list[0]['phone_number'];
      _emailcontroller.text = list[0]['email'];
      _proctorcontroller.text = list[0]['proctor']['name'];

      setState(() {
        isPageLoading = false;
      });
    } catch (e) {
      print('hello');
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadData() async {
    try {
      await sb.from('student').update({
        'first_name': _fnamecontroller.text,
        'last_name': _lnamecontroller.text,
        'roll_number': _rollcontroller.text,
        'register_number': _regcontroller.text,
        'phone_number': _phonecontroller.text,
        'email': _emailcontroller.text,
      }).match({'uid': sb.auth.currentUser!.id});
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
      editable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
                child: Container(
              padding: const EdgeInsets.all(10),
              height: 30,
              child: const LinearProgressIndicator(),
            )))
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Define the action when the back button is pressed
                  Navigator.pop(
                      context); // This pops the current route off the stack
                },
              ),
              actions: [
                !editable
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            editable = true;
                          });
                        },
                        icon: Icon(Icons.create_rounded),
                      )
                    : SizedBox(),
              ],
              title: const Text(
                "Personal Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, color: Colors.white, size: 50),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InfoBox(
                      icon: Icons.align_horizontal_left,
                      label: 'First Name',
                      controller: _fnamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.align_horizontal_right,
                      label: 'Last Name',
                      controller: _lnamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.pin_outlined,
                      label: 'Roll Number',
                      controller: _rollcontroller,
                      tit: TextInputType.text,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.numbers_rounded,
                      label: 'Register Number',
                      controller: _regcontroller,
                      tit: TextInputType.text,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      controller: _phonecontroller,
                      tit: TextInputType.phone,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.mail,
                      label: 'Email',
                      controller: _emailcontroller,
                      tit: TextInputType.emailAddress,
                      editable: false,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Proctor',
                      controller: _proctorcontroller,
                      tit: TextInputType.name,
                      editable: false,
                    ),
                    SizedBox(height: 40),
                    isLoading
                        ? CircularProgressIndicator()
                        : editable
                            ? InkWell(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await _loadData();
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ));
  }
}
