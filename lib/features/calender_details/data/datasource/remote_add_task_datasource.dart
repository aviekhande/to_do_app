import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/common/widget/session_controller.dart';

class RemoteAddTaskDatasource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<List> addTask(
      {required String task,
      required String date,
      required String time}) async {
    try {
      await _fireStore.collection("todo").doc(SessionController().userId).set({
        'task': task,
        'date': date,
        'time': time,
      });
      return [true];
    } catch (e) {
      return [false, e.toString()];
    }
  }
}
