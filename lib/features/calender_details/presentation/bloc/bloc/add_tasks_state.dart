part of 'add_tasks_bloc.dart';


sealed class AddTasksState {}

final class AddTasksInitial extends AddTasksState {}

class AddTaskLoading extends AddTasksState {}

class AddTaskSuccess extends AddTasksState {
  List<Tasks> task;
  AddTaskSuccess({required this.task});
}
class AddTaskSuccess1 extends AddTasksState {
}

class AddTaskFailed extends AddTasksState {}
class TasksDeleteLoading extends AddTasksState {}

class TasksDeleteSuccess extends AddTasksState {}

class TasksDeleteFailure extends AddTasksState {}

