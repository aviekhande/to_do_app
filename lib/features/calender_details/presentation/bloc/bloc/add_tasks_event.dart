part of 'add_tasks_bloc.dart';

sealed class AddTasksEvent {}

class TaskAdd1 extends AddTasksEvent {
  Tasks task;
  TaskAdd1({required this.task});
}

class TaskAdd extends AddTasksEvent {}

class TaskDelete extends AddTasksEvent {
  String id;
  TaskDelete({required this.id});
}
class TaskDone extends AddTasksEvent {
   String id;
   bool isDone;
  TaskDone({required this.id,required this.isDone});
}
class TaskUnDone extends AddTasksEvent {
  String id;
  TaskUnDone({required this.id});
}
  class EditTask extends AddTasksEvent {
    Tasks task;
    int index;
  EditTask({required this.task,required this.index});
  }

class ImpTask extends AddTasksEvent {
  String id;
  ImpTask({required this.id});
}

class TaskUnImp extends AddTasksEvent {
  String id;
  TaskUnImp({required this.id});
}

