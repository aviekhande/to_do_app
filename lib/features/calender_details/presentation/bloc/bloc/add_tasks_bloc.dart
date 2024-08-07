import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:to_do_app/core/repo/task_repo.dart';
import '../../../../home_screen/data/model/task_model.dart';
part 'add_tasks_event.dart';
part 'add_tasks_state.dart';

class AddTasksBloc extends Bloc<AddTasksEvent, AddTasksState> {
  final ProductRepo1 taskRepo;
  AddTasksBloc({required this.taskRepo}) : super(AddTasksInitial()) {
    on<TaskAdd1>(_onTaskAdd);
    on<TaskAdd>(_onFetchTask);
    on<TaskDelete>(_onDeleteTask);
    on<TaskDone>(_onDoneTask);
    on<TaskUnDone>(_onUnDoneTask);
  }
  void _onDeleteTask(TaskDelete event, Emitter<AddTasksState> emit) async {
    emit(TasksDeleteLoading());
    List<Tasks> res = await taskRepo.removeTask(event.id);
    emit(TasksDeleteSuccess());
    emit(AddTaskSuccess(task: res));
  }

  void _onDoneTask(TaskDone event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.doneTask(event.id);
    emit(AddTaskSuccess(task: res));
  }

  void _onUnDoneTask(TaskUnDone event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.unDoneTask(event.id);
    emit(AddTaskSuccess(task: res));
  }

  void _onFetchTask(TaskAdd event, Emitter<AddTasksState> emit) async {
    emit(AddTaskLoading());
    List<Tasks> task = await taskRepo.fetchTask();
    log("${task}");
    emit(AddTaskSuccess(task: task));
  }

  void _onTaskAdd(TaskAdd1 event, Emitter<AddTasksState> emit) async {
    emit(AddTaskLoading());
    log("In OnTaskAdd");
    List<Tasks> res = await taskRepo.addTask(event.task);
    emit(AddTaskSuccess1());
    emit(AddTaskSuccess(task: res));
  }
}
