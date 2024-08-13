import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/common/widget/session_controller.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/auth/presentation/bloc/login_number_bloc/log_in_with_number_bloc.dart';

class AuthMethod {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List> SignUpUser(
      {required String email,
      required String password,
      required String name,
      required String lastName,
      required String image}) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //     .then((user) {
        //   log(user.user!.uid.toString());
        //   SessionController().userId = user.user!.uid.toString();
        //   return user;
        // });
        SessionController().userId = cred.user!.uid.toString();
        log("message");
        await FirebaseFirestore.instance
            .collection("todo")
            .doc(SessionController().userId)
            .set({"data": {}});
        await FirebaseFirestore.instance
            .collection("recycle")
            .doc(SessionController().userId)
            .set({"data": {}});
        await _fireStore.collection("users").doc(cred.user!.uid).set({
          'name': name,
          'lastName': lastName,
          'email': email,
          "image": image,
        });
        // await _fireStore.collection("startup").doc(cred.user!.uid).set({
        //   'display_lang': true,
        //   'display_switch': true,
        // });
        // log("${cred.}");
        res = "success";
      }
    } catch (err) {
      log("$err");
      return [false, err.toString()];
    }
    return [true, res];
  }

  // logIn user
  Future<List> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        final response = await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          log(value.user!.uid);
          SessionController().userId = value.user!.uid.toString();
        });
        res = "success";
        return [true, SessionController().userId!];
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return [false, err.toString()];
    }
    return [true];
  }

  // for signOut
  signOut() async {
    await _auth.signOut();
  }

  Future<List> resetPassword({required String email}) async {
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
      }
    } catch (e) {
      return [false, e.toString()];
    }
    return [true, "success"];
  }

  Future<String> verifyPhoneNumber(String _phone, BuildContext context) async {
    String res = "failed";
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91' + _phone,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        context.read<LogInWithNumberBloc>().add(VerificationFailed(res: e.toString()));
    
      },
      codeSent: (String verificationId, int? resendToken) {
        context
            .read<LogInWithNumberBloc>()
            .add(CodeSent(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return res;
  }

  Future<String> signInWithOTP(
      String _verificationId, String _otp, BuildContext context) async {
        String res="failed";
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otp,
    );
    try{
        await _auth.signInWithCredential(credential);
    SessionController().userId = _auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(_auth.currentUser!.uid)
        .set({"data": {}});
    await FirebaseFirestore.instance
        .collection("recycle")
        .doc(_auth.currentUser!.uid)
        .set({"data": {}});
    await _fireStore.collection("users").doc(_auth.currentUser!.uid).set({
      'name': "name",
      'lastName': "lastName",
      'email': "",
      "image": "",
    });
    res="success";
    }catch(e){
      res = "failed";
    }
    return res;
  }
}
