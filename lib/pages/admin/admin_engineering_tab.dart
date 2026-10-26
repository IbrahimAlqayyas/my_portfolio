import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../models/hub_content.dart';
import '../../models/metric_item.dart';
import '../../models/service_item.dart';
import '../../services/content_repository.dart';

class AdminEngineeringTab extends StatefulComponent {
  final HubContent initialContent;
  final void Function(HubContent) onChange;

  const AdminEngineeringTab({
    required this.initialContent,
    required this.onChange,
    super.key,
  });

  @override
  State<AdminEngineeringTab> createState() => _AdminEngineeringTabState();
}

class _AdminEngineeringTabState extends State<AdminEngineeringTab> {
  late HubContent _content;
  String _newStandardTag = '';

  // New service form state
  bool _showAddServiceModal = false;
  String _newServiceIcon = '📋';
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
    final engineeringProjects = contentRepository.engineeringProjects;
    final engineeringCourses = contentRepository.engineeringCourses;

    return div(classes: 'admin-tab-pane', [
      // SECTION 1: HERO
      _buildSectionHeader('1. Hero Section', 'Customize the top title, subtitle, badge and engineering introduction bio.'),
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

      // SECTION 2: METRICS BAR ("Second Card", QA/QC Experience & Figures)
      _buildSectionHeader('2. Metrics Bar (Second Card & Compliance Highlights)', 'Control the high-impact stat figures, years of plant experience, and QA/QC excellence.'),
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
              _buildInputGroup('Value (e.g. IEC & ATEX, 8+ Years)', _content.metrics[i].value, (val) {
                final list = List<MetricItem>.from(_content.metrics);
                list[i] = list[i].copyWith(value: val);
                _content = _content.copyWith(metrics: list);
                _notifyChange();
              }),
              _buildInputGroup('Label (e.g. Compliance Standards)', _content.metrics[i].label, (val) {
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
                  ..add(const MetricItem(value: '100%', label: 'QA/QC Verification'));
                _content = _content.copyWith(metrics: list);
                _notifyChange();
              },
            },
            [Component.text('+ Add Metric Item')],
          ),
        ]),
      ]),

      // SECTION 3: E&I ENGINEERING & CONSULTING SERVICES (CRUD)
      _buildSectionHeader('3. E&I Engineering & Consulting Services (CRUD)', 'Manage inspection and audit services offerings, descriptions, and feature deliverables.'),
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
            [Component.text('+ Add New Engineering Service')],
          )
        else
          div(classes: 'add-service-box', [
            h4([Component.text('Add New Engineering Service')]),
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
                        id: 'eng-service-${DateTime.now().millisecondsSinceEpoch}',
                        icon: _newServiceIcon.trim().isEmpty ? '⚡' : _newServiceIcon.trim(),
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

      // SECTION 4: FEATURED ENGINEERING PROJECTS (Highlight as Featured -> first in list)
      _buildSectionHeader('4. Featured E&I Projects & Case Studies', 'Toggle "Featured" to highlight an engineering project and place it FIRST in this section and in the Shared Portfolio.'),
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
            Component.text('⭐ Projects marked as Featured automatically appear at the very top of lists in both Engineering Hub and Shared Portfolio.'),
          ]),
          div(classes: 'items-order-list', [
            for (var project in engineeringProjects)
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

      // SECTION 5: ENGINEERING COURSES & RESOURCE PACKS (Highlight as Featured)
      _buildSectionHeader('5. Engineering Training & Quality Documentation Packs', 'Highlight engineering masterclasses and ITR templates to showcase first in the Academy.'),
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
          for (var course in engineeringCourses)
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

      // SECTION 6: STANDARDS & COMPLIANCE FRAMEWORKS
      _buildSectionHeader('6. Standards, Codes & Compliance Frameworks', 'Add, edit, or remove international engineering standards and codes.'),
      div(classes: 'admin-card', [
        div(classes: 'form-grid-2', [
          _buildInputGroup('Standards Section Title', _content.toolingTitle, (val) {
            _content = _content.copyWith(toolingTitle: val);
            _notifyChange();
          }),
          _buildInputGroup('Standards Subtitle', _content.toolingSubtitle, (val) {
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
              value: _newStandardTag,
              attributes: {'placeholder': 'Add standard (e.g. IEC 60079, ISO 9001, NFPA 70)...'},
              events: {
                'input': (e) => _newStandardTag = _val(e),
              },
            ),
            button(
              classes: 'btn btn-primary',
              events: {'click': (e) => _addStandardBadge()},
              [Component.text('+ Add Standard')],
            ),
          ]),
        ]),
      ]),

      // SECTION 7: BOTTOM CTA BOX
      _buildSectionHeader('7. Bottom CTA Box', 'Call-to-action banner at the bottom of the Engineering Hub.'),
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

  void _addStandardBadge() {
    if (_newStandardTag.trim().isNotEmpty) {
      final list = List<String>.from(_content.toolingList)..add(_newStandardTag.trim());
      _content = _content.copyWith(toolingList: list);
      _newStandardTag = '';
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
