import 'package:flutter/services.dart';
import 'package:portfolio/src/model/project_info.dart';
import 'package:portfolio/utils/datetime_helper.dart';
import 'package:yaml/yaml.dart';

Future<List<ProjectInfo>> loadProjectListFromYaml(String yamlPath) async {
  final data = await rootBundle.loadString(yamlPath);
  YamlList yamlList = loadYaml(data);

  final List<ProjectInfo> projectInfoList = <ProjectInfo>[];

  for (final item in yamlList.value) {
    final YamlList technologiesYamlList = item['technologies'];
    final dateStart = dateTimeFromYaml(item['date_start']);
    DateTime? dateEnd;
    if(item['date_end'] != null){
      dateEnd = dateTimeFromYaml(item['date_end']);
    }
    final socialInfo = ProjectInfo(
      title: item['title'],
      description: item['description'],
      technologies: technologiesYamlList.map((element) => element.toString()).toList(),
      type: item['type'],
      isPet: item['is_pet'],
      dateStart: dateStart,
      dateEnd: dateEnd,
      githubUrl: item['github_url'],
      playStoreUrl: item['play_store_url']
    );
    projectInfoList.add(socialInfo);
  }
  return projectInfoList;
}