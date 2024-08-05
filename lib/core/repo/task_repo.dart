import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import '../../features/home_screen/data/datasource/remote_get_tasks_datasource.dart';
import '../common/widget/session_controller.dart';

class ProductRepo {
  List<Tasks> taskList = [];
  Future<List<Tasks>> addTask(Tasks model) async {
    taskList.add(model);
    addData();
    return taskList;
  }

  Future<List<Tasks>> fetchTask() async {
    List<Tasks> task = await getTodoData();
    taskList.addAll(task);
    return task;
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
                  id: e.id,
                  done: e.done,
                  priority: e.priority,
                  alarm: e.alarm)
              .toJson())
          .toList()
    });
  }

  Future<List<Tasks>> doneTask(String? id) async {
    List<Tasks> task = await getTodoData();
    taskList = [];
    taskList.addAll(task);
    log("IN task Done");
    taskList.forEach((element) {
      if (element.id == id) {
        element.done = true;
        element.alarm = false;
      }
    });
    addData();
    return taskList;
  }

  Future<List<Tasks>> unDoneTask(String? id) async {
    List<Tasks> task = await getTodoData();
    taskList = [];
    taskList.addAll(task);
    taskList.forEach((element) {
      if (element.id == id) {
        element.done = false;
      }
    });
    addData();
    return taskList;
  }

  Future<List<Tasks>> removeTask(String? id) async {
    taskList.removeWhere((element) => element.id == id);

    addData();
    return taskList;
  }

  // bool isWishlist(Product model) {
  //   return favlist.remove(model);
  // }
}
