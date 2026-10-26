import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/course.dart';
import '../../models/course_category.dart';
import '../../services/content_repository.dart';

class AdminCoursesTab extends StatefulComponent {
  const AdminCoursesTab({super.key});

  @override
  State<AdminCoursesTab> createState() => _AdminCoursesTabState();
}

class _AdminCoursesTabState extends State<AdminCoursesTab> {
  String _activeSection = 'courses'; // 'courses' or 'tabs'
  String _searchQuery = '';
  String _categoryFilter = 'all';

  // Category CRUD state
  bool _showAddCategory = false;
  String _newCatId = '';
  String _newCatLabel = '';
  String _newCatIcon = '📁';

  // Course Editor State
  bool _isEditing = false;
  Course? _currentCourse;

  String _fId = '';
  String _fTitle = '';
  String _fSubtitle = '';
  String _fDescription = '';
  String _fCategory = 'software';
  String _fCategoryLabel = 'Software & Mobile';
  String _fLevel = 'Intermediate to Advanced';
  String _fDuration = '10 Modules • 12 Hours';
  String _fBadge = 'Masterclass';
  String _fIcon = '📱';
  bool _fIsFree = false;
  String _fCtaText = 'Explore Syllabus & Enroll';
  String _fCtaUrl = '';
  String _fTopics = '';
  String _fFeatures = '';
  bool _fIsFeatured = false;

  String _val(dynamic e) => (e.target as dynamic)?.value?.toString() ?? '';
  bool _chk(dynamic e) => (e.target as dynamic)?.checked == true;

  void _openAddCourse() {
    setState(() {
      _isEditing = true;
      _currentCourse = null;
      _fId = 'course-${DateTime.now().millisecondsSinceEpoch}';
      _fTitle = '';
      _fSubtitle = '';
      _fDescription = '';
      _fCategory = 'software';
      _fCategoryLabel = 'Software & Mobile';
      _fLevel = 'Intermediate to Advanced';
      _fDuration = '10 Modules • 12 Hours';
      _fBadge = 'Masterclass';
      _fIcon = '📱';
      _fIsFree = false;
      _fCtaText = 'Explore Syllabus & Enroll';
      _fCtaUrl = '';
      _fTopics = '';
      _fFeatures = '';
      _fIsFeatured = false;
    });
  }

  void _openEditCourse(Course course) {
    setState(() {
      _isEditing = true;
      _currentCourse = course;
      _fId = course.id;
      _fTitle = course.title;
      _fSubtitle = course.subtitle;
      _fDescription = course.description;
      _fCategory = course.category;
      _fCategoryLabel = course.categoryLabel;
      _fLevel = course.level;
      _fDuration = course.duration;
      _fBadge = course.badge;
      _fIcon = course.icon;
      _fIsFree = course.isFree;
      _fCtaText = course.ctaText;
      _fCtaUrl = course.ctaUrl ?? '';
      _fTopics = course.topics.join('\n');
      _fFeatures = course.features.join('\n');
      _fIsFeatured = course.isFeatured;
    });
  }

  void _saveCourse() {
    if (_fTitle.trim().isEmpty) return;

    final id = _fId.trim().isEmpty
        ? _fTitle.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        : _fId.trim();

    final topicsList = _fTopics.split('\n').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    final featuresList = _fFeatures.split('\n').map((f) => f.trim()).where((f) => f.isNotEmpty).toList();

    final course = Course(
      id: id,
      title: _fTitle.trim(),
      subtitle: _fSubtitle.trim(),
      description: _fDescription.trim(),
      category: _fCategory.trim().toLowerCase(),
      categoryLabel: _fCategoryLabel.trim(),
      level: _fLevel.trim(),
      duration: _fDuration.trim(),
      badge: _fBadge.trim(),
      icon: _fIcon.trim().isEmpty ? '🎓' : _fIcon.trim(),
      isFree: _fIsFree,
      ctaText: _fCtaText.trim(),
      ctaUrl: _fCtaUrl.trim().isEmpty ? null : _fCtaUrl.trim(),
      topics: topicsList,
      features: featuresList,
      isFeatured: _fIsFeatured,
    );

    if (_currentCourse == null) {
      contentRepository.addCourse(course);
    } else {
      contentRepository.updateCourse(course);
    }

    setState(() {
      _isEditing = false;
      _currentCourse = null;
    });
  }

