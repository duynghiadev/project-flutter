import 'package:flutter/material.dart';
import 'package:portfolio/src/model/project_info.dart';
import 'package:portfolio/utils/yaml/load_project_list.dart';

class ProjectListProvider extends ChangeNotifier {
  List<ProjectInfo> _projectInfoList = [];

  ProjectListProvider({
    String socialFilePath = 'config/project_list.yaml',
  }) {
    loadProjectListFromYaml(socialFilePath).asStream().listen((item) {
      _projectInfoList = item;
      notifyListeners();
    });
  }

  List<ProjectInfo> get() => _projectInfoList;
}
