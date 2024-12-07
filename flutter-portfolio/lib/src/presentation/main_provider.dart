import 'package:flutter/material.dart';
import 'package:portfolio/custom_themes.dart';
import 'package:portfolio/routes.dart';
import 'package:portfolio/src/presentation/home_contract.dart';

import '../../common/utils/logger/mixin_logger.dart';

class MainProvider extends ChangeNotifier with Logger {
  late MainContract mainContract;

  String _route = Routes.ABOUT_SCREEN;
  CustomTheme _theme = CustomTheme.light;

  get route => _route;
  get theme => _theme;
  get themeData => CustomThemes.getTheme(_theme);

  MainProvider({
    String route = Routes.ABOUT_SCREEN,
    CustomTheme theme = CustomTheme.light,
  }) {
    _route = route;
    _theme = theme;
  }

  void registerNavigator(MainContract mainNavigator) {
    mainContract = mainNavigator;
  }

  void setTheme(CustomTheme theme) {
    _theme = theme;
    notifyListeners();
  }

  void navigateToRoute(String route) {
    mainContract.navigateTo(route);
    _route = route;
    notifyListeners();
  }

  void setRoute(String route) {
    _route = route;
    // notifyListeners();
  }

  get currentRoute => _route;
}
