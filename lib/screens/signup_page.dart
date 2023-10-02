import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foss/constants/color.dart';
import 'login_page.dart';
import 'package:foss/supabase/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _rollController = TextEditingController();
  final _regController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
  bool passToggle = true;
  bool isLoading = false;
  bool isCompleted = false;
  bool isPageLoading = true;

  late final List<Map<String, dynamic>> _list;
  String? _dropdownvalue;

  void fetchData() async {
    try {
      final data = await sb.from('proctor').select();
      _list = List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print(e.toString());
    }
    _dropdownvalue = _list[0]['mail_id'];
    print('hello \n\n\ndone');
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
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final email = _emailController.text;
    final password = _passController.text;
    try {
      await sb.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
        data: {
          'first_name': _fnameController.text,
          'last_name': _lnameController.text,
          'roll_number': _rollController.text,
          'register_number': _regController.text,
          'phone_number': _phoneController.text,
          'email': _emailController.text,
          'proctor': _dropdownvalue,
        },
      );
      setState(() {
        isLoading = false;
        isCompleted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please check your inbox for confirmation email'),
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on AuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
    }
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
              title: const Text(
                "STUDENT",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.three_p_rounded,
                        size: 100,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: _fnameController,
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.align_horizontal_left),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: _lnameController,
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.align_horizontal_right),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: _rollController,
                        decoration: const InputDecoration(
                          labelText: "Roll Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.pin_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: _regController,
                        decoration: const InputDecoration(
                          labelText: "Register Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.numbers_rounded),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        value: _dropdownvalue,
                        icon: null,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          labelText: "Proctor",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: Icon(Icons.account_box),
                          filled: false,
                        ),
                        items: _list.map((Map<String, dynamic> item) {
                          return DropdownMenuItem(
                            value: item['mail_id'] as String,
                            child: Text(item['name']),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print(newValue);
                          setState(() {
                            _dropdownvalue = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passController,
                        obscureText: passToggle,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          if (val.length < 6) {
                            return '6 characters minimum';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _cpassController,
                        obscureText: passToggle,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Required';
                          }
                          if (val.length < 6) {
                            return '6 characters minimum';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      isLoading
                          ? CircularProgressIndicator()
                          : isCompleted
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.green,
                                  size: 45.0,
                                )
                              : InkWell(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await _signUp();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: isLoading || isCompleted
                                          ? Colors.white.withOpacity(0)
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 17, color: kPrimaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
