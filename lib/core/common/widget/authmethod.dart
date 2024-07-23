import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((user) {
          // SessionController().userId = user.user!.uid.toString();
          return user;
        });

        // await _fireStore.collection("users").doc(cred.user!.uid).set({
        //   'name': name,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   "image": "",
        //   "mobile": ""
        // });
        // await _fireStore.collection("startup").doc(cred.user!.uid).set({
        //   'display_lang': true,
        //   'display_switch': true,
        // });

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          log(value.user!.uid);
          // SessionController().userId = value.user!.uid.toString();
        });
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for signOut
  signOut() async {
    await _auth.signOut();
  }
}
