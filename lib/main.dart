import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mood_map/app/home_page.dart';
import 'package:mood_map/core/theme/theme.dart';
import 'package:mood_map/features/data/local/hive_initializer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:mood_map/features/settings/cubit/app_settings_cubit.dart';
import 'package:mood_map/features/settings/cubit/app_settings_state.dart';
import 'package:mood_map/features/favorites/cubit/favorites_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:mood_map/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.init();
  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AppSettingsCubit>()..loadSettings()),
        BlocProvider(create: (_) => sl<FavoritesCubit>()),
        BlocProvider(create: (_) => sl<MoodCubit>()),
      ],
      child: const MoodMap(),
    ),
  );
}

class MoodMap extends StatelessWidget {
  const MoodMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final locale = Locale(state.language);
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          theme: MoodTheme.lightTheme(state.language),
          darkTheme: MoodTheme.darkTheme(state.language),
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,

          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
