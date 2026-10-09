import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../utils/scroll_helper.dart';

class About extends StatefulComponent {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();

  @css
  static List<StyleRule> get styles => _AboutState.styles;
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    return section(classes: 'about-container', [
      // Header
      div(classes: 'about-header', [
        div(classes: 'about-badge', [Component.text('👤 About Ibrahim AlQyas')]),
        h1([Component.text('Two Disciplines, One Standard of Excellence')]),
        p(classes: 'about-lead', [
          Component.text(
            'I operate at the intersection of heavy industrial engineering and modern software development, combining field-tested discipline with cutting-edge app craftsmanship.',
          ),
        ]),
      ]),

      // Story Cards
      div(classes: 'about-grid', [
        // Column 1: The Engineering Background
        div(classes: 'story-card', [
          div(classes: 'card-icon', [Component.text('⚡')]),
          h2([Component.text('Electrical & Instrumentation (E&I)')]),
          p([
            Component.text(
              'My foundation in heavy industry, oil & gas refineries, and industrial construction instilled a deep respect for safety, compliance, and procedural rigor. In hazardous environments, there is zero margin for error.',
            ),
          ]),
          p([
            Component.text(
              'I specialize in QA/QC inspection, ATEX / IECEx explosion-proof compliance (IEC 60079), ITR verification packages, smart transmitter calibrations, and Manufacturer Data Report (MDR) turnover dossiers.',
            ),
          ]),
          div(classes: 'card-highlight', [
            Component.text('Core Value: Rigor, Standards Compliance & Uncompromising Safety'),
          ]),
        ]),

        // Column 2: The Software Engineering Background
        div(classes: 'story-card', [
          div(classes: 'card-icon', [Component.text('📱')]),
          h2([Component.text('Flutter & Software Engineering')]),
          p([
            Component.text(
              'With over 6 years of coding experience, I design and construct mobile and web applications using Flutter, Dart, and Jaspr. I view software engineering through an engineer\'s lens: resilient systems, clean architecture, and long-term maintainability.',
            ),
          ]),
          p([
            Component.text(
              'Whether building consumer apps with thousands of daily users or developing offline-first field inspection suites for site teams, I focus on responsive UI/UX, predictable state management, and robust offline sync.',
            ),
          ]),
          div(classes: 'card-highlight highlight-software', [
            Component.text('Core Value: Clean Architecture, Speed & Exceptional User Experience'),
          ]),
        ]),
      ]),

      // The Dual Advantage Section
      div(classes: 'philosophy-box', [
        h2([Component.text('The Multi-Disciplinary Advantage')]),
        p([
          Component.text(
            'Most software developers never experience the physical reality of industrial operations, and most industrial inspectors don’t possess the tools to digitalize their own workflows. By mastering both domains, I bridge this gap: building tailored software for industrial clients and applying unwavering engineering discipline to every software project I create.',
          ),
        ]),
        div(classes: 'philosophy-actions', [
          Link(to: '/software', classes: 'btn btn-primary', child: Component.text('Explore Software Hub →')),
          Link(to: '/engineering', classes: 'btn btn-secondary', child: Component.text('Explore Engineering Hub →')),
        ]),
      ]),

      // Skills Matrix
      div(classes: 'skills-section', [
        h2([Component.text('Technical Competencies')]),
        div(classes: 'skills-grid', [
          div(classes: 'skill-col', [
            h3([Component.text('💻 Software & Development')]),
            ul([
              li([Component.text('Flutter (iOS, Android & Web)')]),
              li([Component.text('Dart Language & Ecosystem')]),
              li([Component.text('Jaspr Web Framework & SSR')]),
              li([Component.text('State Management (Bloc & Riverpod)')]),
              li([Component.text('Clean Architecture & Modular Design')]),
              li([Component.text('SQLite, Hive & Offline Caching')]),
              li([Component.text('RESTful APIs & Firebase Integration')]),
              li([Component.text('CI/CD & GitHub Actions')]),
            ]),
          ]),
          div(classes: 'skill-col', [
            h3([Component.text('⚡ E&I Construction & QA/QC')]),
            ul([
              li([Component.text('ITR & MDR Turnover Dossier Audits')]),
              li([Component.text('ATEX & IECEx Hazardous Areas (IEC 60079)')]),
              li([Component.text('Smart Transmitter Calibration (HART)')]),
              li([Component.text('Cable Pulling, Glanding & Termination')]),
              li([Component.text('Switchgear & MCC Testing QA/QC')]),
              li([Component.text('Punch List Management & Clearance')]),
              li([Component.text('P&ID, Hook-ups & Wiring Schematics')]),
              li([Component.text('ISO 9001 Quality System Compliance')]),
            ]),
          ]),
        ]),
      ]),

      // Final CTA
      div(classes: 'about-cta', [
        h2([Component.text('Let’s Work Together')]),
        p([Component.text('Ready to discuss an application, an engineering consultation, or training?')]),
        Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Contact Ibrahim →')),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.about-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.about-header', [
        css('&').styles(
          textAlign: TextAlign.center,
          maxWidth: 820.px,
          margin: Margin.only(bottom: 3.5.rem),
        ),
        css('.about-badge').styles(
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
          margin: Margin.only(bottom: 1.rem),
          lineHeight: 1.2.em,
        ),
        css('.about-lead').styles(
          fontSize: 1.2.rem,
          color: textMutedColor,
          lineHeight: 1.6.em,
        ),
      ]),
      css('.about-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(2.rem),
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
        css('.story-card', [
          css('&').styles(
            flex: Flex(grow: 1),
            minWidth: 320.px,
            maxWidth: 520.px,
            backgroundColor: cardBackground,
            border: Border.all(color: cardBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(24.px)),
            padding: Padding.all(2.5.rem),
            boxSizing: BoxSizing.borderBox,
            display: Display.flex,
            flexDirection: FlexDirection.column,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 30.px, color: Color.rgba(0, 0, 0, 0.3)),
            raw: cardBackdropFilter,
          ),
          css('.card-icon').styles(
            fontSize: 2.5.rem,
            margin: Margin.only(bottom: 1.rem),
          ),
          css('h2').styles(
            fontSize: 1.6.rem,
            fontWeight: FontWeight.w700,
            color: textColor,
            margin: Margin.only(bottom: 1.rem),
          ),
          css('p').styles(
            fontSize: 1.02.rem,
            color: textMutedColor,
            lineHeight: 1.65.em,
            margin: Margin.only(bottom: 1.2.rem),
          ),
          css('.card-highlight').styles(
            backgroundColor: Color.rgba(255, 87, 123, 0.12),
            color: secondaryColor,
            border: Border.all(color: Color.rgba(255, 87, 123, 0.3), width: 1.px),
            padding: Padding.all(1.rem),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.9.rem,
            fontWeight: FontWeight.w600,
            margin: Margin.only(top: Unit.auto),
          ),
          css('.highlight-software').styles(
            backgroundColor: Color.rgba(251, 197, 26, 0.12),
            color: primaryColor,
            border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
          ),
        ]),
      ]),
      css('.philosophy-box', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 950.px,
          backgroundColor: cardBackground,
          border: Border.all(color: Color.rgba(110, 242, 123, 0.4), width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(3.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          margin: Margin.only(bottom: 4.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(0, 0, 0, 0.35)),
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 2.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 1.rem),
        ),
        css('p').styles(
          fontSize: 1.12.rem,
          color: textMutedColor,
          lineHeight: 1.7.em,
          maxWidth: 820.px,
          margin: Margin.symmetric(horizontal: Unit.auto),
          padding: Padding.only(bottom: 2.rem),
        ),
        css('.philosophy-actions', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            padding: Padding.symmetric(vertical: 14.px, horizontal: 26.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontWeight: FontWeight.w700,
            fontSize: 1.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
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
      css('.skills-section', [
        css('&').styles(
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
        css('h2').styles(
          fontSize: 2.4.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          textAlign: TextAlign.center,
          margin: Margin.only(bottom: 2.5.rem),
        ),
        css('.skills-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
            gap: Gap.all(2.rem),
          ),
          css('.skill-col', [
            css('&').styles(
              flex: Flex(grow: 1),
              minWidth: 300.px,
              maxWidth: 480.px,
              backgroundColor: cardBackground,
              border: Border.all(color: cardBorder, width: 1.px),
              radius: BorderRadius.all(Radius.circular(20.px)),
              padding: Padding.all(2.rem),
              boxSizing: BoxSizing.borderBox,
              raw: cardBackdropFilter,
            ),
            css('h3').styles(
              fontSize: 1.35.rem,
              fontWeight: FontWeight.w700,
              color: textColor,
              margin: Margin.only(bottom: 1.2.rem),
              raw: {'border-bottom': '1px solid rgba(255, 255, 255, 0.08)'},
              padding: Padding.only(bottom: 0.8.rem),
            ),
            css('ul', [
              css('&').styles(
                listStyle: ListStyle.none,
                padding: Padding.zero,
                margin: Margin.zero,
              ),
              css('li', [
                css('&').styles(
                  color: textMutedColor,
                  fontSize: 1.rem,
                  lineHeight: 1.6.em,
                  margin: Margin.only(bottom: 8.px),
                  position: Position.relative(),
                  padding: Padding.only(left: 18.px),
                ),
                css('&::before').styles(
                  content: '•',
                  position: Position.absolute(left: 0.px),
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
      css('.about-cta', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 800.px,
          textAlign: TextAlign.center,
          padding: Padding.all(2.5.rem),
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.6.rem),
        ),
        css('p').styles(
          fontSize: 1.1.rem,
          color: textMutedColor,
          margin: Margin.only(bottom: 1.8.rem),
        ),
        css('.btn').styles(
          display: Display.inlineFlex,
          padding: Padding.symmetric(vertical: 14.px, horizontal: 28.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          fontWeight: FontWeight.w700,
          fontSize: 1.05.rem,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          backgroundColor: primaryColor,
          color: backgroundColor,
          transition: Transition('all', duration: Duration(milliseconds: 200)),
        ),
        css('.btn:hover').styles(
          backgroundColor: secondaryColor,
          color: textColor,
        ),
      ]),
    ]),
  ];
}
