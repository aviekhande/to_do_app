import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/core/repo/task_repo.dart';

import '../../data/model/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskAdd>(_onfetchTask);
  }
  void _onfetchTask(TaskAdd event, Emitter <TaskState> emit){
    // emit(WishlistLoaded(productrepo.addProduct(event.product)));
    emit(TaskLoaded( tasks:ProductRepo().addTask(event.task)));
  }
}
