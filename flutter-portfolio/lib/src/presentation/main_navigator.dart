import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/contact/contact_screen.dart';
import 'package:portfolio/src/presentation/home_contract.dart';
import 'package:portfolio/src/presentation/main_controller.dart';
import 'package:portfolio/src/presentation/main_provider.dart';
import 'package:portfolio/src/presentation/project/project_screen.dart';
import 'package:portfolio/utils/lib/provider/provider_ext.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../routes.dart';
import 'about/about_screen.dart';
import 'qualification/qualification_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> implements MainContract {
  late MainProvider mainProvider;

  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainProvider = context.provider();
    mainProvider.registerNavigator(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      initialScrollIndex: 0,
      itemScrollController: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        return VisibilityDetector(
          key: Key(index.toString()),
          onVisibilityChanged: (VisibilityInfo info) {
            if (info.visibleFraction > 0) {
              MainController.setIndexVisibility(index, info.visibleFraction);
            } else {
              MainController.removeIndexVisibility(index);
            }
          },
          child: _getScreen(index),
        );
      },
      itemCount: Routes.list.length,
    );
  }

  Widget _getScreen(int index) {
    switch (Routes.list[index]) {
      case Routes.ABOUT_SCREEN:
        return const AboutScreen();
      // case Routes.SKILL_SCREEN:
      //   return const SkillScreen();
      case Routes.PROJECT_SCREEN:
        return const ProjectScreen();
      case Routes.QUALIFICATION_SCREEN:
        return const QualificationScreen();
      case Routes.CONTACT_SCREEN:
        return const ContactScreen();
      default:
        return const AboutScreen();
    }
  }

  // Implement contracts
  @override
  void navigateTo(String route) {
    _scrollController.jumpTo(
      index: Routes.list.indexOf(route),
      // duration: const Duration(milliseconds: 300),
      // curve: Curves.easeInOutCubic,
    );
  }
}
