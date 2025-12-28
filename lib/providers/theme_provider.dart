import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../util/design_constants.dart';

// This holds the actual logic for the theme
class ThemeNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void setTheme(int index) {
    state = index;
    DesignConstants.chosenTheme = index; 
    DesignConstants.updateTheme();
  }
}


final themeProvider = NotifierProvider<ThemeNotifier, int>(() {
  return ThemeNotifier();
});