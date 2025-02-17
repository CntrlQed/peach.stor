import 'base_viewmodel.dart';

class NotificationViewModel extends BaseViewModel {
  void onNotificationTapped(String title) {
    // TODO: Handle notification tap
    setState(ViewState.busy);
    // Process notification
    setState(ViewState.idle);
  }
} 