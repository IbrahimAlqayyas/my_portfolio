import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/course_card.dart';
import '../components/project_card.dart';
import '../constants/theme.dart';
import '../data/courses_data.dart';
import '../data/projects_data.dart';
import '../utils/scroll_helper.dart';

class EngineeringHub extends StatefulComponent {
  const EngineeringHub({super.key});

  @override
  State<EngineeringHub> createState() => _EngineeringHubState();

  @css
  static List<StyleRule> get styles => _EngineeringHubState.styles;
}

class _EngineeringHubState extends State<EngineeringHub> {
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
          Component.text('⚡ Electrical & Instrumentation (E&I) Track'),
        ]),
        h1([Component.text('E&I Construction, Inspection & QA/QC')]),
        p(classes: 'hub-subtitle', [
          Component.text('Precision Quality Assurance & Regulatory Compliance for Industrial EPC Projects'),
        ]),
        p(classes: 'hub-bio', [
          Component.text(
            'Specialized in oil & gas, refinery, and power generation E&I QA/QC. Delivering rigorous inspection protocols, ATEX/IECEx hazardous area compliance, smart transmitter calibrations, and seamless Manufacturer Data Report (MDR) turnover dossiers.',
          ),
        ]),
        div(classes: 'hub-actions', [
          Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Request Engineering Consultation →')),
          a(
            href: '#engineering-projects',
            classes: 'btn btn-secondary',
            events: {
              'click': (e) {
                e.preventDefault();
                scrollToId('engineering-projects');
              },
            },
            [Component.text('View Case Studies ↓')],
          ),
        ]),
      ]),

      // Metrics Bar
      div(classes: 'metrics-bar', [
        div(classes: 'metric-item', [
          h3([Component.text('IEC & ATEX')]),
          p([Component.text('Compliance Standards')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('100%')]),
          p([Component.text('ITR & MDR Verification')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('Oil & Gas')]),
          p([Component.text('Refinery & Plant Experience')]),
        ]),
        div(classes: 'metric-item', [
          h3([Component.text('Zero NCR')]),
          p([Component.text('Handover Excellence')]),
        ]),
      ]),

      // Services Section
      div(classes: 'hub-section', [
        div(classes: 'section-header', [
          h2([Component.text('E&I Engineering & Consulting Services')]),
          p([Component.text('Comprehensive technical consulting and field verification for EPC contractors and plant operators.')]),
        ]),
        div(classes: 'services-grid', [
          _ServiceCard(
            icon: '📋',
            title: 'ITR & MDR Dossier Audits',
            description:
                'End-to-end review of Inspection & Test Records (ITRs), calibration certs, and compilation of client handover dossiers (MDRs).',
            features: const ['100% Document Verification', 'Pre-Commissioning Punch Lists', 'Client Acceptance Facilitation'],
          ),
          _ServiceCard(
            icon: '⚠️',
            title: 'Hazardous Area (ATEX) Audits',
            description:
                'Ex-d, Ex-e, Ex-i inspection of enclosures, barrier glands, and intrinsically safe loop calculations per IEC 60079 series.',
            features: const ['Ex Equipment Register', 'IEC 60079-14 & 17 Compliance', 'Defect Remediation Guidance'],
          ),
          _ServiceCard(
            icon: '🔬',
            title: 'Calibration Systems & Registers',
            description:
                'Quality registers for HART and Fieldbus smart transmitters, control valves stroke tests, and primary electrical testing.',
            features: const ['5-Point Calibration Logs', 'Uncertainty Verification', 'Test Equipment Certification Tracking'],
          ),
          _ServiceCard(
            icon: '🎓',
            title: 'Technical Training & Field QA/QC',
            description:
                'Hands-on training courses and field mentorship for junior engineers and QA/QC inspectors in modern installation standards.',
            features: const ['Cable Glanding & Pulling Rules', 'Loop Checking Methodology', 'MDR Dossier Best Practices'],
          ),
        ]),
      ]),

      // Section-Specific Portfolio (Sourced from shared projectsList)
      div(id: 'engineering-projects', classes: 'hub-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('E&I Engineering Case Studies')]),
            p([Component.text('Documented inspection projects, hazardous area audits, and commissioning quality packages.')]),
          ]),
          Link(to: '/projects', classes: 'view-all-link', child: Component.text('View All in Shared Portfolio →')),
        ]),
        div(classes: 'projects-grid', [
          for (var project in engineeringProjects) ProjectCard(project: project),
        ]),
      ]),

      // Section-Specific Courses & Resources (Sourced from shared coursesList)
      div(classes: 'hub-section', [
        div(classes: 'section-header-split', [
          div([
            h2([Component.text('E&I Training & Quality Documentation Packs')]),
            p([Component.text('Field masterclasses, printable inspection sheets, and standardized Excel/PDF quality registers.')]),
          ]),
          Link(to: '/courses', classes: 'view-all-link', child: Component.text('View All in Academy →')),
        ]),
        div(classes: 'courses-grid', [
          for (var course in engineeringCourses) CourseCard(course: course),
        ]),
      ]),

      // Standards & Accreditations
      div(classes: 'hub-section standards-section', [
        div(classes: 'section-header', [
          h2([Component.text('Standards, Codes & Compliance Frameworks')]),
          p([Component.text('All engineering and inspection services strictly adhere to international codes.')]),
        ]),
        div(classes: 'standards-badges', [
          for (var std in [
            'IEC 60079 (Hazardous Areas)',
            'ATEX Directive 2014/34/EU',
            'IECEx Certified Systems',
            'ISO 9001 Quality Management',
            'API 500 / API 505 Area Classification',
            'IEC 60364 Electrical Installations',
            'NFPA 70 (NEC Standards)',
            'ISA-5.1 Instrumentation Symbols',
          ])
            span(classes: 'standard-badge', [Component.text(std)]),
        ]),
      ]),

      // Bottom CTA
      div(classes: 'hub-cta-box', [
        h2([Component.text('Need E&I Consulting or QA/QC Audit for your Facility?')]),
        p([
          Component.text(
            'Whether preparing for an upcoming turnaround, resolving MDR punch lists, or certifying hazardous areas, let’s discuss your scope.',
          ),
        ]),
        Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Schedule an Engineering Consultation →')),
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
          backgroundColor: Color.rgba(255, 87, 123, 0.12),
          color: secondaryColor,
          padding: Padding.symmetric(vertical: 8.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.2.rem),
          border: Border.all(color: Color.rgba(255, 87, 123, 0.3), width: 1.px),
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
          color: secondaryColor,
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
              backgroundColor: secondaryColor,
              color: textColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(255, 87, 123, 0.4)),
            ),
            css('&:hover').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
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
            color: secondaryColor,
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
            color: secondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 1.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('color', duration: Duration(milliseconds: 200)),
          ),
          css('.view-all-link:hover').styles(
            color: primaryColor,
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
      css('.standards-section', [
        css('.standards-badges', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(12.px),
            maxWidth: 850.px,
            margin: Margin.symmetric(horizontal: Unit.auto),
          ),
          css('.standard-badge').styles(
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
          border: Border.all(color: secondaryColor, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(3.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(255, 87, 123, 0.15)),
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
          backgroundColor: secondaryColor,
          color: textColor,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(255, 87, 123, 0.4)),
          transition: Transition('all', duration: Duration(milliseconds: 250)),
        ),
        css('.btn:hover').styles(
          backgroundColor: primaryColor,
          color: backgroundColor,
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
          'border-color': '#ff577b',
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
            color: secondaryColor,
            fontWeight: FontWeight.w800,
            margin: Margin.only(right: 6.px),
          ),
        ]),
      ]),
    ]),
  ];
}
