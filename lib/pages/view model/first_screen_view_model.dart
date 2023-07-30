import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpodtestproject/pages/screens/second_screen.dart';
import '../../repository/entry_repository_impl.dart';
import '../../service/locator.dart';
import '../../service/navigation_service.dart';
var depenedebcy = getIt<EntryRepository>();

final entriesProvider = FutureProvider((ref) {

  final entryRepository = ref.watch(depenedebcy.entryRepositoryProvider);
  return entryRepository.allEntries();
});

final homePageControllerProvider = Provider((ref) {

  final entryRepository = ref.watch(depenedebcy.entryRepositoryProvider);
  return HomePageController(ref: ref, entryRepository: entryRepository);
});

class HomePageController {

  final ProviderRef ref;
  final EntryRepository entryRepository;

  HomePageController({required this.ref, required this.entryRepository});

  addEntry(String entry) {
    entryRepository.addEntry(entry);
    ref.refresh(entriesProvider);
  }

  removeEntry(String entry) {
    entryRepository.removeEntry(entry);
    ref.refresh(entriesProvider);
  }
}


NavigationService service = NavigationService();
onFirstScreenNavClicked() {
  NavigationService().navigateToScreen(const SecondScreen(),arguments: "hgghf");
}