import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_firebase/Screens/Home_Screen.dart';
import 'package:flutter_new_firebase/Screens/Register_Screen.dart';
import 'package:flutter_new_firebase/Services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      // below code snippet is what keeps the user signed in perpetually when the close the app
      // until they sign out from the app.
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return RegisterScreen();
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
