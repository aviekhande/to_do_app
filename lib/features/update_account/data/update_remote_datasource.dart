import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/core/common/widget/session_controller.dart';

class UpdateProfile {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<List> updateProfile(
      {required String name,
      required String lastName,
      required String email,
      required String image}) async {
    try {
      await _fireStore.collection("users").doc(SessionController().userId).set({
        'name': name,
        'lastName': lastName,
        'email': email,
        "image": image,
      });
      return [true, ""];
    } catch (e) {
      return [false, e.toString()];
    }
  }
}
