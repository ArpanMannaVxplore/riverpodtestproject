import 'package:get_it/get_it.dart';
import 'package:riverpodtestproject/repository/entry_repository_impl.dart';

GetIt getIt = GetIt.instance;

void locator (){

  getIt.registerLazySingleton(() => EntryRepository());
}