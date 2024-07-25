part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}
class TaskLoaded extends TaskState{
  final List<Tasks> tasks;
  TaskLoaded({required this.tasks});

}
