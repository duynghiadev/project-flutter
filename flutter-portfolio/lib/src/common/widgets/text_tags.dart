import 'package:flutter/material.dart';

class TextTags extends StatelessWidget {
  const TextTags({
    Key? key,
    required this.technologies,
    this.color,
  }) : super(key: key);

  final List<String> technologies;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (technologies.isEmpty) {
      return const SizedBox();
    }
    var combinedString = '';

    for (var tech in technologies) {
      combinedString += "#${tech.replaceAll(' ', '_')} ";
    }

    return Text(
      combinedString,
      style: TextStyle(
        color: color ?? Colors.black.withOpacity(0.7),
        fontSize: 10,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    );
  }
}
