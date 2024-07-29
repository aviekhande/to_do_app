// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:to_do_app/core/repo/task_repo.dart';
// import 'package:to_do_app/features/home_screen/data/datasource/remote_get_tasks_datasource.dart';

// import '../../data/model/task_model.dart';

// part 'task_event.dart';
// part 'task_state.dart';

// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//   TaskBloc() : super(TaskInitial()) {
//     on<TaskAdd>(_onFetchTask);
//   }
//   void _onFetchTask(TaskAdd event, Emitter<TaskState> emit) async {
//     emit(TasksFetchLoading());
//     List<Tasks> task = await getTodoData();
//     log("${task}");
//     emit(TasksFetchSuccess(task: task));
//   }
// }
