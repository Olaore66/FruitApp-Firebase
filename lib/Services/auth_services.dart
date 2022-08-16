import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // ---Register User---
  Future<User?> register(
      String email, String password, BuildContext context) async {
    //buildcontext allow us to display a widget
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e);
    }
  }

  // ---Login User---
  Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userLoginCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userLoginCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e);
    }
  }

  // ---Sign In with Google---
  Future<User?> signInWithGoogle() async {
    try {

      //Trigger the Auth dialog
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
      if (googleuser != null) {
        //Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleuser.authentication;
        //Create new Credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        //Once signed in return the user deta from firebase
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
        
      }
    } catch (e) {
      print(e);
    }
  }

  // ---Sign Out---
  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