  @override
  Component build(BuildContext context) {
    if (_isEditing) {
      return _buildCourseEditorView();
    }

    return div(classes: 'admin-tab-pane', [
      // Sub-Navigation between Courses List and Course Categories (Tabs)
      div(classes: 'admin-subnav-bar', [
        button(
          classes: 'subnav-tab ${_activeSection == "courses" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeSection = 'courses')},
          [Component.text('🎓 Courses & Resource Cards (${contentRepository.courses.length})')],
        ),
        button(
          classes: 'subnav-tab ${_activeSection == "tabs" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeSection = 'tabs')},
          [Component.text('🏷️ Filter Tabs & Categories (${contentRepository.courseCategories.length})')],
        ),
      ]),

      if (_activeSection == 'courses') _buildCoursesListSection(),
      if (_activeSection == 'tabs') _buildCategoriesSection(),
    ]);
  }

  // --- SECTION: CATEGORIES / TABS MANAGER ---
  Component _buildCategoriesSection() {
    final categories = contentRepository.courseCategories;
    final allCourses = contentRepository.courses;

    return div(classes: 'admin-tab-pane', [
      div(classes: 'admin-section-header-split', [
        div([
          h3([Component.text('Course Filter Tabs Management (CRUD)')]),
          p([
            Component.text(
              'Manage the category tabs displayed in the Academy. Note: The "🌐 All Resources" tab is automatically created and updates automatically with course counts.',
            ),
          ]),
        ]),
        if (!_showAddCategory)
          button(
            classes: 'btn btn-primary',
            events: {'click': (e) => setState(() => _showAddCategory = true)},
            [Component.text('+ Add New Category Tab')],
          ),
      ]),

      // Static All Resources notice card
      div(classes: 'admin-card info-card', [
        div(classes: 'auto-tab-preview', [
          span(classes: 'tab-preview-icon', [Component.text('🌐')]),
          div([
            strong([Component.text('All Resources Tab (Automatic)')]),
            p([
              Component.text(
                'Always present as the first tab in the Academy. Automatically shows all ${allCourses.length} courses across every category.',
              ),
            ]),
          ]),
          span(classes: 'badge-pill-fixed', [Component.text('System Managed (Auto)')]),
        ]),
      ]),

      // Custom Categories CRUD List
      div(classes: 'admin-card', [
        if (_showAddCategory)
          div(classes: 'add-cat-form-box', [
            h4([Component.text('Create New Category Tab')]),
            div(classes: 'form-grid-3', [
              div(classes: 'form-group', [
                label([Component.text('Unique ID (e.g. software, engineering, automation)')]),
                input(
                  type: InputType.text,
                  classes: 'admin-input',
                  value: _newCatId,
                  events: {'input': (e) => _newCatId = _val(e)},
                ),
              ]),
              div(classes: 'form-group', [
                label([Component.text('Tab Display Label (e.g. Software & Flutter)')]),
                input(
                  type: InputType.text,
                  classes: 'admin-input',
                  value: _newCatLabel,
                  events: {'input': (e) => _newCatLabel = _val(e)},
                ),
              ]),
              div(classes: 'form-group', [
                label([Component.text('Icon (Emoji)')]),
                input(
                  type: InputType.text,
                  classes: 'admin-input',
                  value: _newCatIcon,
                  events: {'input': (e) => _newCatIcon = _val(e)},
                ),
              ]),
            ]),
            div(classes: 'inline-actions', [
              button(
                classes: 'btn btn-primary',
                events: {
                  'click': (e) {
                    if (_newCatId.trim().isNotEmpty && _newCatLabel.trim().isNotEmpty) {
                      contentRepository.addCourseCategory(CourseCategory(
                        id: _newCatId.trim().toLowerCase(),
                        label: _newCatLabel.trim(),
                        icon: _newCatIcon.trim().isEmpty ? '📁' : _newCatIcon.trim(),
                      ));
                      _newCatId = '';
                      _newCatLabel = '';
                      _newCatIcon = '📁';
                      _showAddCategory = false;
                      setState(() {});
                    }
                  },
                },
                [Component.text('Save Category Tab')],
              ),
              button(
                classes: 'btn btn-secondary',
                events: {'click': (e) => setState(() => _showAddCategory = false)},
                [Component.text('Cancel')],
              ),
            ]),
          ]),

        div(classes: 'categories-table', [
          for (var cat in categories)
            div(classes: 'cat-row-card', [
              div(classes: 'cat-info', [
                span(classes: 'cat-icon-badge', [Component.text(cat.icon)]),
                div([
                  strong([Component.text(cat.label)]),
                  span(classes: 'cat-id-code', [Component.text('ID: ${cat.id}')]),
                  span(classes: 'cat-count-pill', [
                    Component.text(
                      '${allCourses.where((c) => c.category.toLowerCase() == cat.id.toLowerCase()).length} courses assigned',
                    ),
                  ]),
                ]),
              ]),
              div(classes: 'cat-actions', [
                button(
                  classes: 'btn-icon-danger',
                  events: {
                    'click': (e) {
                      contentRepository.deleteCourseCategory(cat.id);
                      setState(() {});
                    },
                  },
                  [Component.text('🗑️ Delete Tab')],
                ),
              ]),
            ]),
        ]),
      ]),
    ]);
  }

