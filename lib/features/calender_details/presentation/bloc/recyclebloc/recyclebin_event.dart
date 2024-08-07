part of 'recyclebin_bloc.dart';

class RecycleBinEvent {}

class GetBin extends RecycleBinEvent{}
class AddRecycleTask extends RecycleBinEvent {
  Tasks tasks;
  AddRecycleTask({required this.tasks});

}
class RecTaskDelete extends RecycleBinEvent {
  String id;
  RecTaskDelete({required this.id});
}
