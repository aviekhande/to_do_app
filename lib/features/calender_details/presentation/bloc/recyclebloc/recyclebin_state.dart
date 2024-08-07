part of 'recyclebin_bloc.dart';

 class RecycleBinState {}

 class RecycleBinInitial extends RecycleBinState {}
class AddRecycleTaskState extends RecycleBinState{
    List<Tasks> tasks;
    AddRecycleTaskState({required this.tasks});
}
class AddRecycleTaskLoading extends RecycleBinState{
}

class AddRecycleSuccess extends RecycleBinState{
}

