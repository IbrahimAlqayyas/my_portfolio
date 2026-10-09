import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/course_card.dart';
import '../components/project_card.dart';
import '../constants/theme.dart';
import '../data/courses_data.dart';
import '../data/projects_data.dart';
import '../utils/scroll_helper.dart';

class SoftwareHub extends StatefulComponent {
  const SoftwareHub({super.key});

  @override
  State<SoftwareHub> createState() => _SoftwareHubState();

  @css
  static List<StyleRule> get styles => _SoftwareHubState.styles;
}

class _SoftwareHubState extends State<SoftwareHub> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    return section(classes: 'hub-container', [
      // Hero Section
      div(classes: 'hub-hero', [
        div(classes: 'hub-badge', [
          Component.text('📱 Software Engineering & Mobile Track'),
        ]),
        h1([Component.text('Flutter & Web Software Engineering')]),
        p(classes: 'hub-subtitle', [
          Component.text('Crafting High-Performance Cross-Platform Apps with Flutter & Dart'),
        ]),
        p(classes: 'hub-bio', [
          Component.text(
            'With +6 years of software experience, I build robust, beautiful mobile and web applications. From clean architecture and reactive state management to seamless offline synchronization and snappy web rendering, I deliver production software that scales.',
          ),
        ]),
        div(classes: 'hub-actions', [
          Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Hire for Mobile & Web Apps →')),
          a(
            href: '#software-projects',
            classes: 'btn btn-secondary',
            events: {
              'click': (e) {
                e.preventDefault();
                scrollToId('software-projects');
              },
            },
            [Component.text('View Apps & Code ↓')],
          ),
        ]),
      ]),

      // Metrics Bar
      div(classes: 'metrics-bar', [
        div(classes: 'metric-item', [
          h3([Component.text('6+ Years')]),
          p([Component.text('Software Engineering')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('100%')]),
          p([Component.text('Dart & Flutter Specialization')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('iOS & Android')]),
          p([Component.text('Cross-Platform Deployments')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('Clean Arch')]),
          p([Component.text('Scalable Enterprise Patterns')]),
        ]),
      ]),

      // Services Section
      div(classes: 'hub-section', [
        div(classes: 'section-header', [
          h2([Component.text('Software Development Services')]),
          p([Component.text('End-to-end technical solutions tailored for startups, businesses, and enterprise teams.')]),
        ]),
        div(classes: 'services-grid', [
          _ServiceCard(
            icon: '📱',
            title: 'Custom Mobile Applications',
            description:
                'Native-speed iOS and Android applications developed from Figma/wireframes into maintainable Flutter codebases.',
            features: const ['iOS & Android Stores', 'Offline-First Storage', 'Push Notifications & APIs'],
          ),
          _ServiceCard(
            icon: '⚡',
            title: 'Full-Stack Web & Jaspr Apps',
            description:
                'Lightning-fast web apps using Jaspr and modern Dart. Clean SSR, SEO optimization, and reactive front-ends.',
            features: const ['Server-Side Rendering', 'Zero Bloat Architecture', 'High Lighthouse Scores'],
          ),
          _ServiceCard(
            icon: '🚀',
            title: 'Startup MVP Acceleration',
            description:
                'Rapid prototyping and MVP development for founders who need to validate their product with real users quickly.',
            features: const ['Fast Time-to-Market', 'Payment Gateways', 'Scalable Architecture Base'],
          ),
          _ServiceCard(
            icon: '🛠️',
            title: 'Code Audit & Refactoring',
            description:
                'Transform legacy or sluggish codebases with Clean Architecture, Riverpod/Bloc state management, and strict testing.',
            features: const ['Performance Optimization', 'Bug Hunting & Overflow Fixes', 'Unit & Widget Testing'],
          ),
        ]),
      ]),

      // Section-Specific Portfolio (Sourced from shared projectsList)
      div(id: 'software-projects', classes: 'hub-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('Featured Software Projects')]),
            p([Component.text('Production mobile applications, web platforms, and industrial mobile solutions.')]),
          ]),
          Link(to: '/projects', classes: 'view-all-link', child: Component.text('View All in Shared Portfolio →')),
        ]),
        div(classes: 'projects-grid', [
          for (var project in softwareProjects) ProjectCard(project: project),
        ]),
      ]),

      // Section-Specific Courses & Resources (Sourced from shared coursesList)
      div(classes: 'hub-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('Software Courses & Developer Resources')]),
            p([Component.text('Free starter kits, architecture masterclasses, and in-depth Dart tutorials.')]),
          ]),
          Link(to: '/courses', classes: 'view-all-link', child: Component.text('View All in Academy →')),
        ]),
        div(classes: 'courses-grid', [
          for (var course in softwareCourses) CourseCard(course: course),
        ]),
      ]),

      // Tech Stack
      div(classes: 'hub-section tech-stack-section', [
        div(classes: 'section-header', [
          h2([Component.text('Core Technologies & Tooling')]),
          p([Component.text('My primary software development toolbox.')]),
        ]),
        div(classes: 'tech-badges', [
          for (var tech in [
            'Flutter',
            'Dart',
            'Jaspr',
            'Riverpod',
            'Bloc',
            'Firebase',
            'REST APIs',
            'GraphQL',
            'SQLite & Hive',
            'Git & GitHub Actions',
            'Figma to Code',
            'Clean Architecture',
          ])
            span(classes: 'tech-badge', [Component.text(tech)]),
        ]),
      ]),

      // Bottom CTA
      div(classes: 'hub-cta-box', [
        h2([Component.text('Ready to build your next mobile or web application?')]),
        p([Component.text('Let’s turn your product vision into a clean, high-performance Flutter reality.')]),
        Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Start a Software Project →')),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.hub-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.hub-hero', [
        css('&').styles(
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          textAlign: TextAlign.center,
          padding: Padding.symmetric(vertical: 4.rem, horizontal: 2.rem),
          margin: Margin.only(bottom: 3.rem),
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(0, 0, 0, 0.4)),
          raw: cardBackdropFilter,
        ),
        css('.hub-badge').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.12),
          color: primaryColor,
          padding: Padding.symmetric(vertical: 8.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.2.rem),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
        ),
        css('h1').styles(
          fontSize: 3.5.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.zero,
          lineHeight: 1.15.em,
        ),
        css('.hub-subtitle').styles(
          fontSize: 1.4.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          margin: Margin.symmetric(vertical: 1.rem),
        ),
        css('.hub-bio').styles(
          fontSize: 1.15.rem,
          lineHeight: 1.7.em,
          color: textMutedColor,
          maxWidth: 800.px,
          margin: Margin.only(bottom: 2.2.rem),
        ),
        css('.hub-actions', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            padding: Padding.symmetric(vertical: 14.px, horizontal: 28.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            fontWeight: FontWeight.w700,
            fontSize: 1.05.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 250)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.4)),
            ),
            css('&:hover').styles(
              backgroundColor: secondaryColor,
              color: textColor,
            ),
          ]),
          css('.btn-secondary', [
            css('&').styles(
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              color: textColor,
              border: Border.all(color: surfaceBorder, width: 1.px),
            ),
            css('&:hover').styles(
              raw: {'border-color': '#ffffff'},
            ),
          ]),
        ]),
      ]),
      css('.metrics-bar', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.spaceAround,
          width: 100.percent,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          padding: Padding.symmetric(vertical: 1.8.rem, horizontal: 1.rem),
          margin: Margin.only(bottom: 4.rem),
          boxSizing: BoxSizing.borderBox,
          gap: Gap.all(1.5.rem),
          raw: cardBackdropFilter,
        ),
        css('.metric-item', [
          css('&').styles(textAlign: TextAlign.center),
          css('h3').styles(
            fontSize: 2.2.rem,
            fontWeight: FontWeight.w800,
            color: primaryColor,
            margin: Margin.only(bottom: 0.3.rem),
          ),
          css('p').styles(
            fontSize: 0.95.rem,
            color: textMutedColor,
            fontWeight: FontWeight.w600,
            margin: Margin.zero,
          ),
        ]),
      ]),
      css('.hub-section', [
        css('&').styles(
          width: 100.percent,
          margin: Margin.only(bottom: 4.5.rem),
        ),
        css('.section-header', [
          css('&').styles(
            textAlign: TextAlign.center,
            margin: Margin.only(bottom: 2.5.rem),
          ),
          css('h2').styles(
            fontSize: 2.4.rem,
            fontWeight: FontWeight.w800,
            color: textColor,
            margin: Margin.only(bottom: 0.5.rem),
          ),
          css('p').styles(
            fontSize: 1.15.rem,
            color: textMutedColor,
            margin: Margin.zero,
          ),
        ]),
        css('.section-header-split', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.end,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(1.rem),
            margin: Margin.only(bottom: 2.5.rem),
            raw: {'border-bottom': '1px solid rgba(255, 255, 255, 0.08)'},
            padding: Padding.only(bottom: 1.rem),
          ),
          css('h2').styles(
            fontSize: 2.2.rem,
            fontWeight: FontWeight.w800,
            color: textColor,
            margin: Margin.only(bottom: 0.3.rem),
          ),
          css('p').styles(
            fontSize: 1.05.rem,
            color: textMutedColor,
            margin: Margin.zero,
          ),
          css('.view-all-link').styles(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 1.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('color', duration: Duration(milliseconds: 200)),
          ),
          css('.view-all-link:hover').styles(
            color: secondaryColor,
          ),
        ]),
        css('.services-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(1.5.rem),
          ),
        ]),
        css('.projects-grid, .courses-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
          ),
        ]),
      ]),
      css('.tech-stack-section', [
        css('.tech-badges', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(12.px),
            maxWidth: 800.px,
            margin: Margin.symmetric(horizontal: Unit.auto),
          ),
          css('.tech-badge').styles(
            padding: Padding.symmetric(vertical: 10.px, horizontal: 18.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            backgroundColor: cardBackground,
            border: Border.all(color: cardBorder, width: 1.px),
            color: textColor,
            fontSize: 0.95.rem,
            fontWeight: FontWeight.w600,
            raw: cardBackdropFilter,
          ),
        ]),
      ]),
      css('.hub-cta-box', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 900.px,
          backgroundColor: cardBackground,
          border: Border.all(color: primaryColor, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(3.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(251, 197, 26, 0.15)),
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 2.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('p').styles(
          fontSize: 1.15.rem,
          color: textMutedColor,
          margin: Margin.only(bottom: 2.rem),
        ),
        css('.btn').styles(
          display: Display.inlineFlex,
          padding: Padding.symmetric(vertical: 16.px, horizontal: 32.px),
          radius: BorderRadius.all(Radius.circular(14.px)),
          fontWeight: FontWeight.w700,
          fontSize: 1.1.rem,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          backgroundColor: primaryColor,
          color: backgroundColor,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.4)),
          transition: Transition('all', duration: Duration(milliseconds: 250)),
        ),
        css('.btn:hover').styles(
          backgroundColor: secondaryColor,
          color: textColor,
        ),
      ]),
    ]),
    ..._ServiceCard.styles,
    ...ProjectCard.styles,
    ...CourseCard.styles,
  ];
}

