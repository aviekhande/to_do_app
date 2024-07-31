import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/common/widget/session_controller.dart';
import '../presentation/pages/profile_screen.dart';

Future<DocumentSnapshot?> getUserData() async {
  log("User Id:${SessionController().userId}");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(SessionController().userId)
      .get()
      .then((value) {
    docSnap = value;
  });
  return docSnap;
}
