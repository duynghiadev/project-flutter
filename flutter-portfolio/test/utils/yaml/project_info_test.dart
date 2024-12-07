import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/src/model/project_info.dart';
import 'package:portfolio/utils/yaml/load_project_list.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  var yamlPath = 'config/project_list.yaml';

  test('convert project list file yaml to model', () async {
    final data = await loadProjectListFromYaml(yamlPath);
    expect(data, isA<List<ProjectInfo>>());
    expect(data, isNotEmpty);
  });
}