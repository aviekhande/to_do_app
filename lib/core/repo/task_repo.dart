import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import '../../features/home_screen/data/datasource/remote_get_tasks_datasource.dart';
import '../common/widget/session_controller.dart';

class ProductRepo {
  List<Tasks> taskList = [];
  Future<List<Tasks>> addTask(Tasks model) async {
    taskList = [];
    taskList.add(model);
    List<Tasks> task = await getTodoData();
    taskList.addAll(task);
    addData();
    return taskList;
  }

  void addData() async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(SessionController().userId)
        .set({
      "data": taskList
          .map((e) => Tasks(
                task: e.task,
                date: e.date,
                time: e.time,
              ).toJson())
          .toList()
    });
  }

  Future<List<Tasks>> removeTask(String? id)async {
    taskList.removeWhere((element) => element.time == id);
    //  List<Tasks> task = await getTodoData();
    // taskList.addAll(task);
    addData();
    return taskList;
  }

  // bool isWishlist(Product model) {
  //   return favlist.remove(model);
  // }
}
