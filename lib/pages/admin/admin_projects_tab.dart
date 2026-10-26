import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../components/video_embed_player.dart';
import '../../models/project.dart';
import '../../services/content_repository.dart';

class AdminProjectsTab extends StatefulComponent {
  const AdminProjectsTab({super.key});

  @override
  State<AdminProjectsTab> createState() => _AdminProjectsTabState();
}

class _AdminProjectsTabState extends State<AdminProjectsTab> {
  String _searchQuery = '';
  String _categoryFilter = 'all';

  // Modal / Form state for Add or Edit
  bool _isEditing = false;
  Project? _currentProject;

  // Form Fields
  String _fId = '';
  String _fTitle = '';
  String _fSubtitle = '';
  String _fShortDesc = '';
  String _fFullDesc = '';
  String _fCoverImage = '';
  String _fMainTag = '';
  String _fCategory = 'software';
  String _fTags = '';
  String _fClientOrScope = '';
  String _fDeliverables = '';
  String _fImages = '';
  String _fDemoUrl = '';
  String _fGithubUrl = '';
  String _fIntroVideoUrl = '';
  bool _fIsFeatured = false;

  String _val(dynamic e) => (e.target as dynamic)?.value?.toString() ?? '';
  bool _chk(dynamic e) => (e.target as dynamic)?.checked == true;

  void _openAddForm() {
    setState(() {
      _isEditing = true;
      _currentProject = null;
      _fId = 'project-${DateTime.now().millisecondsSinceEpoch}';
      _fTitle = '';
      _fSubtitle = '';
      _fShortDesc = '';
      _fFullDesc = '';
      _fCoverImage = 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80';
      _fMainTag = 'Mobile';
      _fCategory = 'software';
      _fTags = 'Flutter, Dart';
      _fClientOrScope = '';
      _fDeliverables = '';
      _fImages = '';
      _fDemoUrl = '';
      _fGithubUrl = '';
      _fIntroVideoUrl = '';
      _fIsFeatured = false;
    });
  }

  void _openEditForm(Project project) {
    setState(() {
      _isEditing = true;
      _currentProject = project;
      _fId = project.id;
      _fTitle = project.title;
      _fSubtitle = project.subtitle;
      _fShortDesc = project.shortDescription;
      _fFullDesc = project.fullDescription;
      _fCoverImage = project.coverImage;
      _fMainTag = project.mainTag;
      _fCategory = project.category;
      _fTags = project.tags.join(', ');
      _fClientOrScope = project.clientOrScope ?? '';
      _fDeliverables = project.deliverables.join('\n');
      _fImages = project.images.join(', ');
      _fDemoUrl = project.demoUrl ?? '';
      _fGithubUrl = project.githubUrl ?? '';
      _fIntroVideoUrl = project.primaryVideoUrl ?? '';
      _fIsFeatured = project.isFeatured;
    });
  }

  void _saveProject() {
    if (_fTitle.trim().isEmpty) return;

    final id = _fId.trim().isEmpty
        ? _fTitle.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        : _fId.trim();

    final tagsList = _fTags.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    final delivList = _fDeliverables.split('\n').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();
    final imgList = _fImages.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();

    final project = Project(
      id: id,
      title: _fTitle.trim(),
      subtitle: _fSubtitle.trim(),
      shortDescription: _fShortDesc.trim(),
      fullDescription: _fFullDesc.trim(),
      coverImage: _fCoverImage.trim(),
      mainTag: _fMainTag.trim(),
      category: _fCategory.trim().toLowerCase(),
      tags: tagsList,
      clientOrScope: _fClientOrScope.trim().isEmpty ? null : _fClientOrScope.trim(),
      deliverables: delivList,
      images: imgList,
      demoUrl: _fDemoUrl.trim().isEmpty ? null : _fDemoUrl.trim(),
      githubUrl: _fGithubUrl.trim().isEmpty ? null : _fGithubUrl.trim(),
      introVideoUrl: _fIntroVideoUrl.trim().isEmpty ? null : _fIntroVideoUrl.trim(),
      isFeatured: _fIsFeatured,
    );

    if (_currentProject == null) {
      contentRepository.addProject(project);
    } else {
      contentRepository.updateProject(project);
    }

    setState(() {
      _isEditing = false;
      _currentProject = null;
    });
  }

