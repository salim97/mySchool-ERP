// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:my_school_erp/core/services/third_party_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<BottomSheetService>(
      () => thirdPartyServicesModule.bottomSheetService);

  //Eager singletons must be registered in the right order
  g.registerSingleton<DialogService>(thirdPartyServicesModule.dialogService);
  g.registerSingleton<NavigationService>(
      thirdPartyServicesModule.navigationService);
  g.registerSingleton<SnackbarService>(
      thirdPartyServicesModule.snackbarService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  BottomSheetService get bottomSheetService => BottomSheetService();
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