  // --- SECTION: COURSES LIST ---
  Component _buildCoursesListSection() {
    final allCourses = contentRepository.rawCourses;
    final categories = contentRepository.courseCategories;

    final filtered = allCourses.where((c) {
      if (_categoryFilter != 'all' && c.category.toLowerCase() != _categoryFilter.toLowerCase()) {
        return false;
      }
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = c.title.toLowerCase().contains(q) ||
            c.subtitle.toLowerCase().contains(q) ||
            c.badge.toLowerCase().contains(q);
        if (!match) return false;
      }
      return true;
    }).toList();

    return div(classes: 'admin-tab-pane', [
      div(classes: 'admin-section-header-split', [
        div([
          h3([Component.text('Courses & Knowledge Hub Items')]),
          p([Component.text('Manage courses, certifications, curriculum bullet checklists, and card metadata.')]),
        ]),
        button(
          classes: 'btn btn-primary',
          events: {'click': (e) => _openAddCourse()},
          [Component.text('+ Add New Course / Resource')],
        ),
      ]),

      // Search & Category Filter Toolbar
      div(classes: 'admin-card', [
        div(classes: 'filter-bar-row', [
          div(classes: 'search-input-wrap', [
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _searchQuery,
              attributes: {'placeholder': '🔍 Search courses by title, badge, curriculum...'},
              events: {
                'input': (e) {
                  setState(() {
                    _searchQuery = _val(e);
                  });
                },
              },
            ),
          ]),
          div(classes: 'category-pills', [
            button(
              classes: 'btn-pill ${_categoryFilter == "all" ? "active" : ""}',
              events: {'click': (e) => setState(() => _categoryFilter = 'all')},
              [Component.text('All Resources (${allCourses.length})')],
            ),
            for (var cat in categories)
              button(
                classes: 'btn-pill ${_categoryFilter == cat.id ? "active" : ""}',
                events: {'click': (e) => setState(() => _categoryFilter = cat.id)},
                [Component.text('${cat.icon} ${cat.label} (${allCourses.where((c) => c.category.toLowerCase() == cat.id.toLowerCase()).length})')],
              ),
          ]),
        ]),
      ]),

      // Courses Grid
      div(classes: 'admin-card', [
        if (filtered.isEmpty)
          div(classes: 'empty-state', [
            p([Component.text('No courses match your current search or category filter.')]),
          ])
        else
          div(classes: 'admin-courses-grid', [
            for (var course in filtered)
              div(classes: 'admin-course-card ${course.isFeatured ? "featured-border" : ""}', [
                div(classes: 'course-card-top-bar', [
                  span(classes: 'course-icon-lg', [Component.text(course.icon)]),
                  div(classes: 'badges-wrap', [
                    span(classes: 'admin-badge-cat', [Component.text(course.badge)]),
                    if (course.isFree)
                      span(classes: 'free-pill', [Component.text('FREE')]),
                    if (course.isFeatured)
                      span(classes: 'featured-pill', [Component.text('⭐ Featured (1st)')]),
                  ]),
                ]),
                h4([Component.text(course.title)]),
                p(classes: 'course-sub', [Component.text(course.subtitle)]),
                div(classes: 'course-meta-pills', [
                  span(classes: 'meta-pill', [Component.text('⏱️ ${course.duration}')]),
                  span(classes: 'meta-pill', [Component.text('🎯 ${course.level}')]),
                  span(classes: 'meta-pill', [Component.text('📂 ${course.category}')]),
                ]),
                p(classes: 'item-desc-short', [Component.text(course.description)]),
                div(classes: 'curriculum-preview', [
                  strong([Component.text('Curriculum Topics (${course.topics.length}):')]),
                  ul(classes: 'preview-bullets', [
                    for (var t in course.topics.take(3))
                      li([Component.text('✓ $t')]),
                  ]),
                ]),
                div(classes: 'item-actions-footer', [
                  button(
                    classes: 'btn-action-featured ${course.isFeatured ? "active" : ""}',
                    events: {
                      'click': (e) {
                        contentRepository.toggleCourseFeatured(course.id);
                        setState(() {});
                      },
                    },
                    [Component.text(course.isFeatured ? '⭐ Featured' : '☆ Feature')],
                  ),
                  div(classes: 'btn-group-right', [
                    button(
                      classes: 'btn btn-outline-sm',
                      events: {'click': (e) => _openEditCourse(course)},
                      [Component.text('Edit ✏️')],
                    ),
                    button(
                      classes: 'btn-icon-danger',
                      events: {
                        'click': (e) {
                          contentRepository.deleteCourse(course.id);
                          setState(() {});
                        },
                      },
                      [Component.text('🗑️')],
                    ),
                  ]),
                ]),
              ]),
          ]),
      ]),
    ]);
  }

  // --- SECTION: COURSE FULL EDITOR ---
  Component _buildCourseEditorView() {
    final isNew = _currentCourse == null;
    final categories = contentRepository.courseCategories;

    return div(classes: 'admin-tab-pane', [
      div(classes: 'admin-section-header-split', [
        div([
          h3([Component.text(isNew ? 'Create New Course / Resource' : 'Edit Course: $_fTitle')]),
          p([Component.text('Customize course cards, topics checklist, CTA button, and level.')]),
        ]),
        div(classes: 'inline-actions', [
          button(
            classes: 'btn btn-secondary',
            events: {'click': (e) => setState(() => _isEditing = false)},
            [Component.text('Cancel')],
          ),
          button(
            classes: 'btn btn-primary',
            events: {'click': (e) => _saveCourse()},
            [Component.text('💾 Save Course')],
          ),
        ]),
      ]),

      div(classes: 'admin-card', [
        div(classes: 'form-grid-3', [
          div(classes: 'form-group', [
            label([Component.text('Course Icon (Emoji)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fIcon,
              events: {'input': (e) => _fIcon = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Unique ID / Slug')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fId,
              events: {'input': (e) => _fId = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Badge (e.g. Masterclass, Trending, Free Kit)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fBadge,
              events: {'input': (e) => _fBadge = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Course Title *')]),
          input(
            type: InputType.text,
            classes: 'admin-input',
            value: _fTitle,
            events: {'input': (e) => _fTitle = _val(e)},
          ),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Subtitle (Punchy one-liner)')]),
          input(
            type: InputType.text,
            classes: 'admin-input',
            value: _fSubtitle,
            events: {'input': (e) => _fSubtitle = _val(e)},
          ),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Category ID')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fCategory,
              attributes: {
                'placeholder': categories.map((c) => c.id).join(', '),
              },
              events: {'input': (e) => _fCategory = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Category Card Label (e.g. Flutter & Mobile, E&I QA/QC)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fCategoryLabel,
              events: {'input': (e) => _fCategoryLabel = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Level (e.g. Intermediate to Advanced, Professional)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fLevel,
              events: {'input': (e) => _fLevel = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Duration (e.g. 12 Modules • 14 Hours Video, Instant Download)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fDuration,
              events: {'input': (e) => _fDuration = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Description')]),
          textarea(
            classes: 'admin-textarea',
            events: {'input': (e) => _fDescription = _val(e)},
            [Component.text(_fDescription)],
          ),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Key Curriculum / Topics Checklist (one per line, shown with ✓)')]),
            textarea(
              classes: 'admin-textarea admin-textarea-lg',
              events: {'input': (e) => _fTopics = _val(e)},
              [Component.text(_fTopics)],
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Deliverables & Features (one per line)')]),
            textarea(
              classes: 'admin-textarea admin-textarea-lg',
              events: {'input': (e) => _fFeatures = _val(e)},
              [Component.text(_fFeatures)],
            ),
          ]),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('CTA Button Text (e.g. Explore Syllabus & Enroll)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fCtaText,
              events: {'input': (e) => _fCtaText = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('CTA Button URL (optional link)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fCtaUrl,
              attributes: {'placeholder': '/contact or external URL'},
              events: {'input': (e) => _fCtaUrl = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group-checkbox', [
            label(classes: 'checkbox-label', [
              input(
                type: InputType.checkbox,
                checked: _fIsFree,
                events: {
                  'change': (e) {
                    setState(() {
                      _fIsFree = _chk(e);
                    });
                  },
                },
              ),
              Component.text(' 🎁 Free Resource (styles button and badge in green neon)'),
            ]),
          ]),
          div(classes: 'form-group-checkbox', [
            label(classes: 'checkbox-label', [
              input(
                type: InputType.checkbox,
                checked: _fIsFeatured,
                events: {
                  'change': (e) {
                    setState(() {
                      _fIsFeatured = _chk(e);
                    });
                  },
                },
              ),
              Component.text(' ⭐ Highlight as Featured (Places this course FIRST in Academy)'),
            ]),
          ]),
        ]),

        div(classes: 'form-actions-bottom', [
          button(
            classes: 'btn btn-primary',
            events: {'click': (e) => _saveCourse()},
            [Component.text('💾 Save Course')],
          ),
          button(
            classes: 'btn btn-secondary',
            events: {'click': (e) => setState(() => _isEditing = false)},
            [Component.text('Cancel')],
          ),
        ]),
      ]),
    ]);
  }
}
