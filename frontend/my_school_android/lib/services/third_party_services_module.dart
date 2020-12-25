// run this command on terminal each time you edit this file
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';



@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackbarService;
  @lazySingleton
  BottomSheetService get bottomSheetService;
}
