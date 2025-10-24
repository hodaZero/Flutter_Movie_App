import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;
  static const String key = 'theme_mode';

  ThemeCubit(this.prefs) : super(_getInitialTheme(prefs));

  static ThemeMode _getInitialTheme(SharedPreferences prefs) {
    final isDark = prefs.getBool(key) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final isCurrentlyDark = state == ThemeMode.dark;
    final newTheme = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    prefs.setBool(key, !isCurrentlyDark);
    emit(newTheme);
  }
}
