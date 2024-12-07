
import 'package:flutter/foundation.dart';
import 'package:portfolio/src/model/job_period.dart';
import 'package:portfolio/utils/yaml/load_job_period_list.dart';

class JobPeriodListProvider extends ChangeNotifier{

  List<JobPeriod> _jobPeriodList = [];

  JobPeriodListProvider({
    String socialFilePath = 'config/job_period_list.yaml',
  }) {
    loadJobPeriodListFromYaml(socialFilePath).asStream().listen((item) {
      _jobPeriodList = item;
      notifyListeners();
    });
  }

  List<JobPeriod> get() => _jobPeriodList;

}