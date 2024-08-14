import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import '../../features/home_screen/data/datasource/remote_get_tasks_datasource.dart';
import '../common/widget/session_controller.dart';

class ProductRepo1 {
  List<Tasks> taskList = [];
  Future<List<Tasks>> addTask(Tasks model) async {
    taskList.add(model);
    addData();
    return taskList;
  }
   Future<List<Tasks>> editTask(Tasks model,int index) async {
    int? find;
    for(int i=0; i <taskList.length;i++){
      if( int.parse(taskList[i].id!) == index){
          find=i;
      }
    }
    taskList[find!]= model;
    addData();
    return taskList;
  }

  Future<List<Tasks>> fetchTask() async {
    List<Tasks> task = await getTodoData();
    taskList=[];
    taskList.addAll(task);
    return task;
  }
  Future<List<Tasks>> fetchTask1() async {
    List<Tasks> task = await getTodoData();

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
                  note: e.note,
                  imp: e.imp,
                  files: e.files,
                  alarm: e.alarm)
              .toJson())
          .toList()
    });
  }

  Future<List<Tasks>> doneTask(String? id,bool isDone) async {
    List<Tasks> task = await getTodoData();
    taskList = [];
    taskList.addAll(task);
    log("IN task Done");
    taskList.forEach((element) {
      if (element.id == id) {
        element.done = isDone;
        element.alarm = "";
      }
    });
    addData();
    return taskList;
  }
   Future<List<Tasks>> impTask(String? id) async {
    List<Tasks> task = await getTodoData();
    taskList = [];
    taskList.addAll(task);
    taskList.forEach((element) {
      if (element.id == id) {
       element.imp=true; 
      }
    });
    addData();
    return taskList;
  }
Future<List<Tasks>> unImpTask(String? id) async {
    List<Tasks> task = await getTodoData();
    taskList = [];
    taskList.addAll(task);
    taskList.forEach((element) {
      if (element.id == id) {
        element.imp = false;
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
