import 'package:flutter/material.dart';
import 'package:flutter_new_firebase/Services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // -----App Bar----
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: const Text("Login"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                await AuthService().signOut();
              },
              icon: Icon(Icons.logout),
              label: Text("Sign Out"),
              style: TextButton.styleFrom(primary: Colors.white))
        ],
      ),
    );
  }
}
