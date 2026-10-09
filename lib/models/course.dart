class Course {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String category; // 'software' or 'engineering'
  final String categoryLabel;
  final String level;
  final String duration;
  final String badge;
  final List<String> topics;
  final List<String> features;
  final bool isFree;
  final String ctaText;
  final String? ctaUrl;
  final String icon;

  const Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.categoryLabel,
    required this.level,
    required this.duration,
    required this.badge,
    required this.topics,
    required this.features,
    this.isFree = false,
    required this.ctaText,
    this.ctaUrl,
    required this.icon,
  });
}
