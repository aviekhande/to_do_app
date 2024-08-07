import 'package:bloc/bloc.dart';

import '../../../../core/repo/task_repo.dart';
import '../../../home_screen/data/model/task_model.dart';
import '../../data/datasource/get_important_task.dart';

part 'important_task_event.dart';
part 'important_task_state.dart';

class ImportantTaskBloc extends Bloc<ImportantTaskEvent, ImportantTaskState> {
  final ProductRepo1 taskRepo;
  ImportantTaskBloc({required this.taskRepo}) : super(ImportantTaskInitial()) {
    on<ImportantFetchTask>(_importantFetchTask);
    on<ImpTask1>(_onImpTask);
    on<UnImpTask1>(_onUnImpTask);
  }
  void _importantFetchTask(
      ImportantFetchTask event, Emitter<ImportantTaskState> emit) async {
    emit(ImportantTaskLoading());
    var res = await taskRepo.fetchTask1();
    List<Tasks> impTask = getImportTasks(res);
    emit(ImportantTask(task: impTask));
  }
  void _onImpTask(
      ImpTask1 event, Emitter<ImportantTaskState> emit) async {
    var res = await taskRepo.fetchTask1();
    List<Tasks> impTask = getImportTasks(res);
    emit(ImportantTask(task: impTask));
  }
  void _onUnImpTask(UnImpTask1 event, Emitter<ImportantTaskState> emit) async {
    var res = await taskRepo.fetchTask1();
    List<Tasks> impTask = getImportTasks(res);
    emit(ImportantTask(task: impTask));
  }
}
