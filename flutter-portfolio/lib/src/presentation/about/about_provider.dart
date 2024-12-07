import 'package:flutter/cupertino.dart';
import 'package:portfolio/utils/yaml/load_about.dart';

import '../../model/about.dart';

class AboutProvider extends ChangeNotifier {
  About _about =
      const About(shortName: '', fullName: '', shortIntro: '', longIntro: '');

  AboutProvider({
    String socialFilePath = 'config/about.yaml',
  }) {
    loadAboutFromYaml(socialFilePath).asStream().listen((item) {
      _about = item;
      notifyListeners();
    });
  }

  About get() => _about;
}
