class JobPeriod {
  const JobPeriod({
    required this.title,
    this.description,
    required this.role,
    required this.technologies,

    required this.dateStart,
    this.dateEnd,

    required this.isFreelanced,
  });

  final String title;
  final String? description;
  final String? role;
  final List<String> technologies;

  final DateTime dateStart;
  final DateTime? dateEnd;

  final bool? isFreelanced;
}
