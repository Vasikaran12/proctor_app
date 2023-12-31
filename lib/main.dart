import 'package:foss/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';
import 'package:foss/screens/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:foss/constants/color.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://eqoojbpbidscikuorsbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxb29qYnBiaWRzY2lrdW9yc2JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ5MTkzMDMsImV4cCI6MjAxMDQ5NTMwM30.irXm-ijqDE6mZhcdjed-4AVX0n1VhP1WaJCts0JF2gE',
    //authFlowType: AuthFlowType.pkce,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff6849ef, color),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      home: (sb.auth.currentUser != null)
          ? const BaseScreen()
          : const LoginPage(),
    );
  }
}
