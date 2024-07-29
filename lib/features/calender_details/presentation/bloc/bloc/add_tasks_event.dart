part of 'add_tasks_bloc.dart';

sealed class AddTasksEvent {}

class TaskAdd1 extends AddTasksEvent {
  Tasks task;
  TaskAdd1({required this.task});
}

class TaskAdd extends AddTasksEvent {}

class TaskDelete extends AddTasksEvent {
  String time;
  TaskDelete({required this.time});
}
