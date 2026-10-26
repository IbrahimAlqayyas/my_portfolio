class Course {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String category; // 'software' or 'engineering' or custom
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
  final bool isFeatured;

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
    this.isFeatured = false,
  });

  Course copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? category,
    String? categoryLabel,
    String? level,
    String? duration,
    String? badge,
    List<String>? topics,
    List<String>? features,
    bool? isFree,
    String? ctaText,
    String? ctaUrl,
    String? icon,
    bool? isFeatured,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      level: level ?? this.level,
      duration: duration ?? this.duration,
      badge: badge ?? this.badge,
      topics: topics ?? this.topics,
      features: features ?? this.features,
      isFree: isFree ?? this.isFree,
      ctaText: ctaText ?? this.ctaText,
      ctaUrl: ctaUrl ?? this.ctaUrl,
      icon: icon ?? this.icon,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'category': category,
      'categoryLabel': categoryLabel,
      'level': level,
      'duration': duration,
      'badge': badge,
      'topics': topics,
      'features': features,
      'isFree': isFree,
      'ctaText': ctaText,
      'ctaUrl': ctaUrl,
      'icon': icon,
      'isFeatured': isFeatured,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'software',
      categoryLabel: json['categoryLabel'] as String? ?? 'Software & Mobile',
      level: json['level'] as String? ?? 'All Levels',
      duration: json['duration'] as String? ?? '',
      badge: json['badge'] as String? ?? 'Masterclass',
      topics: (json['topics'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      features: (json['features'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isFree: json['isFree'] as bool? ?? false,
      ctaText: json['ctaText'] as String? ?? 'Enroll Now',
      ctaUrl: json['ctaUrl'] as String?,
      icon: json['icon'] as String? ?? '🎓',
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
}
