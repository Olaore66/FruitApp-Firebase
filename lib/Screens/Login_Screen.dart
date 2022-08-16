import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_new_firebase/Screens/Home_Screen.dart';
import 'package:flutter_new_firebase/Services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- this stores the data for the text form ----
  TextEditingController login_emailController = TextEditingController();
  TextEditingController login_passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // -----App Bar----
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text("Login"),
      ),

      // ----BODY------
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // email textfield
            TextField(
              controller: login_emailController,
              decoration: const InputDecoration(
                labelText: "email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30,
            ),

            // password textfield
            TextField(
              controller: login_passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 30,
            ),

            // button to submit
            loading
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (login_emailController.text == "" ||
                            login_passwordController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("All fields are required!"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          User? result = await AuthService().login(
                              login_emailController.text,
                              login_passwordController.text,
                              context);
                          if (result != null) {
                            print("Success");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Username or Password doesnot exist"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.teal),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
