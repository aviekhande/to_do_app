
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/repo/task_repo.dart';
import '../../../../home_screen/data/model/task_model.dart';
part 'add_tasks_event.dart';
part 'add_tasks_state.dart';

class AddTasksBloc extends Bloc<AddTasksEvent, AddTasksState> {
  final ProductRepo1 taskRepo;
  AddTasksBloc({required this.taskRepo}) : super(AddTasksInitial()) {
    on<TaskAdd1>(_onTaskAdd);
    on<EditTask>(_onTaskEdit);
    on<TaskAdd>(_onFetchTask);
    on<TaskDelete>(_onDeleteTask);
    on<TaskDone>(_onDoneTask);
    on<TaskUnDone>(_onUnDoneTask);
    on<ImpTask>(_onImpTask);
    on<TaskUnImp>(_onUnImpTask);
  }

  void _onImpTask(ImpTask event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.impTask(event.id);
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  void _onUnImpTask(TaskUnImp event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.unImpTask(event.id);
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  void _onTaskEdit(EditTask event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.editTask(event.task, event.index);
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  void _onDeleteTask(TaskDelete event, Emitter<AddTasksState> emit) async {
    emit(TasksDeleteLoading());
    List<Tasks> res = await taskRepo.removeTask(event.id);
    emit(TasksDeleteSuccess());
   emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  void _onDoneTask(TaskDone event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.doneTask(event.id, event.isDone);
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  void _onUnDoneTask(TaskUnDone event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.unDoneTask(event.id);
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }

  DateTime parseDate(String date) {
    final format = DateFormat("d MMM yyyy");
    return format.parse(date);
  }

  Map<String, List<Tasks>> groupTasksByDate(List<Tasks> tasks) {
    // Create a map to hold the grouped tasks
    Map<String, List<Tasks>> tasksByDate = {};

    for (var task in tasks) {
      String date = task.date ?? "1 Jan 1970";

      // If the date is not already a key, add it with an empty list
      if (!tasksByDate.containsKey(date)) {
        tasksByDate[date] = [];
      }

      // Add the task to the list corresponding to the date
      tasksByDate[date]!.add(task);
    }

    return tasksByDate;
  }

  List<Tasks> sortTasksByDate(List<Tasks> tasks) {
    List<Tasks> sortedTasks = List.from(tasks);

    sortedTasks.sort((a, b) {
      DateTime dateA = parseDate(a.date ?? "1 Jan 1970");
      DateTime dateB = parseDate(b.date ?? "1 Jan 1970");

      return dateA.compareTo(dateB);
    });

    return sortedTasks;
  }

  void _onFetchTask(TaskAdd event, Emitter<AddTasksState> emit) async {
    emit(AddTaskLoading());
    List<Tasks> task = await taskRepo.fetchTask();
    task = sortTasksByDate(task);
    log("${groupTasksByDate(task)}");
    emit(AddTaskSuccess(task: task ,task1: groupTasksByDate(task)));
  }

  void _onTaskAdd(TaskAdd1 event, Emitter<AddTasksState> emit) async {
    emit(AddTaskLoading());
    List<Tasks> res = await taskRepo.addTask(event.task);
    res = sortTasksByDate(res);
    emit(AddTaskSuccess1());
    emit(AddTaskSuccess(task: res, task1: groupTasksByDate(res)));
    // emit(AddTaskSuccess(task: groupTasksByDate(res)));
  }
}