class _ServiceCard extends StatelessComponent {
  final String icon;
  final String title;
  final String description;
  final List<String> features;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });

  @override
  Component build(BuildContext context) {
    return div(classes: 'service-card', [
      span(classes: 'service-icon', [Component.text(icon)]),
      h3([Component.text(title)]),
      p([Component.text(description)]),
      ul(classes: 'service-features', [
        for (var f in features)
          li([
            span(classes: 'feat-bullet', [Component.text('✓')]),
            span([Component.text(f)]),
          ]),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.service-card', [
      css('&').styles(
        width: 260.px,
        backgroundColor: cardBackground,
        border: Border.all(color: cardBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(20.px)),
        padding: Padding.all(1.8.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.3)),
        raw: {
          ...cardBackdropFilter,
          'transition': 'all 0.3s ease',
        },
      ),
      css('&:hover').styles(
        raw: {
          'border-color': '#fbc51a',
          'transform': 'translateY(-4px)',
        },
      ),
      css('.service-icon').styles(
        fontSize: 2.4.rem,
        margin: Margin.only(bottom: 1.rem),
      ),
      css('h3').styles(
        fontSize: 1.25.rem,
        fontWeight: FontWeight.w700,
        color: textColor,
        margin: Margin.only(bottom: 0.6.rem),
      ),
      css('p').styles(
        fontSize: 0.92.rem,
        color: textMutedColor,
        lineHeight: 1.5.em,
        margin: Margin.only(bottom: 1.2.rem),
        flex: Flex(grow: 1),
      ),
      css('.service-features', [
        css('&').styles(
          listStyle: ListStyle.none,
          margin: Margin.zero,
          raw: {'border-top': '1px solid rgba(255, 255, 255, 0.06)'},
          padding: Padding.only(top: 1.rem),
        ),
        css('li', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            fontSize: 0.85.rem,
            color: textColor,
            margin: Margin.only(bottom: 6.px),
          ),
          css('.feat-bullet').styles(
            color: emeraldAccent,
            fontWeight: FontWeight.w800,
            margin: Margin.only(right: 6.px),
          ),
        ]),
      ]),
    ]),
  ];
}
