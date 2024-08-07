import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/repo/task_repo.dart';

import 'core/repo/recycle_repo.dart';

GetIt getIt = GetIt.instance;

void locatior() {
  getIt.registerLazySingleton(() => ProductRepo1());
  getIt.registerLazySingleton(() => ProductRepo());
}
