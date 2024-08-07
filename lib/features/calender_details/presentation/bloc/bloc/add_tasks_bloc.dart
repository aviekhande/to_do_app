import 'package:bloc/bloc.dart';
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
    emit(AddTaskSuccess(task: res));
  }

  void _onUnImpTask(TaskUnImp event, Emitter<AddTasksState> emit) async {
    List<Tasks> res = await taskRepo.unImpTask(event.id);
    emit(AddTaskSuccess(task: res));
  }
  void _onTaskEdit(EditTask event ,Emitter <AddTasksState>emit)async{
    List<Tasks> res = await taskRepo.editTask(event.task,event.index);
    emit(AddTaskSuccess(task: res));
      
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
    emit(AddTaskSuccess(task: task));
  }

  void _onTaskAdd(TaskAdd1 event, Emitter<AddTasksState> emit) async {
    emit(AddTaskLoading());
    List<Tasks> res = await taskRepo.addTask(event.task);
    emit(AddTaskSuccess1());
    emit(AddTaskSuccess(task: res));
  }
}
