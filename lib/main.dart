import 'package:foss/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:foss/redux/app_state.dart';
import 'package:foss/redux/reducer.dart';
import 'package:foss/screens/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://eqoojbpbidscikuorsbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVxb29qYnBiaWRzY2lrdW9yc2JkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ5MTkzMDMsImV4cCI6MjAxMDQ5NTMwM30.irXm-ijqDE6mZhcdjed-4AVX0n1VhP1WaJCts0JF2gE',
    //authFlowType: AuthFlowType.pkce,
  );
  sb.auth.signOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);
  // This widget is the root of your application;
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Education App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
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
      ),
    );
  }
}
