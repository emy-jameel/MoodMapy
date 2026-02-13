import 'package:equatable/equatable.dart';

class AppSettingsState extends Equatable {
  final String language;
  final bool isDarkMode;
  final bool isLoading;

  const AppSettingsState({
    this.language = 'en',
    this.isDarkMode = false,
    this.isLoading = true,
  });

  AppSettingsState copyWith({
    String? language,
    bool? isDarkMode,
    bool? isLoading,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [language, isDarkMode, isLoading];
}
