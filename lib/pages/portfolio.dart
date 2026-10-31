import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/project_card.dart';
import '../constants/theme.dart';
import '../models/project.dart';
import '../services/content_repository.dart';
import '../utils/scroll_helper.dart';

class PortfolioPage extends StatefulComponent {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();

  @css
  static List<StyleRule> get styles => _PortfolioPageState.styles;
}

class _PortfolioPageState extends State<PortfolioPage> {
  String selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    scrollToTop();
    contentRepository.init();
    contentRepository.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    contentRepository.removeListener(_onContentChanged);
    super.dispose();
  }

  void _onContentChanged() {
    setState(() {});
  }

  List<Project> get filteredProjects {
    return contentRepository.getProjectsByCategory(selectedFilter);
  }

  String _formatCategoryLabel(String cat) {
    if (cat.toLowerCase() == 'software') return '💻 Mobile & Web Apps';
    if (cat.toLowerCase() == 'engineering') return '⚡ E&I Engineering';
    return '🚀 ${cat[0].toUpperCase()}${cat.substring(1)}';
  }

  @override
  Component build(BuildContext context) {
    final list = filteredProjects;
    final allProjects = contentRepository.projects;
    final categories = contentRepository.projectCategories;

    return section(classes: 'portfolio-container', [
      div(classes: 'page-header', [
        div(classes: 'header-badge', [
          Component.text('📂 Unified Portfolio Showcase'),
        ]),
        h1([Component.text('Projects & Case Studies')]),
        p(classes: 'header-subtitle', [
          Component.text(
            'Explore production Flutter mobile & web applications alongside industrial E&I construction, inspection, and QA/QC case studies.',
          ),
        ]),
      ]),

      // Interactive Dynamic Filter Tabs
      div(classes: 'filter-tabs', [
        button(
          classes: 'filter-btn ${selectedFilter == "all" ? "active" : ""}',
          events: {
            'click': (e) {
              setState(() {
                selectedFilter = 'all';
              });
            },
          },
          [
            Component.text('🌐 All Projects (${allProjects.length})'),
          ],
        ),
        for (var cat in categories)
          button(
            classes: 'filter-btn ${selectedFilter == cat ? "active" : ""}',
            events: {
              'click': (e) {
                setState(() {
                  selectedFilter = cat;
                });
              },
            },
            [
              Component.text(
                '${_formatCategoryLabel(cat)} (${allProjects.where((item) => item.category.toLowerCase() == cat.toLowerCase()).length})',
              ),
            ],
          ),
      ]),

      // Projects Grid
      div(classes: 'projects-grid', [
        for (var project in list) ProjectCard(project: project),
      ]),

      // Bottom Cross-Promotion
      div(classes: 'bottom-cta-banner', [
        h3([Component.text('Looking for educational resources or templates?')]),
        p([Component.text('Check out my comprehensive courses and free quality documentation packs.')]),
        div(classes: 'banner-actions', [
          Link(to: '/courses', classes: 'btn btn-primary', child: Component.text('Browse Courses & Resources →')),
          Link(to: '/contact', classes: 'btn btn-secondary', child: Component.text('Contact Ibrahim for Custom Scopes →')),
        ]),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.portfolio-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.page-header', [
        css('&').styles(
          textAlign: TextAlign.center,
          maxWidth: 800.px,
          margin: Margin.only(bottom: 2.5.rem),
        ),
        css('.header-badge').styles(
          display: Display.inlineFlex,
          backgroundColor: Color.rgba(251, 197, 26, 0.12),
          color: primaryColor,
          padding: Padding.symmetric(vertical: 6.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.9.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.rem),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
        ),
        css('h1').styles(
          fontSize: 3.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.header-subtitle').styles(
          fontSize: 1.15.rem,
          color: textMutedColor,
          lineHeight: 1.6.em,
        ),
      ]),
      css('.filter-tabs', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(12.px),
          margin: Margin.only(bottom: 3.rem),
        ),
        css('.filter-btn', [
          css('&').styles(
            padding: Padding.symmetric(vertical: 10.px, horizontal: 20.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            backgroundColor: cardBackground,
            border: Border.all(color: cardBorder, width: 1.px),
            color: textMutedColor,
            fontSize: 0.95.rem,
            fontWeight: FontWeight.w600,
            cursor: Cursor.pointer,
            transition: Transition('all', duration: Duration(milliseconds: 200)),
            raw: {
              ...cardBackdropFilter,
              'outline': 'none',
            },
          ),
          css('&:hover').styles(
            color: textColor,
            raw: {'border-color': '#fbc51a'},
          ),
          css('&.active').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            fontWeight: FontWeight.w700,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.35)),
            raw: {'border-color': '#fbc51a'},
          ),
        ]),
      ]),
      css('.projects-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
      ]),
      css('.bottom-cta-banner', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 900.px,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 30.px, color: Color.rgba(0, 0, 0, 0.3)),
          raw: cardBackdropFilter,
        ),
        css('h3').styles(
          fontSize: 1.6.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 0.6.rem),
        ),
        css('p').styles(
          fontSize: 1.05.rem,
          color: textMutedColor,
          margin: Margin.only(bottom: 1.8.rem),
        ),
        css('.banner-actions', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            padding: Padding.symmetric(vertical: 12.px, horizontal: 24.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontWeight: FontWeight.w700,
            fontSize: 0.95.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 12.px, color: Color.rgba(251, 197, 26, 0.3)),
            ),
            css('&:hover').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              raw: {'filter': 'brightness(1.12)'},
              shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 16.px, color: Color.rgba(251, 197, 26, 0.45)),
            ),
          ]),
          css('.btn-secondary', [
            css('&').styles(
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              color: textColor,
              border: Border.all(color: surfaceBorder, width: 1.px),
            ),
            css('&:hover').styles(
              raw: {'border-color': '#f8fafc'},
            ),
          ]),
        ]),
      ]),
    ]),
    ...ProjectCard.styles,
  ];
}
