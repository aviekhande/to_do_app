part of 'task_bloc.dart';

class TaskEvent {}
class TaskAdd extends TaskEvent{
  Tasks task;
  TaskAdd({required this.task});
}
