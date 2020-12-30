import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_school_android/app_localizations.dart';
import 'package:my_school_android/ui/widgets/MyAppBarWidget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:stacked/stacked.dart';
import 'package:my_school_android/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'settings_view_model.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  changeLocale(Locale locale) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.locale = locale;
    appProvider.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) {
        AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
        if (appProvider.locale.languageCode == "en") model.currentLanguage = "English";
        if (appProvider.locale.languageCode == "fr") model.currentLanguage = "Francais";
        model.changeLocale = changeLocale;
      },
      builder: (
        BuildContext context,
        SettingsViewModel model,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBarWidget.header(context, AppLocalizations.of(context).translate('Settings')),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SettingsList(
              backgroundColor: Colors.transparent,
              sections: [
                SettingsSection(
                  // title: 'Section',
                  tiles: [
                    SettingsTile(
                      title: AppLocalizations.of(context).translate('Language'),
                      subtitle: model.currentLanguage,
                      leading: Icon(Icons.language),
                      onPressed: (BuildContext context) {
                        model.onLanguageClicked();
                      },
                    ),
                    SettingsTile.switchTile(
                      title: AppLocalizations.of(context).translate('Dark mode'),
                      leading: Icon(MdiIcons.themeLightDark),
                      switchValue: model.darkMode,
                      onToggle: model.onDrakModeClicked,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
