import 'package:bloc/bloc.dart';
import '../../../../../core/repo/recycle_repo.dart';
import '../../../../home_screen/data/model/task_model.dart';
part 'recyclebin_event.dart';
part 'recyclebin_state.dart';

class RecycleBinBloc extends Bloc<RecycleBinEvent, RecycleBinState> {
  final ProductRepo taskRepo;
  RecycleBinBloc({required this.taskRepo}) : super(RecycleBinInitial()) {
    on<AddRecycleTask>(_onAddRecycle);
    on<GetBin>(_onGetRecycle);
     on<RecTaskDelete>(_onDeleteTask);
  }
  void _onDeleteTask(RecTaskDelete event, Emitter<RecycleBinState> emit) async {
      // emit(TasksDeleteLoading());
    List<Tasks> res = await taskRepo.removeTask(event.id);
    // emit(TasksDeleteSuccess());
    emit(AddRecycleTaskState(tasks: res));
  }
  void _onGetRecycle(GetBin event, Emitter<RecycleBinState> emit) async {
    List<Tasks> task = await taskRepo.fetchTask();
     emit(AddRecycleTaskState(tasks: task));
  }
  void _onAddRecycle(
      AddRecycleTask event, Emitter<RecycleBinState> emit) async {
    emit(AddRecycleTaskLoading());
    List<Tasks> res = await taskRepo.addTask(event.tasks);
    emit(AddRecycleTaskState(tasks: res));
    emit(AddRecycleSuccess());
  }
}
