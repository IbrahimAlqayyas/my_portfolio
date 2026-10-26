class MetricItem {
  final String value;
  final String label;

  const MetricItem({
    required this.value,
    required this.label,
  });

  MetricItem copyWith({
    String? value,
    String? label,
  }) {
    return MetricItem(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toJson() => {
        'value': value,
        'label': label,
      };

  factory MetricItem.fromJson(Map<String, dynamic> json) {
    return MetricItem(
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }
}
