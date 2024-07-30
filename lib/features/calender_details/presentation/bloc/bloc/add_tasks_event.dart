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
  TaskDone({required this.id});
}
class TaskUnDone extends AddTasksEvent {
  String id;
  TaskUnDone({required this.id});
}
