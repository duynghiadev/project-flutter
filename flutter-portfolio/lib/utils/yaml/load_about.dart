import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../../src/model/about.dart';

Future<About> loadAboutFromYaml(String yamlPath) async {
  final data = await rootBundle.loadString(yamlPath);
  YamlMap yamlMap = loadYaml(data);

  return About(
    shortName: yamlMap['short_name'],
    fullName: yamlMap['full_name'],
    shortIntro: yamlMap['short_intro'],
    longIntro: yamlMap['long_intro'],
  );
}
