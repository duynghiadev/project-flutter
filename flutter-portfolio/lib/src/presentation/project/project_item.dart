import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/common/utils/lang/string_ext.dart';
import 'package:portfolio/src/common/widgets/text_tags.dart';
import 'package:portfolio/src/model/project_info.dart';
import 'package:portfolio/utils/open_link.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({
    Key? key,
    required this.projectInfo,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior,
    this.margin,
    this.semanticContainer = true,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);
  final double? width;
  final double? height;
  final ProjectInfo projectInfo;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: color ?? colorScheme.surface,
        shadowColor: shadowColor ?? colorScheme.shadow,
        surfaceTintColor: surfaceTintColor ?? colorScheme.surface,
        elevation: elevation ?? 7,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        borderOnForeground: borderOnForeground,
        margin: margin,
        clipBehavior: clipBehavior,
        semanticContainer: semanticContainer,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: _topSection(context: context),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    projectInfo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "${projectInfo.technologies[0].capitalize()} ${projectInfo.type.capitalize()}",
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topSection({required BuildContext context}) {
    List<Color> gradientColors() {
      if (projectInfo.technologies[0] == 'android') {
        return const [
          Color(0xffc1488d),
          Color(0xff964bc6),
        ];
      }
      if (projectInfo.technologies[0] == 'flutter') {
        return const [Color(0xff49aeff), Color(0xff72afff)];
      }
      return const [Color(0xff51a4e4), Color(0xff5aa1ff)];
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 5,
      ),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            colors: gradientColors(),
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _urlIcons(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 5),
              child: _description(),
            ),
          ),
          TextTags(
            technologies: projectInfo.technologies,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _urlIcons({double size = 22}) {
    return Row(children: [
      () {
        if (projectInfo.githubUrl != null) {
          return GestureDetector(
            onTap: () => OpenLink.openInNewTab(projectInfo.githubUrl),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Tooltip(
                message: projectInfo.githubUrl,
                child: SvgPicture.asset(
                  'logo/github.svg',
                  width: size,
                  height: size,
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      }(),
      () {
        if (projectInfo.playStoreUrl != null) {
          return GestureDetector(
            onTap: () => OpenLink.openInNewTab(projectInfo.playStoreUrl),
            child: Tooltip(
              message: projectInfo.playStoreUrl,
              child: SvgPicture.asset(
                'logo/google_play.svg',
                width: size,
                height: size,
              ),
            ),
          );
        }
        return const SizedBox();
      }()
    ]);
  }

  Widget _description() {
    if (projectInfo.description == null) {
      return const SizedBox();
    }
    return Text(
      projectInfo.description!,
      style: const TextStyle(color: Colors.white, height: 1.2),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
