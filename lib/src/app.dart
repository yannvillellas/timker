import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'home/home_view.dart';

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  late final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) =>
            SettingsView(controller: settingsController),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('fr', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(
            primaryColor: Colors.purple,
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  bodyColor: Colors.purple,
                ),
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.purple,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  bodyColor: Colors.yellow,
                ),
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.yellow,
            ),
          ),
          themeMode: settingsController.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
