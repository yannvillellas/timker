import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);
  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.controller.themeMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              value: _selectedTheme,
              onChanged: (ThemeMode? newThemeMode) {
                setState(() {
                  _selectedTheme = newThemeMode!;
                });
                widget.controller.updateThemeMode(newThemeMode);
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(
                    AppLocalizations.of(context)!.settingsSystemTheme,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(
                    AppLocalizations.of(context)!.settingsLightTheme,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(
                    AppLocalizations.of(context)!.settingsDarkTheme,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            DropdownButton<Locale>(
              value: Localizations.localeOf(context),
              onChanged: (Locale? newLocale) {
                if (newLocale == null) return;
                setState(() {});
              },
              items: [
                DropdownMenuItem(
                  value: const Locale('en', ''),
                  child: Text(
                    "English",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: const Locale('fr', ''),
                  child: Text(
                    "Français",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
