import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/src/model/about.dart';
import 'package:portfolio/utils/yaml/load_about.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  var yamlPath = 'config/about.yaml';

  test('test yaml file: about', () async {
    final data = await loadAboutFromYaml(yamlPath);
    expect(data, isA<About>());
  });
}
