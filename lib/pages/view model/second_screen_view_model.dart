import 'package:riverpodtestproject/pages/screens/first_screen.dart';
import '../../service/navigation_service.dart';

NavigationService service = NavigationService();
onSecondScreenNavClicked() {
  NavigationService().navigateToScreen(const FirstScreen(),arguments: "hgghf");
}