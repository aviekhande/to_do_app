part of 'add_tasks_bloc.dart';


sealed class AddTasksState {}

final class AddTasksInitial extends AddTasksState {}

class AddTaskLoading extends AddTasksState {}

class AddTaskSuccess extends AddTasksState {
  List<Tasks> task;
  Map<String, List<Tasks>> task1;
  AddTaskSuccess({required this.task,required this.task1});
}
class AddTaskSuccess1 extends AddTasksState {
}

class AddTaskFailed extends AddTasksState {}
class TasksDeleteLoading extends AddTasksState {}

class TasksDeleteSuccess extends AddTasksState {}

class TasksDeleteFailure extends AddTasksState {}

