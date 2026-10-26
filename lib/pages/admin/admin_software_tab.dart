import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/hub_content.dart';
import '../../models/metric_item.dart';
import '../../models/service_item.dart';
import '../../services/content_repository.dart';

class AdminSoftwareTab extends StatefulComponent {
  final HubContent initialContent;
  final void Function(HubContent) onChange;

  const AdminSoftwareTab({
    required this.initialContent,
    required this.onChange,
    super.key,
  });

  @override
  State<AdminSoftwareTab> createState() => _AdminSoftwareTabState();
}

class _AdminSoftwareTabState extends State<AdminSoftwareTab> {
  late HubContent _content;
  String _newTechTag = '';

  // New service form state
  bool _showAddServiceModal = false;
  String _newServiceIcon = '📱';
  String _newServiceTitle = '';
  String _newServiceDesc = '';
  String _newServiceFeatures = '';

  @override
  void initState() {
    super.initState();
    _content = component.initialContent;
  }

  void _notifyChange() {
    component.onChange(_content);
    setState(() {});
  }

  String _val(dynamic e) => (e.target as dynamic)?.value?.toString() ?? '';

  @override
  Component build(BuildContext context) {
    final softwareProjects = contentRepository.softwareProjects;
    final softwareCourses = contentRepository.softwareCourses;

    return div(classes: 'admin-tab-pane', [
      // SECTION 1: HERO
      _buildSectionHeader('1. Hero Section', 'Customize the top title, subtitle, badge and introduction bio.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Badge Text', _content.badge, (val) {
            _content = _content.copyWith(badge: val);
            _notifyChange();
          }),
          _buildInputGroup('Primary Headline (H1)', _content.title, (val) {
            _content = _content.copyWith(title: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'form-group', [
          _buildInputGroup('Subtitle', _content.subtitle, (val) {
            _content = _content.copyWith(subtitle: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'form-group', [
          label([Component.text('Bio / Track Description')]),
          textarea(
            classes: 'admin-textarea',
            events: {
              'input': (e) {
                _content = _content.copyWith(bio: _val(e));
                _notifyChange();
              },
            },
            [Component.text(_content.bio)],
          ),
        ]),
        div(classes: 'form-grid-3', [
          _buildInputGroup('Primary Button Text', _content.primaryBtnText, (val) {
            _content = _content.copyWith(primaryBtnText: val);
            _notifyChange();
          }),
          _buildInputGroup('Primary Button Link', _content.primaryBtnLink, (val) {
            _content = _content.copyWith(primaryBtnLink: val);
            _notifyChange();
          }),
          _buildInputGroup('Secondary Button Text', _content.secondaryBtnText, (val) {
            _content = _content.copyWith(secondaryBtnText: val);
            _notifyChange();
          }),
        ]),
      ]),

      // SECTION 2: METRICS BAR ("Second Card", Years of Experience)
      _buildSectionHeader('2. Metrics Bar (Second Card & Experience)', 'Control the high-impact stat figures and experience highlights.'),
      div(classes: 'admin-card', [
        div(classes: 'metrics-editor-grid', [
          for (var i = 0; i < _content.metrics.length; i++)
            div(classes: 'metric-edit-card', [
              div(classes: 'metric-card-header', [
                span(classes: 'badge-num', [Component.text('Stat #${i + 1}')]),
                if (_content.metrics.length > 1)
                  button(
                    classes: 'btn-icon-danger',
                    events: {
                      'click': (e) {
                        final list = List<MetricItem>.from(_content.metrics)..removeAt(i);
                        _content = _content.copyWith(metrics: list);
                        _notifyChange();
                      },
                    },
                    [Component.text('✕')],
                  ),
              ]),
              _buildInputGroup('Value (e.g. 6+ Years)', _content.metrics[i].value, (val) {
                final list = List<MetricItem>.from(_content.metrics);
                list[i] = list[i].copyWith(value: val);
                _content = _content.copyWith(metrics: list);
                _notifyChange();
              }),
              _buildInputGroup('Label (e.g. Software Engineering)', _content.metrics[i].label, (val) {
                final list = List<MetricItem>.from(_content.metrics);
                list[i] = list[i].copyWith(label: val);
                _content = _content.copyWith(metrics: list);
                _notifyChange();
              }),
            ]),
        ]),
        div(classes: 'admin-card-actions', [
          button(
            classes: 'btn btn-outline',
            events: {
              'click': (e) {
                final list = List<MetricItem>.from(_content.metrics)
                  ..add(const MetricItem(value: 'New Metric', label: 'Description'));
                _content = _content.copyWith(metrics: list);
                _notifyChange();
              },
            },
            [Component.text('+ Add Metric Item')],
          ),
        ]),
      ]),

      // SECTION 3: SOFTWARE SERVICES (CRUD)
      _buildSectionHeader('3. Software Development Services', 'Manage services offerings, descriptions, and feature bullet checklists.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Services Section Title', _content.servicesTitle, (val) {
            _content = _content.copyWith(servicesTitle: val);
            _notifyChange();
          }),
          _buildInputGroup('Services Subtitle', _content.servicesSubtitle, (val) {
            _content = _content.copyWith(servicesSubtitle: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'services-list', [
          for (var i = 0; i < _content.services.length; i++)
            _buildServiceItemEditor(i, _content.services[i]),
        ]),
        if (!_showAddServiceModal)
          button(
            classes: 'btn btn-outline',
            events: {
              'click': (e) {
                setState(() {
                  _showAddServiceModal = true;
                });
              },
            },
            [Component.text('+ Add New Service Card')],
          )
        else
          div(classes: 'add-service-box', [
            h4([Component.text('Add New Software Service')]),
            div(classes: 'form-grid-2', [
              _buildInputGroup('Icon (Emoji)', _newServiceIcon, (val) => _newServiceIcon = val),
              _buildInputGroup('Service Title', _newServiceTitle, (val) => _newServiceTitle = val),
            ]),
            div(classes: 'form-group', [
              _buildInputGroup('Description', _newServiceDesc, (val) => _newServiceDesc = val),
            ]),
            div(classes: 'form-group', [
              _buildInputGroup('Feature Bullets (comma separated)', _newServiceFeatures, (val) => _newServiceFeatures = val),
            ]),
            div(classes: 'inline-actions', [
              button(
                classes: 'btn btn-primary',
                events: {
                  'click': (e) {
                    if (_newServiceTitle.trim().isNotEmpty) {
                      final feats = _newServiceFeatures
                          .split(',')
                          .map((f) => f.trim())
                          .where((f) => f.isNotEmpty)
                          .toList();
                      final newItem = ServiceItem(
                        id: 'soft-service-${DateTime.now().millisecondsSinceEpoch}',
                        icon: _newServiceIcon.trim().isEmpty ? '📱' : _newServiceIcon.trim(),
                        title: _newServiceTitle.trim(),
                        description: _newServiceDesc.trim(),
                        features: feats,
                      );
                      final list = List<ServiceItem>.from(_content.services)..add(newItem);
                      _content = _content.copyWith(services: list);
                      _showAddServiceModal = false;
                      _newServiceTitle = '';
                      _newServiceDesc = '';
                      _newServiceFeatures = '';
                      _notifyChange();
                    }
                  },
                },
                [Component.text('Save Service')],
              ),
              button(
                classes: 'btn btn-secondary',
                events: {
                  'click': (e) {
                    setState(() {
                      _showAddServiceModal = false;
                    });
                  },
                },
                [Component.text('Cancel')],
              ),
            ]),
          ]),
      ]),

      // SECTION 4: FEATURED SOFTWARE PROJECTS (Highlight as Featured -> first in list)
      _buildSectionHeader('4. Featured Software Projects', 'Toggle "Featured" to highlight a project and place it FIRST in this section and in the Shared Portfolio.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Section Title', _content.featuredProjectsTitle, (val) {
            _content = _content.copyWith(featuredProjectsTitle: val);
            _notifyChange();
          }),
          _buildInputGroup('Section Subtitle', _content.featuredProjectsSubtitle, (val) {
            _content = _content.copyWith(featuredProjectsSubtitle: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'featured-projects-manager', [
          p(classes: 'hint-text', [
            Component.text('⭐ Projects marked as Featured automatically appear at the very top of lists in both Software Hub and Shared Portfolio.'),
          ]),
          div(classes: 'items-order-list', [
            for (var project in softwareProjects)
              div(classes: 'order-item-row ${project.isFeatured ? "is-featured-row" : ""}', [
                div(classes: 'order-item-info', [
                  img(src: project.coverImage, alt: project.title, classes: 'item-thumb'),
                  div([
                    div(classes: 'item-title-wrap', [
                      strong([Component.text(project.title)]),
                      if (project.isFeatured)
                        span(classes: 'featured-pill', [Component.text('⭐ Featured (Placed 1st)')]),
                    ]),
                    span(classes: 'item-sub', [Component.text(project.subtitle)]),
                  ]),
                ]),
                button(
                  classes: 'btn ${project.isFeatured ? "btn-featured-active" : "btn-outline"}',
                  events: {
                    'click': (e) {
                      contentRepository.toggleProjectFeatured(project.id);
                      setState(() {});
                    },
                  },
                  [
                    Component.text(project.isFeatured ? '⭐ Featured (Click to Unmark)' : '☆ Mark as Featured'),
                  ],
                ),
              ]),
          ]),
        ]),
      ]),

      // SECTION 5: SOFTWARE COURSES & RESOURCES (Highlight as Featured)
      _buildSectionHeader('5. Software Courses & Developer Resources', 'Highlight courses to showcase first in the Academy.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Section Title', _content.featuredCoursesTitle, (val) {
            _content = _content.copyWith(featuredCoursesTitle: val);
            _notifyChange();
          }),
          _buildInputGroup('Section Subtitle', _content.featuredCoursesSubtitle, (val) {
            _content = _content.copyWith(featuredCoursesSubtitle: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'items-order-list', [
          for (var course in softwareCourses)
            div(classes: 'order-item-row ${course.isFeatured ? "is-featured-row" : ""}', [
              div(classes: 'order-item-info', [
                span(classes: 'item-icon-circle', [Component.text(course.icon)]),
                div([
                  div(classes: 'item-title-wrap', [
                    strong([Component.text(course.title)]),
                    if (course.isFeatured)
                      span(classes: 'featured-pill', [Component.text('⭐ Featured (Placed 1st)')]),
                  ]),
                  span(classes: 'item-sub', [Component.text(course.subtitle)]),
                ]),
              ]),
              button(
                classes: 'btn ${course.isFeatured ? "btn-featured-active" : "btn-outline"}',
                events: {
                  'click': (e) {
                    contentRepository.toggleCourseFeatured(course.id);
                    setState(() {});
                  },
                },
                [
                  Component.text(course.isFeatured ? '⭐ Featured (Click to Unmark)' : '☆ Mark as Featured'),
                ],
              ),
            ]),
        ]),
      ]),

      // SECTION 6: CORE TECHNOLOGIES & TOOLING
      _buildSectionHeader('6. Core Technologies & Tooling', 'Add, edit, or remove technologies and framework badges displayed in the toolbox.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Tooling Title', _content.toolingTitle, (val) {
            _content = _content.copyWith(toolingTitle: val);
            _notifyChange();
          }),
          _buildInputGroup('Tooling Subtitle', _content.toolingSubtitle, (val) {
            _content = _content.copyWith(toolingSubtitle: val);
            _notifyChange();
          }),
        ]),
        div(classes: 'badge-manager-container', [
          div(classes: 'badges-chips-wrap', [
            for (var i = 0; i < _content.toolingList.length; i++)
              span(classes: 'admin-chip', [
                Component.text(_content.toolingList[i]),
                button(
                  classes: 'chip-remove-btn',
                  events: {
                    'click': (e) {
                      final list = List<String>.from(_content.toolingList)..removeAt(i);
                      _content = _content.copyWith(toolingList: list);
                      _notifyChange();
                    },
                  },
                  [Component.text('×')],
                ),
              ]),
          ]),
          div(classes: 'add-badge-row', [
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _newTechTag,
              attributes: {'placeholder': 'Add new technology badge (e.g. Supabase, Docker, KMP)...'},
              events: {
                'input': (e) => _newTechTag = _val(e),
              },
            ),
            button(
              classes: 'btn btn-primary',
              events: {'click': (e) => _addTechBadge()},
              [Component.text('+ Add Tool')],
            ),
          ]),
        ]),
      ]),

      // SECTION 7: BOTTOM CTA BOX
      _buildSectionHeader('7. Bottom CTA Box', 'Call-to-action banner at the bottom of the Software Hub.'),
      div(classes: 'admin-card', [
        _buildInputGroup('CTA Title', _content.ctaTitle, (val) {
          _content = _content.copyWith(ctaTitle: val);
          _notifyChange();
        }),
        _buildInputGroup('CTA Description', _content.ctaDescription, (val) {
          _content = _content.copyWith(ctaDescription: val);
          _notifyChange();
        }),
        div(classes: 'form-grid-2', [
          _buildInputGroup('Button Text', _content.ctaBtnText, (val) {
            _content = _content.copyWith(ctaBtnText: val);
            _notifyChange();
          }),
          _buildInputGroup('Button Link', _content.ctaBtnLink, (val) {
            _content = _content.copyWith(ctaBtnLink: val);
            _notifyChange();
          }),
        ]),
      ]),
    ]);
  }

  void _addTechBadge() {
    if (_newTechTag.trim().isNotEmpty) {
      final list = List<String>.from(_content.toolingList)..add(_newTechTag.trim());
      _content = _content.copyWith(toolingList: list);
      _newTechTag = '';
      _notifyChange();
    }
  }

  Component _buildSectionHeader(String title, String subtitle) {
    return div(classes: 'admin-section-header', [
      h3([Component.text(title)]),
      p([Component.text(subtitle)]),
    ]);
  }

  Component _buildInputGroup(String labelText, String initialValue, void Function(String) onInput) {
    return div(classes: 'form-group', [
      label([Component.text(labelText)]),
      input(
        type: InputType.text,
        classes: 'admin-input',
        value: initialValue,
        events: {
          'input': (e) => onInput(_val(e)),
        },
      ),
    ]);
  }

  Component _buildServiceItemEditor(int index, ServiceItem service) {
    return div(classes: 'service-editor-card', [
      div(classes: 'service-editor-top', [
        span(classes: 'badge-num', [Component.text('Service #${index + 1}')]),
        button(
          classes: 'btn-icon-danger',
          events: {
            'click': (e) {
              final list = List<ServiceItem>.from(_content.services)..removeAt(index);
              _content = _content.copyWith(services: list);
              _notifyChange();
            },
          },
          [Component.text('✕ Delete Service')],
        ),
      ]),
      div(classes: 'form-grid-2', [
        _buildInputGroup('Icon', service.icon, (val) {
          final list = List<ServiceItem>.from(_content.services);
          list[index] = list[index].copyWith(icon: val);
          _content = _content.copyWith(services: list);
          _notifyChange();
        }),
        _buildInputGroup('Title', service.title, (val) {
          final list = List<ServiceItem>.from(_content.services);
          list[index] = list[index].copyWith(title: val);
          _content = _content.copyWith(services: list);
          _notifyChange();
        }),
      ]),
      _buildInputGroup('Description', service.description, (val) {
        final list = List<ServiceItem>.from(_content.services);
        list[index] = list[index].copyWith(description: val);
        _content = _content.copyWith(services: list);
        _notifyChange();
      }),
      _buildInputGroup('Features (comma separated)', service.features.join(', '), (val) {
        final feats = val.split(',').map((f) => f.trim()).where((f) => f.isNotEmpty).toList();
        final list = List<ServiceItem>.from(_content.services);
        list[index] = list[index].copyWith(features: feats);
        _content = _content.copyWith(services: list);
        _notifyChange();
      }),
    ]);
  }
}
