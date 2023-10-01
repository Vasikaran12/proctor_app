import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool passToggle = true;
  bool isLoading = false;
  bool isCompleted = false;

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
      );
      setState(() {
        isLoading = false;
        isCompleted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please check your inbox for confirmation email'),
      ));
      Navigator.of(context).pushReplacementNamed('/login');
    } on AuthException catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
      print(123);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
      print(45);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BUYER"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/buyer.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 50),
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
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    //_signUp();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: isLoading || isCompleted
                          ? Colors.white
                          : Colors.indigo,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : isCompleted
                            ? const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                                size: 45.0,
                              )
                            : const Center(
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
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 17),
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
