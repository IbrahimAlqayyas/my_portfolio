class CourseCategory {
  final String id;
  final String label;
  final String icon;

  const CourseCategory({
    required this.id,
    required this.label,
    required this.icon,
  });

  CourseCategory copyWith({
    String? id,
    String? label,
    String? icon,
  }) {
    return CourseCategory(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'icon': icon,
      };

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      icon: json['icon'] as String? ?? '📁',
    );
  }
}
