import 'package:to_do_app/features/home_screen/data/model/task_model.dart';

List<Tasks> getImportTasks(List<Tasks> tasks){
  List<Tasks> tasks1=[];
    for(int i=0;i<tasks.length;i++){
        if(tasks[i].imp== true){
            tasks1.add(tasks[i]);
        }
    }
    return tasks1;
}