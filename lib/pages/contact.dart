import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';
import '../utils/scroll_helper.dart';

class Contact extends StatefulComponent {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();

  @css
  static List<StyleRule> get styles => _ContactState.styles;
}

class _ContactState extends State<Contact> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    return section(classes: 'contact-container', [
      div(classes: 'contact-header', [
        div(classes: 'contact-badge', [Component.text('📬 Let\'s Connect')]),
        h1([Component.text('Start a Conversation')]),
        p(classes: 'contact-subtitle', [
          Component.text(
            'Whether you need a full-cycle mobile app, industrial E&I consulting, or professional engineering training, I’m ready to collaborate.',
          ),
        ]),
      ]),

      // Inquiry Paths Grid
      div(classes: 'inquiry-grid', [
        // Path 1: Software
        div(classes: 'inquiry-card card-software', [
          div(classes: 'inquiry-icon', [Component.text('📱')]),
          h3([Component.text('Software & App Projects')]),
          p([
            Component.text(
              'Looking to build a new Flutter mobile app, develop an MVP for your startup, or scale your web architecture?',
            ),
          ]),
          ul([
            li([Component.text('Custom iOS & Android Apps')]),
            li([Component.text('Full-Stack Web & Jaspr Solutions')]),
            li([Component.text('Architecture Review & Refactoring')]),
          ]),
          a(
            href: 'mailto:contact@example.com?subject=Software%20App%20Inquiry',
            classes: 'btn btn-software',
            [Component.text('Inquire for Software →')],
          ),
        ]),

        // Path 2: E&I Engineering
        div(classes: 'inquiry-card card-engineering', [
          div(classes: 'inquiry-icon', [Component.text('⚡')]),
          h3([Component.text('E&I Consulting & Audits')]),
          p([
            Component.text(
              'Need expert technical assistance with ITR verification, ATEX hazardous area audits, or MDR handover packages?',
            ),
          ]),
          ul([
            li([Component.text('ITR & MDR Dossier Auditing')]),
            li([Component.text('Hazardous Area (Ex) Compliance')]),
            li([Component.text('Pre-Commissioning Quality Verification')]),
          ]),
          a(
            href: 'mailto:contact@example.com?subject=EI%20Engineering%20Consulting%20Inquiry',
            classes: 'btn btn-engineering',
            [Component.text('Inquire for E&I Consulting →')],
          ),
        ]),

        // Path 3: Courses & Training
        div(classes: 'inquiry-card card-training', [
          div(classes: 'inquiry-icon', [Component.text('🎓')]),
          h3([Component.text('Courses & Corporate Training')]),
          p([
            Component.text(
              'Interested in team workshops, custom technical curriculums, or access to comprehensive quality packs?',
            ),
          ]),
          ul([
            li([Component.text('Flutter Team Architecture Workshops')]),
            li([Component.text('Field QA/QC Training for EPC Inspectors')]),
            li([Component.text('Custom Educational Materials')]),
          ]),
          a(
            href: 'mailto:contact@example.com?subject=Training%20or%20Course%20Inquiry',
            classes: 'btn btn-training',
            [Component.text('Inquire for Training →')],
          ),
        ]),
      ]),

      // Direct Contact Channels
      div(classes: 'direct-channels-box', [
        h2([Component.text('Direct Contact Channels')]),
        div(classes: 'channels-grid', [
          div(classes: 'channel-item', [
            span(classes: 'channel-icon', [Component.text('✉️')]),
            div([
              span(classes: 'channel-label', [Component.text('Email Address')]),
              a(href: 'mailto:contact@example.com', [Component.text('contact@example.com')]),
            ]),
          ]),
          div(classes: 'channel-item', [
            span(classes: 'channel-icon', [Component.text('💼')]),
            div([
              span(classes: 'channel-label', [Component.text('LinkedIn Profile')]),
              a(href: 'https://linkedin.com', target: Target.blank, [Component.text('Connect on LinkedIn')]),
            ]),
          ]),
          div(classes: 'channel-item', [
            span(classes: 'channel-icon', [Component.text('💻')]),
            div([
              span(classes: 'channel-label', [Component.text('GitHub Profile')]),
              a(href: 'https://github.com', target: Target.blank, [Component.text('Review Code on GitHub')]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.contact-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.contact-header', [
        css('&').styles(
          textAlign: TextAlign.center,
          maxWidth: 800.px,
          margin: Margin.only(bottom: 3.5.rem),
        ),
        css('.contact-badge').styles(
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
        css('.contact-subtitle').styles(
          fontSize: 1.15.rem,
          color: textMutedColor,
          lineHeight: 1.6.em,
        ),
      ]),
      css('.inquiry-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(1.5.rem),
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
        css('.inquiry-card', [
          css('&').styles(
            flex: Flex(grow: 1),
            minWidth: 280.px,
            maxWidth: 360.px,
            backgroundColor: cardBackground,
            border: Border.all(color: cardBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(24.px)),
            padding: Padding.all(2.2.rem),
            boxSizing: BoxSizing.borderBox,
            display: Display.flex,
            flexDirection: FlexDirection.column,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(0, 0, 0, 0.3)),
            raw: {
              ...cardBackdropFilter,
              'transition': 'all 0.3s ease',
            },
          ),
          css('.inquiry-icon').styles(
            fontSize: 2.2.rem,
            margin: Margin.only(bottom: 1.rem),
          ),
          css('h3').styles(
            fontSize: 1.35.rem,
            fontWeight: FontWeight.w700,
            color: textColor,
            margin: Margin.only(bottom: 0.8.rem),
          ),
          css('p').styles(
            fontSize: 0.95.rem,
            color: textMutedColor,
            lineHeight: 1.5.em,
            margin: Margin.only(bottom: 1.2.rem),
          ),
          css('ul', [
            css('&').styles(
              listStyle: ListStyle.none,
              padding: Padding.zero,
              margin: Margin.only(bottom: 1.8.rem),
              flex: Flex(grow: 1),
            ),
            css('li', [
              css('&').styles(
                fontSize: 0.88.rem,
                color: textColor,
                margin: Margin.only(bottom: 8.px),
                position: Position.relative(),
                padding: Padding.only(left: 18.px),
              ),
              css('&::before').styles(
                content: '✓',
                position: Position.absolute(left: 0.px),
                color: emeraldAccent,
                fontWeight: FontWeight.bold,
              ),
            ]),
          ]),
          css('.btn').styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            alignItems: AlignItems.center,
            padding: Padding.symmetric(vertical: 12.px, horizontal: 20.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontWeight: FontWeight.w700,
            fontSize: 0.95.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
        ]),
        css('.card-software', [
          css('&:hover').styles(
            raw: {
              'border-color': '#fbc51a',
              'transform': 'translateY(-4px)',
            },
          ),
          css('.btn-software', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
            ),
            css('&:hover').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              raw: {'filter': 'brightness(1.12)'},
            ),
          ]),
        ]),
        css('.card-engineering', [
          css('&:hover').styles(
            raw: {
              'border-color': '#fbc51a',
              'transform': 'translateY(-4px)',
            },
          ),
          css('.btn-engineering', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
            ),
            css('&:hover').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              raw: {'filter': 'brightness(1.12)'},
            ),
          ]),
        ]),
        css('.card-training', [
          css('&:hover').styles(
            raw: {
              'border-color': '#6ef27b',
              'transform': 'translateY(-4px)',
            },
          ),
          css('.btn-training', [
            css('&').styles(
              backgroundColor: Color.rgba(110, 242, 123, 0.15),
              color: emeraldAccent,
              border: Border.all(color: emeraldAccent, width: 1.px),
            ),
            css('&:hover').styles(
              backgroundColor: emeraldAccent,
              color: backgroundColor,
            ),
          ]),
        ]),
      ]),
      css('.direct-channels-box', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 900.px,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          boxSizing: BoxSizing.borderBox,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 28.px, color: Color.rgba(0, 0, 0, 0.25)),
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 1.8.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          textAlign: TextAlign.center,
          margin: Margin.only(bottom: 2.rem),
        ),
        css('.channels-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.spaceAround,
            gap: Gap.all(1.5.rem),
          ),
          css('.channel-item', [
            css('&').styles(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.all(12.px),
            ),
            css('.channel-icon').styles(
              fontSize: 2.2.rem,
            ),
            css('.channel-label').styles(
              display: Display.block,
              fontSize: 0.82.rem,
              color: textMutedColor,
              fontWeight: FontWeight.w600,
              raw: {'text-transform': 'uppercase'},
            ),
            css('a').styles(
              fontSize: 1.05.rem,
              color: primaryColor,
              fontWeight: FontWeight.w700,
              textDecoration: TextDecoration(line: TextDecorationLine.none),
              transition: Transition('color', duration: Duration(milliseconds: 200)),
            ),
            css('a:hover').styles(
              color: primaryColor,
              raw: {'filter': 'brightness(1.2)'},
            ),
          ]),
        ]),
      ]),
    ]),
  ];
}
