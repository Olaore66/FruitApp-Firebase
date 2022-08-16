import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_firebase/Screens/Home_Screen.dart';
import 'package:flutter_new_firebase/Screens/Login_Screen.dart';
import 'package:flutter_new_firebase/Services/auth_services.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // --- this stores the data for the text form ----
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordemailController =
      TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // -----App Bar----
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: const Text("Register"),
      ),

      // ----BODY------
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // email textfield
              TextField(
                controller: emailController,
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
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              // confirm password textfield
              TextField(
                controller: confirmPasswordemailController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(),
                ),
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
                          if (this.mounted) {
                            setState(() {
                              loading = true;
                            });
                          }
                          if (emailController.text == "" ||
                              passwordController.text == "" ||
                              confirmPasswordemailController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("All fields are required!"),
                              backgroundColor: Colors.red,
                            ));
                          } else if (passwordController.text !=
                              confirmPasswordemailController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Passwords donot match"),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthService().register(
                                emailController.text,
                                passwordController.text,
                                context);
                            if (User != null) {
                              print("Success");

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            }
                          }
                          if (this.mounted) {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orangeAccent),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Already have an account? Login here")),

              const SizedBox(
                height: 20,
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              loading
                  ? CircularProgressIndicator()
                  : SignInButton(
                      Buttons.Google,
                      text: "Continue with Google",
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await AuthService().signInWithGoogle();
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
