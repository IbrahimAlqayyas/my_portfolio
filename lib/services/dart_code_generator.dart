import '../models/course.dart';
import '../models/project.dart';

class DartCodeGenerator {
  static String generateProjectsDart(List<Project> projects) {
    final buffer = StringBuffer();
    buffer.writeln("import '../models/project.dart';\n");
    buffer.writeln('final List<Project> projectsList = [');
    for (var p in projects) {
      buffer.writeln('  Project(');
      buffer.writeln("    id: '${_escape(p.id)}',");
      buffer.writeln("    title: '${_escape(p.title)}',");
      buffer.writeln("    subtitle: '${_escape(p.subtitle)}',");
      buffer.writeln("    shortDescription: '${_escape(p.shortDescription)}',");
      buffer.writeln("    fullDescription: '''\n${p.fullDescription}\n''',");
      buffer.writeln("    coverImage: '${_escape(p.coverImage)}',");
      buffer.writeln("    mainTag: '${_escape(p.mainTag)}',");
      buffer.writeln("    category: '${_escape(p.category)}',");
      buffer.writeln("    tags: [${p.tags.map((t) => "'${_escape(t)}'").join(', ')}],");
      if (p.clientOrScope != null) {
        buffer.writeln("    clientOrScope: '${_escape(p.clientOrScope!)}',");
      }
      buffer.writeln("    deliverables: [${p.deliverables.map((d) => "'${_escape(d)}'").join(', ')}],");
      buffer.writeln("    images: [${p.images.map((i) => "'${_escape(i)}'").join(', ')}],");
      buffer.writeln("    videos: [${p.videos.map((v) => "'${_escape(v)}'").join(', ')}],");
      buffer.writeln("    gifs: [${p.gifs.map((g) => "'${_escape(g)}'").join(', ')}],");
      if (p.demoUrl != null) buffer.writeln("    demoUrl: '${_escape(p.demoUrl!)}',");
      if (p.githubUrl != null) buffer.writeln("    githubUrl: '${_escape(p.githubUrl!)}',");
      if (p.introVideoUrl != null && p.introVideoUrl!.isNotEmpty) {
        buffer.writeln("    introVideoUrl: '${_escape(p.introVideoUrl!)}',");
      }
      buffer.writeln('    isFeatured: ${p.isFeatured},');
      buffer.writeln('  ),');
    }
    buffer.writeln('];\n');
    buffer.writeln('List<Project> get softwareProjects =>');
    buffer.writeln("    projectsList.where((p) => p.category == 'software').toList();\n");
    buffer.writeln('List<Project> get engineeringProjects =>');
    buffer.writeln("    projectsList.where((p) => p.category == 'engineering').toList();\n");
    buffer.writeln('Project? getProjectById(String id) {');
    buffer.writeln('  try {');
    buffer.writeln('    return projectsList.firstWhere((p) => p.id == id);');
    buffer.writeln('  } catch (_) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('}');
    return buffer.toString();
  }

  static String generateCoursesDart(List<Course> courses) {
    final buffer = StringBuffer();
    buffer.writeln("import '../models/course.dart';\n");
    buffer.writeln('final List<Course> coursesList = [');
    for (var c in courses) {
      buffer.writeln('  Course(');
      buffer.writeln("    id: '${_escape(c.id)}',");
      buffer.writeln("    title: '${_escape(c.title)}',");
      buffer.writeln("    subtitle: '${_escape(c.subtitle)}',");
      buffer.writeln("    description: '${_escape(c.description)}',");
      buffer.writeln("    category: '${_escape(c.category)}',");
      buffer.writeln("    categoryLabel: '${_escape(c.categoryLabel)}',");
      buffer.writeln("    level: '${_escape(c.level)}',");
      buffer.writeln("    duration: '${_escape(c.duration)}',");
      buffer.writeln("    badge: '${_escape(c.badge)}',");
      buffer.writeln("    icon: '${_escape(c.icon)}',");
      buffer.writeln('    isFree: ${c.isFree},');
      buffer.writeln("    ctaText: '${_escape(c.ctaText)}',");
      if (c.ctaUrl != null) buffer.writeln("    ctaUrl: '${_escape(c.ctaUrl!)}',");
      buffer.writeln("    topics: [${c.topics.map((t) => "'${_escape(t)}'").join(', ')}],");
      buffer.writeln("    features: [${c.features.map((f) => "'${_escape(f)}'").join(', ')}],");
      if (c.introVideoUrl != null && c.introVideoUrl!.isNotEmpty) {
        buffer.writeln("    introVideoUrl: '${_escape(c.introVideoUrl!)}',");
      }
      buffer.writeln('    isFeatured: ${c.isFeatured},');
      if (c.chapters.isNotEmpty) {
        buffer.writeln('    chapters: [');
        for (var ch in c.chapters) {
          buffer.writeln('      CourseChapter(');
          buffer.writeln("        id: '${_escape(ch.id)}',");
          buffer.writeln("        title: '${_escape(ch.title)}',");
          if (ch.description != null && ch.description!.isNotEmpty) {
            buffer.writeln("        description: '${_escape(ch.description!)}',");
          }
          buffer.writeln('        lessons: [');
          for (var l in ch.lessons) {
            buffer.writeln('          CourseLesson(');
            buffer.writeln("            id: '${_escape(l.id)}',");
            buffer.writeln("            title: '${_escape(l.title)}',");
            buffer.writeln("            duration: '${_escape(l.duration)}',");
            buffer.writeln("            videoUrl: '${_escape(l.videoUrl)}',");
            buffer.writeln('            isFreePreview: ${l.isFreePreview},');
            if (l.notes != null && l.notes!.isNotEmpty) {
              buffer.writeln("            notes: '${_escape(l.notes!)}',");
            }
            buffer.writeln('          ),');
          }
          buffer.writeln('        ],');
          buffer.writeln('      ),');
        }
        buffer.writeln('    ],');
      }
      buffer.writeln('  ),');
    }
    buffer.writeln('];\n');
    buffer.writeln('List<Course> get softwareCourses =>');
    buffer.writeln("    coursesList.where((c) => c.category == 'software').toList();\n");
    buffer.writeln('List<Course> get engineeringCourses =>');
    buffer.writeln("    coursesList.where((c) => c.category == 'engineering').toList();\n");
    buffer.writeln('Course? getCourseById(String id) {');
    buffer.writeln('  try {');
    buffer.writeln('    return coursesList.firstWhere((c) => c.id == id);');
    buffer.writeln('  } catch (_) {');
    buffer.writeln('    return null;');
    buffer.writeln('  }');
    buffer.writeln('}');
    return buffer.toString();
  }

  static String _escape(String str) {
    return str.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
  }
}
