class ServiceItem {
  final String id;
  final String icon;
  final String title;
  final String description;
  final List<String> features;

  const ServiceItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });

  ServiceItem copyWith({
    String? id,
    String? icon,
    String? title,
    String? description,
    List<String>? features,
  }) {
    return ServiceItem(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      features: features ?? this.features,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'icon': icon,
        'title': title,
        'description': description,
        'features': features,
      };

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['id'] as String? ?? '',
      icon: json['icon'] as String? ?? '⚡',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
