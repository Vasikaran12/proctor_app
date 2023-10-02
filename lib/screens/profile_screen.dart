import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';
import 'login_page.dart';
import 'personal_info.dart';
import 'academic_info.dart';
import 'certificates.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                maxRadius: 50,
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Colors.white, size: 50),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PersonalInfo()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Personal Information',
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
              Divider(),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AcademicInfo()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Academic Information',
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
              Divider(),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CertificatePage()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Certificates',
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
              Divider(),
              /*SizedBox(
                height: 20,
              ),*/
              InkWell(
                onTap: () async {
                  await sb.auth.signOut();
                  if (sb.auth.currentSession == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
