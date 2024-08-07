import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/core/common/widget/session_controller.dart';

import '../../../home_screen/data/model/task_model.dart';


Future<List<Tasks>> getRecycleData() async {
  DocumentSnapshot? docSnap;
  List<Tasks> todoList = [];
  try {
    await FirebaseFirestore.instance
        .collection("recycle")
        .doc(SessionController().userId)
        .get()
        .then((value) {
      docSnap = value;
      return;
    });
  } catch (e) {
    rethrow;
  }
  log("${docSnap?["data"].isNotEmpty}");

  if (docSnap != null) {
    for (int i = 0; i < docSnap?["data"].length; i++) {
      todoList.add(Tasks.fromJson(docSnap?["data"][i]));
    }
  }

  return todoList;
}
