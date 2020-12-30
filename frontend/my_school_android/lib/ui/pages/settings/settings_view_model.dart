import 'package:flutter/cupertino.dart';
import 'package:my_school_android/app/locator.dart';
import 'package:my_school_android/setup_bottom_sheet_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  String currentLanguage = "English";
  bool darkMode = false;

  Function(Locale) changeLocale;

  onLanguageClicked() async {
    Map<String, dynamic> customData = {
      "English": {
        "code": "en",
         "selected": currentLanguage == "English" ? "true" :"false",
      },
      "Francais": {
        "code": "fr",
        "selected": currentLanguage == "Francais" ? "true" :"false",
      },
    };

    var response = await _bottomSheetService.showCustomSheet(
      title: "Languages",
      customData: customData,
      variant: BottomSheetType.FloatingBox,
    );
    print(response?.responseData);

    if (response != null) {
      if (response.responseData == "en") {
        currentLanguage = "English";
        changeLocale(Locale("en", "US"));
      }
      if (response.responseData == "fr") {
        currentLanguage = "Francais";
        changeLocale(Locale("fr", "FR"));
      }
    }

    notifyListeners();
  }

  onDrakModeClicked(bool value) {}
}
