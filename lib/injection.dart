import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/repo/task_repo.dart';

GetIt getIt = GetIt.instance;

void locatior() {
  getIt.registerLazySingleton(() => ProductRepo());
}
