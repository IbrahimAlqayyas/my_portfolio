class Project {
  final String id;
  final String title;
  final String subtitle;
  final String shortDescription;
  final String fullDescription;
  final String coverImage;
  final String mainTag;
  final String category; // 'software', 'engineering', or custom
  final List<String> tags;
  final List<String> images;
  final List<String> videos;
  final List<String> gifs;
  final String? demoUrl;
  final String? githubUrl;
  final String? clientOrScope;
  final List<String> deliverables;
  final bool isFeatured;

  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortDescription,
    required this.fullDescription,
    required this.coverImage,
    required this.mainTag,
    required this.category,
    required this.tags,
    this.images = const [],
    this.videos = const [],
    this.gifs = const [],
    this.demoUrl,
    this.githubUrl,
    this.clientOrScope,
    this.deliverables = const [],
    this.isFeatured = false,
  });

  Project copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? shortDescription,
    String? fullDescription,
    String? coverImage,
    String? mainTag,
    String? category,
    List<String>? tags,
    List<String>? images,
    List<String>? videos,
    List<String>? gifs,
    String? demoUrl,
    String? githubUrl,
    String? clientOrScope,
    List<String>? deliverables,
    bool? isFeatured,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      coverImage: coverImage ?? this.coverImage,
      mainTag: mainTag ?? this.mainTag,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      gifs: gifs ?? this.gifs,
      demoUrl: demoUrl ?? this.demoUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      clientOrScope: clientOrScope ?? this.clientOrScope,
      deliverables: deliverables ?? this.deliverables,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'coverImage': coverImage,
      'mainTag': mainTag,
      'category': category,
      'tags': tags,
      'images': images,
      'videos': videos,
      'gifs': gifs,
      'demoUrl': demoUrl,
      'githubUrl': githubUrl,
      'clientOrScope': clientOrScope,
      'deliverables': deliverables,
      'isFeatured': isFeatured,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      shortDescription: json['shortDescription'] as String? ?? '',
      fullDescription: json['fullDescription'] as String? ?? '',
      coverImage: json['coverImage'] as String? ?? '',
      mainTag: json['mainTag'] as String? ?? '',
      category: json['category'] as String? ?? 'software',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      videos: (json['videos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      gifs: (json['gifs'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      demoUrl: json['demoUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
      clientOrScope: json['clientOrScope'] as String?,
      deliverables: (json['deliverables'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
}
