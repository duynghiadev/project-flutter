import 'package:flutter/material.dart';
import 'package:portfolio/common/utils/framework/screen_size_x.dart';
import 'package:portfolio/common/utils/lang/datetime_ext.dart';
import 'package:portfolio/src/common/widgets/text_tags.dart';
import 'package:portfolio/src/presentation/qualification/job_period_list_provider.dart';
import 'package:portfolio/utils/lib/provider/provider_ext.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../model/job_period.dart';

class QualificationScreen extends StatefulWidget {
  const QualificationScreen({Key? key}) : super(key: key);

  @override
  State<QualificationScreen> createState() => _QualificationScreenState();
}

class _QualificationScreenState extends State<QualificationScreen> {
  late JobPeriodListProvider jobPeriodListProvider;
  late ColorScheme colorScheme;

  @override
  void didChangeDependencies() {
    jobPeriodListProvider = context.provider<JobPeriodListProvider>();
    colorScheme = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Qualification',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text('Education & Experience'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _educationSection(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _experienceSection(
                        jobPeriodList: jobPeriodListProvider.get()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }

  Widget _educationSection() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PTIT University',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            'Software Engineer',
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '2020-2024',
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _experienceSection({required List<JobPeriod> jobPeriodList}) {
    return SizedBox(
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < jobPeriodList.length; i++)
            TimelineTile(
              alignment: TimelineAlign.manual,
              endChild: Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${jobPeriodList[i].dateStart.toMonthYearString()} to ${jobPeriodList[i].dateEnd?.toMonthYearString() ?? "now"}"),
                    const SizedBox(height: 10),
                    _jobPeriodBlock(jobPeriod: jobPeriodList[i])
                  ],
                ),
              ),
              lineXY: 0,
              isFirst: i == 0,
              isLast: i == jobPeriodList.length - 1,
              indicatorStyle:
                  IndicatorStyle(indicatorXY: 0, color: colorScheme.primary),
            )
        ],
      ),
    );
  }

  Widget _jobPeriodBlock({required JobPeriod jobPeriod}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              jobPeriod.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            () {
              if (jobPeriod.role != null) {
                return Text(jobPeriod.role!);
              }
              return const SizedBox();
            }(),
            () {
              if (jobPeriod.description != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(jobPeriod.description!),
                );
              }
              return const SizedBox();
            }(),
            () {
              if (jobPeriod.technologies.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextTags(
                    technologies: jobPeriod.technologies,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                );
              }
              return const SizedBox();
            }(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
