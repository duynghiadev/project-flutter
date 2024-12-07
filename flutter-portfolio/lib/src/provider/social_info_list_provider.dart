import 'package:flutter/foundation.dart';
import 'package:portfolio/utils/yaml/load_contact_list.dart';

import '../model/social_info.dart';

class SocialInfoListProvider extends ChangeNotifier {
  List<SocialInfo> _socialInfoList = [];

  SocialInfoListProvider({
    String socialFilePath = 'config/contact_list.yaml',
  }) {
    loadSocialListFromYaml(socialFilePath).asStream().listen((item) {
      _socialInfoList = item;
      notifyListeners();
    });
  }

  List<SocialInfo> get() => _socialInfoList;
}
