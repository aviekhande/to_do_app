import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import '../common/widget/session_controller.dart';

class ProductRepo {
  List<Tasks> taskList = [];
  List<Tasks> addTask(Tasks model) {
    taskList.add(model);
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

  // List<Product> removeProduct(int? id) {
  //   favlist.removeWhere((element) => element.id == id);
  //   addData();
  //   return favlist;
  // }

  // bool isWishlist(Product model) {
  //   return favlist.remove(model);
  // }
}
