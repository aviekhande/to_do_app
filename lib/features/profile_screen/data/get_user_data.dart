import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/common/widget/session_controller.dart';
import '../presentation/pages/profile_screen.dart';

Future<DocumentSnapshot?> getUserData() async {
  log("${SessionController().userId}");
  await FirebaseFirestore.instance
      .collection("users")
      .doc(SessionController().userId)
      .get()
      .then((value) {
    log("${value['email']}?????????????????");
    docSnap = value;
  });
  return docSnap;
}
