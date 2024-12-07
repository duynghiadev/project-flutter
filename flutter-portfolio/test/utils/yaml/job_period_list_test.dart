import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/src/model/job_period.dart';
import 'package:portfolio/utils/yaml/load_job_period_list.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  var yamlPath = 'config/job_period_list.yaml';

  test('test yaml file: job period list', () async {
    final data = await loadJobPeriodListFromYaml(yamlPath);
    expect(data, isA<List<JobPeriod>>());
    expect(data, isNotEmpty);
  });
}
