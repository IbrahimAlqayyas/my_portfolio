class Project {
  final String id;
  final String title;
  final String subtitle;
  final String shortDescription;
  final String fullDescription;
  final String coverImage;
  final String mainTag;
  final List<String> tags;
  final List<String> images;
  final List<String> videos;
  final List<String> gifs;
  final String? demoUrl;
  final String? githubUrl;

  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortDescription,
    required this.fullDescription,
    required this.coverImage,
    required this.mainTag,
    required this.tags,
    this.images = const [],
    this.videos = const [],
    this.gifs = const [],
    this.demoUrl,
    this.githubUrl,
  });
}
