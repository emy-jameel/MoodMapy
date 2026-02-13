import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(const AppSettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true));

    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('app_language') ?? 'en';
    final isDarkMode = prefs.getBool('is_dark_mode') ?? false;

    emit(
      state.copyWith(
        language: language,
        isDarkMode: isDarkMode,
        isLoading: false,
      ),
    );
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_language', lang);
    emit(state.copyWith(language: lang));
  }

  Future<void> toggleTheme() async {
    final newDarkMode = !state.isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', newDarkMode);
    emit(state.copyWith(isDarkMode: newDarkMode));
  }
}
