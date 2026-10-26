import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/course_card.dart';
import '../components/project_card.dart';
import '../constants/theme.dart';
import '../data/courses_data.dart';
import '../data/projects_data.dart';
import '../utils/scroll_helper.dart';

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  @css
  static List<StyleRule> get styles => _HomeState.styles;
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    // Select top 4 featured projects (2 software, 2 engineering)
    final featuredProjects = [
      projectsList.firstWhere((proj) => proj.id == 'ai-analytics-suite', orElse: () => projectsList.first),
      projectsList.firstWhere((proj) => proj.id == 'fieldinspect-mobile-suite', orElse: () => projectsList.length > 1 ? projectsList[1] : projectsList.first),
      projectsList.firstWhere((proj) => proj.id == 'refinery-turnaround-inspection', orElse: () => projectsList.length > 2 ? projectsList[2] : projectsList.first),
      projectsList.firstWhere((proj) => proj.id == 'atex-hazardous-area-audit', orElse: () => projectsList.length > 3 ? projectsList[3] : projectsList.first),
    ];

    // Select top courses from both tracks
    final featuredCourses = [
      coursesList.firstWhere((crs) => crs.id == 'flutter-clean-architecture-course', orElse: () => coursesList.first),
      coursesList.firstWhere((crs) => crs.id == 'ei-inspection-qaqc-masterclass', orElse: () => coursesList.length > 1 ? coursesList[1] : coursesList.first),
      coursesList.firstWhere((crs) => crs.id == 'ei-itr-mdr-documentation-pack', orElse: () => coursesList.length > 2 ? coursesList[2] : coursesList.first),
    ];

    return section(classes: 'home-container', [
      // Master Portal Hero
      div(classes: 'hero-section', [
        div(classes: 'hero-badge', [
          Component.text('⚡ Dual-Track Professional Portfolio'),
        ]),
        h1([Component.text('Ibrahim AlQyas')]),
        p(classes: 'hero-title', [
          Component.text('Engineering Specialist & Software Engineer'),
        ]),
        p(classes: 'hero-bio', [
          Component.text(
            'Bridging two high-precision disciplines: Delivering technical excellence in industrial Electrical & Instrumentation (E&I) construction & inspection, and engineering cutting-edge mobile & web apps with Flutter & Dart.',
          ),
        ]),

        // Dual-Track Gateways
        div(classes: 'gateway-cards', [
          // Gateway 1: Software & Flutter
          Link(
            to: '/software',
            child: div(classes: 'gateway-card card-software', [
              div(classes: 'gateway-icon-badge', [Component.text('📱')]),
              h3([Component.text('Software & Flutter Hub')]),
              p([
                Component.text(
                  'Explore production mobile & web applications, Clean Architecture patterns, and Flutter courses.',
                ),
              ]),
              span(classes: 'gateway-link', [Component.text('Enter Software Hub →')]),
            ]),
          ),

          // Gateway 2: E&I Engineering
          Link(
            to: '/engineering',
            child: div(classes: 'gateway-card card-engineering', [
              div(classes: 'gateway-icon-badge', [Component.text('⚡')]),
              h3([Component.text('E&I Engineering Hub')]),
              p([
                Component.text(
                  'Explore industrial inspection case studies, ATEX/IECEx compliance, ITR & MDR quality consulting.',
                ),
              ]),
              span(classes: 'gateway-link', [Component.text('Enter Engineering Hub →')]),
            ]),
          ),
        ]),
      ]),

      // The Intersection Spotlight Section
      div(classes: 'intersection-banner', [
        div(classes: 'intersection-badge', [
          Component.text('💡 The Competitive Edge'),
        ]),
        h2([Component.text('Where Engineering Rigor Meets Digital Innovation')]),
        p(classes: 'intersection-text', [
          Component.text(
            'Very few software engineers understand hazardous areas, loop checks, and plant safety standards. And very few site inspectors know how to build modern offline-first apps. I leverage this rare intersection to build specialized industrial tools and write clean, resilient software.',
          ),
        ]),
        div(classes: 'intersection-cta', [
          Link(
            to: '/projects/fieldinspect-mobile-suite',
            classes: 'btn btn-intersection',
            child: Component.text('Explore "FieldInspect" Case Study →'),
          ),
        ]),
      ]),

      // Shared Featured Projects Section
      div(id: 'projects', classes: 'home-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('Featured Work Across Both Disciplines')]),
            p([Component.text('A curated showcase of mobile apps, web platforms, and industrial E&I audits.')]),
          ]),
          Link(to: '/projects', classes: 'view-all-link', child: Component.text('View All 8 Projects in Shared Portfolio →')),
        ]),

        div(classes: 'projects-grid', [
          for (var project in featuredProjects) ProjectCard(project: project),
        ]),
      ]),

      // Shared Featured Courses Section
      div(id: 'courses', classes: 'home-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('Academy & Digital Resources')]),
            p([Component.text('Masterclasses, field inspection guides, and free downloadable quality packs.')]),
          ]),
          Link(to: '/courses', classes: 'view-all-link', child: Component.text('Browse Full Academy Catalog →')),
        ]),

        div(classes: 'courses-grid', [
          for (var course in featuredCourses) CourseCard(course: course),
        ]),
      ]),

      // Bottom Hire / Contact CTA
      div(classes: 'home-cta-box', [
        h2([Component.text('Ready to Collaborate or Learn Together?')]),
        p([
          Component.text(
            'Whether you need custom mobile app development, industrial E&I consulting, or technical training, let’s connect.',
          ),
        ]),
        div(classes: 'cta-actions', [
          Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Get in Touch / Book Consultation →')),
          Link(to: '/about', classes: 'btn btn-secondary', child: Component.text('Read Full Story & Bio →')),
        ]),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.home-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.all(2.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.hero-section', [
        css('&').styles(
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          textAlign: TextAlign.center,
          padding: Padding.symmetric(vertical: 3.5.rem, horizontal: 2.rem),
          margin: Margin.only(bottom: 3.5.rem),
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(0, 0, 0, 0.4)),
          raw: {'backdrop-filter': 'blur(16px)', '-webkit-backdrop-filter': 'blur(16px)'},
        ),
        css('.hero-badge').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.12),
          color: primaryColor,
          padding: Padding.symmetric(vertical: 8.px, horizontal: 18.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.2.rem),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
        ),
        css('h1').styles(
          fontSize: 3.8.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.zero,
          lineHeight: 1.15.em,
        ),
        css('.hero-title').styles(
          fontSize: 1.5.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          margin: Margin.symmetric(vertical: 0.8.rem),
        ),
        css('.hero-bio').styles(
          fontSize: 1.15.rem,
          lineHeight: 1.7.em,
          color: textMutedColor,
          maxWidth: 820.px,
          margin: Margin.only(bottom: 2.5.rem),
        ),
        css('.gateway-cards', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(1.5.rem),
            width: 100.percent,
            maxWidth: 900.px,
          ),
          css('a').styles(
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            flex: Flex(grow: 1),
            minWidth: 280.px,
          ),
          css('.gateway-card', [
            css('&').styles(
              backgroundColor: cardBackground,
              border: Border.all(color: cardBorder, width: 1.px),
              radius: BorderRadius.all(Radius.circular(20.px)),
              padding: Padding.all(2.rem),
              boxSizing: BoxSizing.borderBox,
              textAlign: TextAlign.left,
              display: Display.flex,
              flexDirection: FlexDirection.column,
              height: 100.percent,
              raw: {'backdrop-filter': 'blur(16px)', '-webkit-backdrop-filter': 'blur(16px)'},
              transition: Transition('all', duration: Duration(milliseconds: 300)),
            ),
            css('&:hover').styles(
              raw: {'transform': 'translateY(-4px)'},
            ),
            css('.gateway-icon-badge').styles(
              fontSize: 2.2.rem,
              margin: Margin.only(bottom: 1.rem),
            ),
            css('h3').styles(
              fontSize: 1.4.rem,
              fontWeight: FontWeight.w700,
              color: textColor,
              margin: Margin.only(bottom: 0.6.rem),
            ),
            css('p').styles(
              fontSize: 0.95.rem,
              color: textMutedColor,
              lineHeight: 1.5.em,
              margin: Margin.only(bottom: 1.5.rem),
              flex: Flex(grow: 1),
            ),
            css('.gateway-link').styles(
              fontSize: 1.rem,
              fontWeight: FontWeight.w700,
            ),
          ]),
          css('.card-software', [
            css('&:hover').styles(
              raw: {'border-color': '#fbc51a'},
              shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(251, 197, 26, 0.2)),
            ),
            css('.gateway-link').styles(color: primaryColor),
          ]),
          css('.card-engineering', [
            css('&:hover').styles(
              raw: {'border-color': '#ff577b'},
              shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(255, 87, 123, 0.2)),
            ),
            css('.gateway-link').styles(color: secondaryColor),
          ]),
        ]),
      ]),
      css('.intersection-banner', [
        css('&').styles(
          width: 100.percent,
          backgroundColor: cardBackground,
          border: Border.all(color: Color.rgba(110, 242, 123, 0.4), width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          margin: Margin.only(bottom: 4.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 30.px, color: Color.rgba(0, 0, 0, 0.3)),
          raw: {'backdrop-filter': 'blur(16px)', '-webkit-backdrop-filter': 'blur(16px)'},
        ),
        css('.intersection-badge').styles(
          display: Display.inlineFlex,
          backgroundColor: Color.rgba(110, 242, 123, 0.12),
          color: emeraldAccent,
          padding: Padding.symmetric(vertical: 6.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          fontSize: 0.85.rem,
          fontWeight: FontWeight.w700,
          margin: Margin.only(bottom: 1.rem),
          border: Border.all(color: Color.rgba(110, 242, 123, 0.3), width: 1.px),
        ),
        css('h2').styles(
          fontSize: 2.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.intersection-text').styles(
          fontSize: 1.1.rem,
          lineHeight: 1.7.em,
          color: textMutedColor,
          maxWidth: 850.px,
          margin: Margin.symmetric(horizontal: Unit.auto),
          padding: Padding.only(bottom: 1.8.rem),
        ),
        css('.btn-intersection').styles(
          display: Display.inlineFlex,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 24.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          backgroundColor: Color.rgba(110, 242, 123, 0.15),
          border: Border.all(color: emeraldAccent, width: 1.px),
          color: emeraldAccent,
          fontWeight: FontWeight.w700,
          fontSize: 1.rem,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          transition: Transition('all', duration: Duration(milliseconds: 200)),
        ),
        css('.btn-intersection:hover').styles(
          backgroundColor: emeraldAccent,
          color: backgroundColor,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(110, 242, 123, 0.4)),
        ),
      ]),
      css('.home-section', [
        css('&').styles(
          width: 100.percent,
          margin: Margin.only(bottom: 4.5.rem),
        ),
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
        css('.projects-grid, .courses-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
          ),
        ]),
      ]),
      css('.home-cta-box', [
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
          raw: {'backdrop-filter': 'blur(16px)', '-webkit-backdrop-filter': 'blur(16px)'},
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
        css('.cta-actions', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            padding: Padding.symmetric(vertical: 14.px, horizontal: 28.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
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
    ]),
    ...ProjectCard.styles,
    ...CourseCard.styles,
  ];
}
