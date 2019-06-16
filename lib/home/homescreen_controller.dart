import 'package:vote_app/base/base_controller.dart';
import 'package:vote_app/networking/providers/notification_api_provider.dart';
import 'package:vote_app/networking/response/notification_response.dart';
import 'package:vote_app/home/homescreen_view.dart';

class HomeSreenController extends BaseController{
  final HomeScreenState homeScreenState;
  NotificationApiProvider _notificationApiProvider = NotificationApiProvider();

  HomeSreenController({this.homeScreenState});

  @override
  void init() {
    fillNotifications();
  }

  void fillNotifications() {
    _notificationApiProvider.getNew().then((response) {
      homeScreenState.setNotifications(response);
    }).catchError((error) {
      homeScreenState.setNotifications(List<NotificationResponse>());
    });
  }


  void onTabTapped(int index) {
    homeScreenState.setCurrentIndex(index);
  }

  Future<bool> onWillPop() async {
    print(homeScreenState.getCurrentIndex());
    if (homeScreenState.getCurrentIndex() == 0)
      return true;
    else {
      homeScreenState.resetCurentIndex();
      return false;
    }
  }
}