  @override
  Component build(BuildContext context) {
    if (_isEditing) {
      return _buildEditorView();
    }
    return _buildListView();
  }

  Component _buildListView() {
    final allProjects = contentRepository.rawProjects;
    final categories = contentRepository.projectCategories;

    final filtered = allProjects.where((proj) {
      if (_categoryFilter != 'all' && proj.category.toLowerCase() != _categoryFilter.toLowerCase()) {
        return false;
      }
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = proj.title.toLowerCase().contains(q) ||
            proj.subtitle.toLowerCase().contains(q) ||
            proj.mainTag.toLowerCase().contains(q) ||
            proj.tags.any((t) => t.toLowerCase().contains(q));
        if (!match) return false;
      }
      return true;
    }).toList();

    return div(classes: 'admin-tab-pane', [
      div(classes: 'admin-section-header-split', [
        div([
          h3([Component.text('Projects Manager (CRUD)')]),
          p([Component.text('Create, edit, delete, and prioritize projects. Categories defined here automatically create tabs in the Portfolio.')]),
        ]),
        button(
          classes: 'btn btn-primary',
          events: {'click': (e) => _openAddForm()},
          [Component.text('+ Add New Project')],
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
              attributes: {'placeholder': '🔍 Search projects by title, tag, client...'},
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
              [Component.text('All (${allProjects.length})')],
            ),
            for (var cat in categories)
              button(
                classes: 'btn-pill ${_categoryFilter == cat ? "active" : ""}',
                events: {'click': (e) => setState(() => _categoryFilter = cat)},
                [Component.text('$cat (${allProjects.where((item) => item.category.toLowerCase() == cat.toLowerCase()).length})')],
              ),
          ]),
        ]),
      ]),

      // Projects List Table / Cards
      div(classes: 'admin-card', [
        if (filtered.isEmpty)
          div(classes: 'empty-state', [
            p([Component.text('No projects match your current filters.')]),
          ])
        else
          div(classes: 'admin-projects-grid', [
            for (var project in filtered)
              div(classes: 'admin-item-card ${project.isFeatured ? "featured-border" : ""}', [
                div(classes: 'item-card-image', [
                  img(src: project.coverImage, alt: project.title),
                  div(classes: 'badge-pos-left', [
                    span(classes: 'admin-badge-cat', [Component.text(project.category.toUpperCase())]),
                  ]),
                  if (project.isFeatured)
                    div(classes: 'badge-pos-right', [
                      span(classes: 'featured-pill', [Component.text('⭐ Featured (First)')]),
                    ]),
                ]),
                div(classes: 'item-card-body', [
                  div(classes: 'item-tag-row', [
                    span(classes: 'admin-chip-small', [Component.text(project.mainTag)]),
                    if (project.clientOrScope != null)
                      span(classes: 'scope-text', [Component.text(project.clientOrScope!)]),
                  ]),
                  h4([Component.text(project.title)]),
                  p(classes: 'item-desc-short', [Component.text(project.shortDescription)]),
                  div(classes: 'tags-inline', [
                    for (var t in project.tags.take(4))
                      span(classes: 'tag-mini', [Component.text(t)]),
                  ]),
                  div(classes: 'item-actions-footer', [
                    button(
                      classes: 'btn-action-featured ${project.isFeatured ? "active" : ""}',
                      events: {
                        'click': (e) {
                          contentRepository.toggleProjectFeatured(project.id);
                          setState(() {});
                        },
                      },
                      [Component.text(project.isFeatured ? '⭐ Featured' : '☆ Feature')],
                    ),
                    div(classes: 'btn-group-right', [
                      button(
                        classes: 'btn btn-outline-sm',
                        events: {'click': (e) => _openEditForm(project)},
                        [Component.text('Edit ✏️')],
                      ),
                      button(
                        classes: 'btn-icon-danger',
                        events: {
                          'click': (e) {
                            contentRepository.deleteProject(project.id);
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
      ]),
    ]);
  }

  Component _buildEditorView() {
    final isNew = _currentProject == null;

    return div(classes: 'admin-tab-pane', [
      div(classes: 'admin-section-header-split', [
        div([
          h3([Component.text(isNew ? 'Create New Project' : 'Edit Project: $_fTitle')]),
          p([Component.text('Fill in project details, media URLs, tags, and category.')]),
        ]),
        div(classes: 'inline-actions', [
          button(
            classes: 'btn btn-secondary',
            events: {
              'click': (e) {
                setState(() => _isEditing = false);
              },
            },
            [Component.text('Cancel')],
          ),
          button(
            classes: 'btn btn-primary',
            events: {'click': (e) => _saveProject()},
            [Component.text('💾 Save Project')],
          ),
        ]),
      ]),

      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Project Title *')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fTitle,
              events: {'input': (e) => _fTitle = _val(e)},
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
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Subtitle')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fSubtitle,
              events: {'input': (e) => _fSubtitle = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Category (e.g. software, engineering, or new category name)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fCategory,
              attributes: {'placeholder': 'software, engineering, ai, etc.'},
              events: {'input': (e) => _fCategory = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Main Tag Badge (e.g. Mobile, Web / SaaS, Instrumentation)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fMainTag,
              events: {'input': (e) => _fMainTag = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Client or Scope (e.g. Fintech Startup MVP, EPC Refinery)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fClientOrScope,
              events: {'input': (e) => _fClientOrScope = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Cover Image URL')]),
          input(
            type: InputType.text,
            classes: 'admin-input',
            value: _fCoverImage,
            events: {'input': (e) => _fCoverImage = _val(e)},
          ),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Short Description (Shown on card)')]),
          textarea(
            classes: 'admin-textarea',
            events: {'input': (e) => _fShortDesc = _val(e)},
            [Component.text(_fShortDesc)],
          ),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Full Detailed Description (Shown on project detail page)')]),
          textarea(
            classes: 'admin-textarea admin-textarea-lg',
            events: {'input': (e) => _fFullDesc = _val(e)},
            [Component.text(_fFullDesc)],
          ),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Tags (comma separated)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fTags,
              events: {'input': (e) => _fTags = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Gallery Image URLs (comma separated)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fImages,
              events: {'input': (e) => _fImages = _val(e)},
            ),
          ]),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Key Deliverables (one per line)')]),
          textarea(
            classes: 'admin-textarea',
            events: {'input': (e) => _fDeliverables = _val(e)},
            [Component.text(_fDeliverables)],
          ),
        ]),

        div(classes: 'form-group', [
          label([Component.text('Intro / Walkthrough Video URL (YouTube, Google Drive, or MP4)')]),
          input(
            type: InputType.text,
            classes: 'admin-input',
            value: _fIntroVideoUrl,
            attributes: {'placeholder': 'e.g. https://www.youtube.com/watch?v=... or https://drive.google.com/file/d/.../view'},
            events: {
              'input': (e) {
                setState(() {
                  _fIntroVideoUrl = _val(e);
                });
              },
            },
          ),
          span(classes: 'hint-text', [
            Component.text('Paste a YouTube, Google Drive, or direct MP4 link. The embedded player will automatically detect the source and stream it with quality controls.'),
          ]),
          if (_fIntroVideoUrl.trim().isNotEmpty)
            div(classes: 'video-preview-box', [
              label([Component.text('Live Player Preview:')]),
              VideoEmbedPlayer(
                videoUrl: _fIntroVideoUrl.trim(),
                title: 'Project Video Preview',
              ),
            ]),
        ]),

        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('Live Demo URL (optional)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fDemoUrl,
              events: {'input': (e) => _fDemoUrl = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('GitHub URL (optional)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _fGithubUrl,
              events: {'input': (e) => _fGithubUrl = _val(e)},
            ),
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
            Component.text(' ⭐ Highlight as Featured (Places this project FIRST in Hub and Shared Portfolio)'),
          ]),
        ]),

        div(classes: 'form-actions-bottom', [
          button(
            classes: 'btn btn-primary',
            events: {'click': (e) => _saveProject()},
            [Component.text('💾 Save Project')],
          ),
          button(
            classes: 'btn btn-secondary',
            events: {
              'click': (e) {
                setState(() => _isEditing = false);
              },
            },
            [Component.text('Cancel')],
          ),
        ]),
      ]),
    ]);
  }
}
