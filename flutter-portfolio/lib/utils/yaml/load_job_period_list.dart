import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

import '../../src/model/job_period.dart';
import '../datetime_helper.dart';

Future<List<JobPeriod>> loadJobPeriodListFromYaml(String yamlPath) async {
  final data = await rootBundle.loadString(yamlPath);
  YamlList yamlList = loadYaml(data);

  final List<JobPeriod> projectInfoList = <JobPeriod>[];

  for (final item in yamlList.value) {
    final YamlList technologiesYamlList = item['technologies'];
    final dateStart = dateTimeFromYaml(item['date_start']);
    DateTime? dateEnd;
    if(item['date_end'] != null){
      dateEnd = dateTimeFromYaml(item['date_end']);
    }
    final socialInfo = JobPeriod(
        title: item['title'],
        description: item['description'],
        role: item['role'],
        technologies: technologiesYamlList.map((element) => element.toString()).toList(),
        dateStart: dateStart,
        dateEnd: dateEnd,
        isFreelanced: item['is_freelanced'],
    );
    projectInfoList.add(socialInfo);
  }
  return projectInfoList;
}