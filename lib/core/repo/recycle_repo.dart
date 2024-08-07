import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import '../../features/recycle_details/data/datasource/remote_ get_recycle_datasource.dart';
import '../common/widget/session_controller.dart';

class ProductRepo {
  List<Tasks> taskList = [];
  Future<List<Tasks>> addTask(Tasks model) async {
    taskList.add(model);
    addData();
    return taskList;
  }

  Future<List<Tasks>> fetchTask() async {
    List<Tasks> task = await getRecycleData();
    taskList.addAll(task);
    return task;
  }

  void addData() async {
    await FirebaseFirestore.instance
        .collection("recycle")
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

  Future<List<Tasks>> removeTask(String? id) async {
    taskList.removeWhere((element) => element.id == id);

    addData();
    return taskList;
  }

}
