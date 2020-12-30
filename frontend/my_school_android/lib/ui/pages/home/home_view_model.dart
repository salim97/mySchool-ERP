import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/services/PushNotificationService.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final PushNotificationService _pushNotificationService = locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
    String token = await _pushNotificationService.fcm.getToken();
    print("token");
    print(token);
    // ...
  }
}
