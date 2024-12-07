class ProjectInfo {
  const ProjectInfo({
    required this.title,
    this.description,
    required this.technologies,
    required this.type,
    required this.isPet,
    required this.dateStart,
    this.dateEnd,
    this.githubUrl,
    this.playStoreUrl,
  });

  final String title;
  final String? description;
  final List<String> technologies;
  final String type;
  final bool isPet;

  final DateTime dateStart;
  final DateTime? dateEnd;

  final String? githubUrl;
  final String? playStoreUrl;

}
