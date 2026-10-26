import 'dart:convert';

import '../data/courses_data.dart' as static_courses;
import '../data/hub_defaults.dart';
import '../data/projects_data.dart' as static_projects;
import '../models/course.dart';
import '../models/course_category.dart';
import '../models/hub_content.dart';
import '../models/project.dart';
import 'storage_service.dart';

class ContentRepository {
  static final ContentRepository _instance = ContentRepository._internal();
  factory ContentRepository() => _instance;
  ContentRepository._internal();

  bool _initialized = false;
  final List<void Function()> _listeners = [];

  late HubContent softwareHub;
  late HubContent engineeringHub;
  List<Project> _projects = [];
  List<Course> _courses = [];
  List<CourseCategory> _courseCategories = [];

  void addListener(void Function() listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  void _notify() {
    for (final listener in List.of(_listeners)) {
      listener();
    }
  }

  void init() {
    if (_initialized) return;
    _initialized = true;

    final savedJson = StorageService.loadContent();
    if (savedJson != null && savedJson.isNotEmpty) {
      try {
        final Map<String, dynamic> data = jsonDecode(savedJson) as Map<String, dynamic>;
        _loadFromJsonMap(data);
        return;
      } catch (e) {
        // Fallback to defaults if saved JSON is corrupted
      }
    }
    _loadDefaults();
  }

  void _loadDefaults() {
    softwareHub = defaultSoftwareHubContent;
    engineeringHub = defaultEngineeringHubContent;
    _projects = List<Project>.from(static_projects.projectsList);
    _courses = List<Course>.from(static_courses.coursesList);
    _courseCategories = List<CourseCategory>.from(defaultCourseCategories);
  }

  void _loadFromJsonMap(Map<String, dynamic> data) {
    if (data['softwareHub'] != null) {
      softwareHub = HubContent.fromJson(data['softwareHub'] as Map<String, dynamic>);
    } else {
      softwareHub = defaultSoftwareHubContent;
    }

    if (data['engineeringHub'] != null) {
      engineeringHub = HubContent.fromJson(data['engineeringHub'] as Map<String, dynamic>);
    } else {
      engineeringHub = defaultEngineeringHubContent;
    }

    if (data['projects'] != null) {
      _projects = (data['projects'] as List<dynamic>)
          .map((p) => Project.fromJson(p as Map<String, dynamic>))
          .toList();
    } else {
      _projects = List<Project>.from(static_projects.projectsList);
    }

    if (data['courses'] != null) {
      _courses = (data['courses'] as List<dynamic>)
          .map((c) => Course.fromJson(c as Map<String, dynamic>))
          .toList();
    } else {
      _courses = List<Course>.from(static_courses.coursesList);
    }

    if (data['courseCategories'] != null) {
      _courseCategories = (data['courseCategories'] as List<dynamic>)
          .map((cat) => CourseCategory.fromJson(cat as Map<String, dynamic>))
          .toList();
    } else {
      _courseCategories = List<CourseCategory>.from(defaultCourseCategories);
    }
  }

  void save() {
    final map = toJsonMap();
    StorageService.saveContent(jsonEncode(map));
    _notify();
  }

  void resetToDefaults() {
    StorageService.clearContent();
    _loadDefaults();
    _notify();
  }

  Map<String, dynamic> toJsonMap() {
    return {
      'version': '1.0',
      'softwareHub': softwareHub.toJson(),
      'engineeringHub': engineeringHub.toJson(),
      'projects': _projects.map((p) => p.toJson()).toList(),
      'courses': _courses.map((c) => c.toJson()).toList(),
      'courseCategories': _courseCategories.map((c) => c.toJson()).toList(),
    };
  }

  String exportJson() {
    return const JsonEncoder.withIndent('  ').convert(toJsonMap());
  }

  bool importJson(String rawJson) {
    try {
      final map = jsonDecode(rawJson) as Map<String, dynamic>;
      _loadFromJsonMap(map);
      save();
      return true;
    } catch (_) {
      return false;
    }
  }

  // --- PROJECTS ACCESSORS & CRUD ---

  /// All projects sorted so featured projects appear first
  List<Project> get projects {
    final list = List<Project>.from(_projects);
    list.sort((a, b) {
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      return 0;
    });
    return list;
  }

  List<Project> get rawProjects => _projects;

  List<Project> get softwareProjects =>
      projects.where((p) => p.category.toLowerCase() == 'software').toList();

  List<Project> get engineeringProjects =>
      projects.where((p) => p.category.toLowerCase() == 'engineering').toList();

  List<Project> getProjectsByCategory(String category) {
    if (category.toLowerCase() == 'all') return projects;
    return projects.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  Project? getProjectById(String id) {
    try {
      return _projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void addProject(Project project) {
    _projects.insert(0, project);
    save();
  }

  void updateProject(Project project) {
    final idx = _projects.indexWhere((p) => p.id == project.id);
    if (idx != -1) {
      _projects[idx] = project;
      save();
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    save();
  }

  void toggleProjectFeatured(String id) {
    final idx = _projects.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final current = _projects[idx];
      _projects[idx] = current.copyWith(isFeatured: !current.isFeatured);
      save();
    }
  }

  List<String> get projectCategories {
    final set = <String>{'software', 'engineering'};
    for (var p in _projects) {
      if (p.category.trim().isNotEmpty) {
        set.add(p.category.trim().toLowerCase());
      }
    }
    return set.toList();
  }

  // --- COURSES ACCESSORS & CRUD ---

  /// All courses sorted so featured courses appear first
  List<Course> get courses {
    final list = List<Course>.from(_courses);
    list.sort((a, b) {
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      return 0;
    });
    return list;
  }

  List<Course> get rawCourses => _courses;

  List<Course> get softwareCourses =>
      courses.where((c) => c.category.toLowerCase() == 'software').toList();

  List<Course> get engineeringCourses =>
      courses.where((c) => c.category.toLowerCase() == 'engineering').toList();

  List<Course> getCoursesByCategory(String category) {
    if (category.toLowerCase() == 'all') return courses;
    return courses.where((c) => c.category.toLowerCase() == category.toLowerCase()).toList();
  }

  Course? getCourseById(String id) {
    try {
      return _courses.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  void addCourse(Course course) {
    _courses.insert(0, course);
    save();
  }

  void updateCourse(Course course) {
    final idx = _courses.indexWhere((c) => c.id == course.id);
    if (idx != -1) {
      _courses[idx] = course;
      save();
    }
  }

  void deleteCourse(String id) {
    _courses.removeWhere((c) => c.id == id);
    save();
  }

  void toggleCourseFeatured(String id) {
    final idx = _courses.indexWhere((c) => c.id == id);
    if (idx != -1) {
      final current = _courses[idx];
      _courses[idx] = current.copyWith(isFeatured: !current.isFeatured);
      save();
    }
  }

  // --- COURSE CATEGORIES (TABS) CRUD ---

  List<CourseCategory> get courseCategories => _courseCategories;

  void addCourseCategory(CourseCategory category) {
    if (!_courseCategories.any((c) => c.id == category.id)) {
      _courseCategories.add(category);
      save();
    }
  }

  void updateCourseCategory(CourseCategory category) {
    final idx = _courseCategories.indexWhere((c) => c.id == category.id);
    if (idx != -1) {
      _courseCategories[idx] = category;
      save();
    }
  }

  void deleteCourseCategory(String id) {
    _courseCategories.removeWhere((c) => c.id == id);
    save();
  }

  // --- HUBS UPDATE METHODS ---

  void updateSoftwareHub(HubContent content) {
    softwareHub = content;
    save();
  }

  void updateEngineeringHub(HubContent content) {
    engineeringHub = content;
    save();
  }
}

final contentRepository = ContentRepository();
