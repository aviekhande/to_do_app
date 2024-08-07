part of 'important_task_bloc.dart';

class ImportantTaskState {}

final class ImportantTaskInitial extends ImportantTaskState {}
class ImportantTask extends ImportantTaskState {
  List<Tasks> task;
  ImportantTask({required this.task});
}
class ImportantTaskLoading extends ImportantTaskState{}
