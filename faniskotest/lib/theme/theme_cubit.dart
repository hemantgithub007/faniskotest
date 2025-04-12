import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Manages light/dark mode.
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    _loadTheme();  // Load saved theme on app start
  }

  void toggleTheme() async {
    final newTheme = !state;
    emit(newTheme);
    _saveTheme(newTheme);
  }

  // Save theme preference
  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  // Load theme preference
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;  // Default to light mode
    emit(isDark);
  }
}
