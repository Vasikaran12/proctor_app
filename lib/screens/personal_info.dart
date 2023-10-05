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
  TextEditingController _dobcontroller = TextEditingController();
  TextEditingController _gendercontroller = TextEditingController();
  TextEditingController _relcontroller = TextEditingController();
  TextEditingController _comcontroller = TextEditingController();
  TextEditingController _castecontroller = TextEditingController();
  TextEditingController _aadharcontroller = TextEditingController();
  TextEditingController _bloodcontroller = TextEditingController();
  TextEditingController _paddresscontroller = TextEditingController();
  TextEditingController _caddresscontroller = TextEditingController();
  TextEditingController _nationcontroller = TextEditingController();
  TextEditingController _statecontroller = TextEditingController();
  TextEditingController _mothernamecontroller = TextEditingController();
  TextEditingController _fathernamecontroller = TextEditingController();
  TextEditingController _fatherocccontroller = TextEditingController();
  TextEditingController _motherocccontroller = TextEditingController();
  TextEditingController _parentnumcontroller = TextEditingController();
  TextEditingController _guardiannumcontroller = TextEditingController();
  TextEditingController _annualinccontroller = TextEditingController();
  TextEditingController _frstgrdcontroller = TextEditingController();
  TextEditingController _busernamecontroller = TextEditingController();
  TextEditingController _bnamecontroller = TextEditingController();
  TextEditingController _branchnamecontroller = TextEditingController();
  TextEditingController _accnocontroller = TextEditingController();
  TextEditingController _ifsccontroller = TextEditingController();
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
      _dobcontroller.text = list[0]['dob'] != null ? list[0]['dob'] : "";
      _gendercontroller.text =
          list[0]['gender'] != null ? list[0]['gender'] : "";
      _relcontroller.text =
          list[0]['religion'] != null ? list[0]['religion'] : "";
      _comcontroller.text =
          list[0]['community'] != null ? list[0]['community'] : "";
      _castecontroller.text = list[0]['caste'] != null ? list[0]['caste'] : "";
      _aadharcontroller.text =
          list[0]['aadhar'] != null ? list[0]['aadhar'] : "";
      _bloodcontroller.text =
          list[0]['blood_group'] != null ? list[0]['blood_group'] : "";
      _paddresscontroller.text =
          list[0]['p_address'] != null ? list[0]['p_address'] : "";
      _caddresscontroller.text =
          list[0]['c_address'] != null ? list[0]['c_address'] : "";
      _nationcontroller.text =
          list[0]['nationality'] != null ? list[0]['nationality'] : "";
      _statecontroller.text = list[0]['state'] != null ? list[0]['state'] : "";
      _fathernamecontroller.text =
          list[0]['father_name'] != null ? list[0]['father_name'] : "";
      _mothernamecontroller.text =
          list[0]['mother_name'] != null ? list[0]['mother_name'] : "";
      _fatherocccontroller.text = list[0]['father_occupation'] != null
          ? list[0]['father_occupation']
          : "";
      _motherocccontroller.text = list[0]['mother_occupation'] != null
          ? list[0]['mother_occupation']
          : "";
      _parentnumcontroller.text =
          list[0]['parent_number'] != null ? list[0]['parent_number'] : "";
      _guardiannumcontroller.text =
          list[0]['guardian_name'] != null ? list[0]['guardian_name'] : "";
      _annualinccontroller.text =
          list[0]['annual_income'] != null ? list[0]['annual_income'] : "";
      _frstgrdcontroller.text =
          list[0]['first_grad'] != null ? list[0]['first_grad'] : "";
      _busernamecontroller.text =
          list[0]['bank_username'] != null ? list[0]['bank_username'] : "";
      _bnamecontroller.text =
          list[0]['bank_name'] != null ? list[0]['bank_name'] : "";
      _branchnamecontroller.text =
          list[0]['branch_name'] != null ? list[0]['branch_name'] : "";
      _accnocontroller.text =
          list[0]['account_number'] != null ? list[0]['account_number'] : "";
      _ifsccontroller.text = list[0]['ifsc'] != null ? list[0]['ifsc'] : "";

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
        'dob': _dobcontroller.text,
        'gender': _gendercontroller.text,
        'religion': _relcontroller.text,
        'community': _comcontroller.text,
        'caste': _castecontroller.text,
        'aadhar': _aadharcontroller.text,
        'blood_group': _bloodcontroller.text,
        'p_address': _paddresscontroller.text,
        'c_address': _caddresscontroller.text,
        'nationality': _nationcontroller.text,
        'state': _statecontroller.text,
        'father_name': _fathernamecontroller.text,
        'mother_name': _mothernamecontroller.text,
        'father_occupation': _fatherocccontroller.text,
        'mother_occupation': _motherocccontroller.text,
        'parent_number': _parentnumcontroller.text,
        'guardian_name': _guardiannumcontroller.text,
        'annual_income': _annualinccontroller.text,
        'first_grad': _frstgrdcontroller.text,
        'bank_username': _busernamecontroller.text,
        'bank_name': _bnamecontroller.text,
        'branch_name': _branchnamecontroller.text,
        'account_number': _accnocontroller.text,
        'ifsc': _ifsccontroller.text,
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
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'DOB',
                      controller: _dobcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Gender',
                      controller: _gendercontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Religion',
                      controller: _relcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Community',
                      controller: _comcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Gender',
                      controller: _gendercontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Caste',
                      controller: _castecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Aadhar Number',
                      controller: _aadharcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Blood Group',
                      controller: _bloodcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.add_location_alt,
                      label: 'Permanent Address',
                      controller: _paddresscontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.add_location_alt_outlined,
                      label: 'Communication Address',
                      controller: _caddresscontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Nationality',
                      controller: _nationcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'State',
                      controller: _statecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Mother Name',
                      controller: _mothernamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Father Name',
                      controller: _fathernamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Mother Occupation',
                      controller: _motherocccontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Father Occupation',
                      controller: _fatherocccontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Parent Mobile Number',
                      controller: _parentnumcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Guardian Number',
                      controller: _guardiannumcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Annual Income',
                      controller: _annualinccontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'First Graduate',
                      controller: _frstgrdcontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_box,
                      label: 'Bank Username',
                      controller: _busernamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_balance,
                      label: 'Bank Name',
                      controller: _bnamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_balance_outlined,
                      label: 'Branch Name',
                      controller: _branchnamecontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Account Number',
                      controller: _accnocontroller,
                      tit: TextInputType.name,
                      editable: editable,
                    ),
                    InfoBox(
                      icon: Icons.attach_money_outlined,
                      label: 'IFSC Number',
                      controller: _ifsccontroller,
                      tit: TextInputType.name,
                      editable: editable,
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
