import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/src/model/social_info.dart';
import 'package:portfolio/utils/yaml/load_contact_list.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  var yamlPath = 'config/contact_list.yaml';

  test('convert valid yaml to model', () async {
    final data = await loadSocialListFromYaml(yamlPath);
    expect(data, isA<List<SocialInfo>>());
    expect(data, isNotEmpty);
  });

  // test('convert invalid yaml to model', () async {
  //   expect(() => fromYaml('invalid.yaml'), throwsA(isA<FormatException>()));
  // });
}
