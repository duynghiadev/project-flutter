import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../../src/model/social_info.dart';

Future<List<SocialInfo>> loadSocialListFromYaml(String yamlPath) async {
  final data = await rootBundle.loadString(yamlPath);
  YamlList yamlList = loadYaml(data);

  final List<SocialInfo> socialInfos = <SocialInfo>[];

  for (final item in yamlList.value) {
    final socialInfo = SocialInfo(
      name: item['name'],
      url: item['url'],
      logoUri: item['logo_uri']
    );
    socialInfos.add(socialInfo);
  }
  return socialInfos;
}
