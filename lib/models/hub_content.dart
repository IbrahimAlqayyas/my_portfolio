import 'metric_item.dart';
import 'service_item.dart';

class HubContent {
  final String badge;
  final String title;
  final String subtitle;
  final String bio;
  final String primaryBtnText;
  final String primaryBtnLink;
  final String secondaryBtnText;

  final List<MetricItem> metrics;

  final String servicesTitle;
  final String servicesSubtitle;
  final List<ServiceItem> services;

  final String featuredProjectsTitle;
  final String featuredProjectsSubtitle;

  final String featuredCoursesTitle;
  final String featuredCoursesSubtitle;

  final String toolingTitle;
  final String toolingSubtitle;
  final List<String> toolingList;

  final String ctaTitle;
  final String ctaDescription;
  final String ctaBtnText;
  final String ctaBtnLink;

  const HubContent({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.bio,
    required this.primaryBtnText,
    required this.primaryBtnLink,
    required this.secondaryBtnText,
    required this.metrics,
    required this.servicesTitle,
    required this.servicesSubtitle,
    required this.services,
    required this.featuredProjectsTitle,
    required this.featuredProjectsSubtitle,
    required this.featuredCoursesTitle,
    required this.featuredCoursesSubtitle,
    required this.toolingTitle,
    required this.toolingSubtitle,
    required this.toolingList,
    required this.ctaTitle,
    required this.ctaDescription,
    required this.ctaBtnText,
    required this.ctaBtnLink,
  });

  HubContent copyWith({
    String? badge,
    String? title,
    String? subtitle,
    String? bio,
    String? primaryBtnText,
    String? primaryBtnLink,
    String? secondaryBtnText,
    List<MetricItem>? metrics,
    String? servicesTitle,
    String? servicesSubtitle,
    List<ServiceItem>? services,
    String? featuredProjectsTitle,
    String? featuredProjectsSubtitle,
    String? featuredCoursesTitle,
    String? featuredCoursesSubtitle,
    String? toolingTitle,
    String? toolingSubtitle,
    List<String>? toolingList,
    String? ctaTitle,
    String? ctaDescription,
    String? ctaBtnText,
    String? ctaBtnLink,
  }) {
    return HubContent(
      badge: badge ?? this.badge,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      bio: bio ?? this.bio,
      primaryBtnText: primaryBtnText ?? this.primaryBtnText,
      primaryBtnLink: primaryBtnLink ?? this.primaryBtnLink,
      secondaryBtnText: secondaryBtnText ?? this.secondaryBtnText,
      metrics: metrics ?? this.metrics,
      servicesTitle: servicesTitle ?? this.servicesTitle,
      servicesSubtitle: servicesSubtitle ?? this.servicesSubtitle,
      services: services ?? this.services,
      featuredProjectsTitle: featuredProjectsTitle ?? this.featuredProjectsTitle,
      featuredProjectsSubtitle: featuredProjectsSubtitle ?? this.featuredProjectsSubtitle,
      featuredCoursesTitle: featuredCoursesTitle ?? this.featuredCoursesTitle,
      featuredCoursesSubtitle: featuredCoursesSubtitle ?? this.featuredCoursesSubtitle,
      toolingTitle: toolingTitle ?? this.toolingTitle,
      toolingSubtitle: toolingSubtitle ?? this.toolingSubtitle,
      toolingList: toolingList ?? this.toolingList,
      ctaTitle: ctaTitle ?? this.ctaTitle,
      ctaDescription: ctaDescription ?? this.ctaDescription,
      ctaBtnText: ctaBtnText ?? this.ctaBtnText,
      ctaBtnLink: ctaBtnLink ?? this.ctaBtnLink,
    );
  }

  Map<String, dynamic> toJson() => {
    'badge': badge,
    'title': title,
    'subtitle': subtitle,
    'bio': bio,
    'primaryBtnText': primaryBtnText,
    'primaryBtnLink': primaryBtnLink,
    'secondaryBtnText': secondaryBtnText,
    'metrics': metrics.map((m) => m.toJson()).toList(),
    'servicesTitle': servicesTitle,
    'servicesSubtitle': servicesSubtitle,
    'services': services.map((s) => s.toJson()).toList(),
    'featuredProjectsTitle': featuredProjectsTitle,
    'featuredProjectsSubtitle': featuredProjectsSubtitle,
    'featuredCoursesTitle': featuredCoursesTitle,
    'featuredCoursesSubtitle': featuredCoursesSubtitle,
    'toolingTitle': toolingTitle,
    'toolingSubtitle': toolingSubtitle,
    'toolingList': toolingList,
    'ctaTitle': ctaTitle,
    'ctaDescription': ctaDescription,
    'ctaBtnText': ctaBtnText,
    'ctaBtnLink': ctaBtnLink,
  };

  factory HubContent.fromJson(Map<String, dynamic> json) {
    return HubContent(
      badge: json['badge'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      primaryBtnText: json['primaryBtnText'] as String? ?? '',
      primaryBtnLink: json['primaryBtnLink'] as String? ?? '',
      secondaryBtnText: json['secondaryBtnText'] as String? ?? '',
      metrics:
          (json['metrics'] as List<dynamic>?)?.map((m) => MetricItem.fromJson(m as Map<String, dynamic>)).toList() ??
          [],
      servicesTitle: json['servicesTitle'] as String? ?? '',
      servicesSubtitle: json['servicesSubtitle'] as String? ?? '',
      services:
          (json['services'] as List<dynamic>?)?.map((s) => ServiceItem.fromJson(s as Map<String, dynamic>)).toList() ??
          [],
      featuredProjectsTitle: json['featuredProjectsTitle'] as String? ?? '',
      featuredProjectsSubtitle: json['featuredProjectsSubtitle'] as String? ?? '',
      featuredCoursesTitle: json['featuredCoursesTitle'] as String? ?? '',
      featuredCoursesSubtitle: json['featuredCoursesSubtitle'] as String? ?? '',
      toolingTitle: json['toolingTitle'] as String? ?? '',
      toolingSubtitle: json['toolingSubtitle'] as String? ?? '',
      toolingList: (json['toolingList'] as List<dynamic>?)?.map((t) => t.toString()).toList() ?? [],
      ctaTitle: json['ctaTitle'] as String? ?? '',
      ctaDescription: json['ctaDescription'] as String? ?? '',
      ctaBtnText: json['ctaBtnText'] as String? ?? '',
      ctaBtnLink: json['ctaBtnLink'] as String? ?? '',
    );
  }
}
