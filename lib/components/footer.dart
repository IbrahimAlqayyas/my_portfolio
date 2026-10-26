import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../utils/asset_helper.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Component build(BuildContext context) {
    return footer([
      div(classes: 'footer-inner', [
        div(classes: 'footer-grid', [
          // Column 1: Brand Info
          div(classes: 'footer-col brand-col', [
            div(classes: 'brand-logo', [
              img(src: assetUrl('images/logo1.png'), alt: 'Ibrahim'),
              img(src: assetUrl('images/logo2.png'), alt: 'AlQyas'),
            ]),
            p(classes: 'footer-bio', [
              Component.text(
                'Dual-discipline technical professional: Delivering precision in industrial E&I construction & inspection, and engineering cutting-edge mobile & web apps with Flutter & Dart.',
              ),
            ]),
            div(classes: 'social-links', [
              a(href: 'https://linkedin.com', target: Target.blank, classes: 'social-icon', [
                Component.text('💼 LinkedIn'),
              ]),
              a(href: 'https://github.com', target: Target.blank, classes: 'social-icon', [
                Component.text('💻 GitHub'),
              ]),
              a(href: 'mailto:contact@example.com', classes: 'social-icon', [
                Component.text('✉️ Email'),
              ]),
            ]),
          ]),

          // Column 2: Software & Apps
          div(classes: 'footer-col', [
            h4([Component.text('Software & Apps')]),
            ul([
              li([Link(to: '/software', child: Component.text('Software Hub Overview'))]),
              li([Link(to: '/projects', child: Component.text('Flutter Mobile Portfolio'))]),
              li([Link(to: '/courses', child: Component.text('Architecture Masterclasses'))]),
              li([Link(to: '/contact', child: Component.text('Hire for App Development'))]),
            ]),
          ]),

          // Column 3: E&I Engineering
          div(classes: 'footer-col', [
            h4([Component.text('E&I Engineering')]),
            ul([
              li([Link(to: '/engineering', child: Component.text('Engineering Hub Overview'))]),
              li([Link(to: '/projects', child: Component.text('QA/QC Inspection Case Studies'))]),
              li([Link(to: '/courses', child: Component.text('Documentation & ITR Packs'))]),
              li([Link(to: '/contact', child: Component.text('Consulting & MDR Audits'))]),
            ]),
          ]),

          // Column 4: Quick Links
          div(classes: 'footer-col', [
            h4([Component.text('Navigation')]),
            ul([
              li([Link(to: '/', child: Component.text('Home (Master Portal)'))]),
              li([Link(to: '/projects', child: Component.text('Shared Portfolio'))]),
              li([Link(to: '/courses', child: Component.text('Courses & Resources'))]),
              li([Link(to: '/about', child: Component.text('About Ibrahim'))]),
              li([Link(to: '/contact', child: Component.text('Contact & Booking'))]),
              li([Link(to: '/admin', child: Component.text('⚙️ CMS Dashboard'))]),
            ]),
          ]),
        ]),

        div(classes: 'footer-bottom', [
          p([
            Component.text('© ${DateTime.now().year} Ibrahim AlQyas. All rights reserved. Engineering Precision Meets Digital Innovation.'),
          ]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('footer', [
      css('&').styles(
        width: 100.percent,
        backgroundColor: Color.rgba(15, 23, 42, 0.95),
        padding: Padding.only(top: 4.rem, bottom: 2.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        justifyContent: JustifyContent.center,
        margin: Margin.only(top: 4.rem),
        zIndex: ZIndex(2),
        raw: {
          'border-top': '1px solid #334155',
          'backdrop-filter': 'blur(12px)',
          '-webkit-backdrop-filter': 'blur(12px)',
        },
      ),
      css('.footer-inner', [
        css('&').styles(
          maxWidth: 1200.px,
          width: 100.percent,
          padding: Padding.symmetric(horizontal: 2.rem),
          boxSizing: BoxSizing.borderBox,
          display: Display.flex,
          flexDirection: FlexDirection.column,
        ),
        css('.footer-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.spaceBetween,
            gap: Gap.all(2.5.rem),
            margin: Margin.only(bottom: 3.rem),
          ),
          css('.footer-col', [
            css('&').styles(
              flex: Flex(grow: 1),
              minWidth: 200.px,
            ),
            css('h4').styles(
              color: textColor,
              fontSize: 1.1.rem,
              fontWeight: FontWeight.w700,
              margin: Margin.only(bottom: 1.2.rem),
              position: Position.relative(),
            ),
            css('ul', [
              css('&').styles(
                listStyle: ListStyle.none,
                padding: Padding.zero,
                margin: Margin.zero,
              ),
              css('li', [
                css('&').styles(margin: Margin.only(bottom: 0.7.rem)),
                css('a', [
                  css('&').styles(
                    color: textMutedColor,
                    fontSize: 0.95.rem,
                    textDecoration: TextDecoration(line: TextDecorationLine.none),
                    transition: Transition('color', duration: Duration(milliseconds: 200)),
                  ),
                  css('&:hover').styles(
                    color: primaryColor,
                  ),
                ]),
              ]),
            ]),
          ]),
          css('.brand-col', [
            css('&').styles(
              maxWidth: 380.px,
              flex: Flex(grow: 2),
            ),
            css('.brand-logo', [
              css('&').styles(
                display: Display.flex,
                alignItems: AlignItems.center,
                gap: Gap.all(12.px),
                margin: Margin.only(bottom: 1.rem),
              ),
              css('img').styles(
                height: 22.px,
                width: Unit.auto,
              ),
            ]),
            css('.footer-bio').styles(
              color: textMutedColor,
              fontSize: 0.92.rem,
              lineHeight: 1.6.em,
              margin: Margin.only(bottom: 1.5.rem),
            ),
            css('.social-links', [
              css('&').styles(
                display: Display.flex,
                flexWrap: FlexWrap.wrap,
                gap: Gap.all(10.px),
              ),
              css('.social-icon', [
                css('&').styles(
                  display: Display.inlineFlex,
                  alignItems: AlignItems.center,
                  padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
                  radius: BorderRadius.all(Radius.circular(10.px)),
                  backgroundColor: Color.rgba(255, 255, 255, 0.05),
                  border: Border.all(color: surfaceBorder, width: 1.px),
                  color: textColor,
                  fontSize: 0.85.rem,
                  fontWeight: FontWeight.w600,
                  textDecoration: TextDecoration(line: TextDecorationLine.none),
                  transition: Transition('all', duration: Duration(milliseconds: 200)),
                ),
                css('&:hover').styles(
                  backgroundColor: Color.rgba(251, 197, 26, 0.15),
                  color: primaryColor,
                  raw: {'border-color': '#fbc51a'},
                ),
              ]),
            ]),
          ]),
        ]),
        css('.footer-bottom', [
          css('&').styles(
            raw: {'border-top': '1px solid rgba(255, 255, 255, 0.08)'},
            padding: Padding.only(top: 2.rem),
            textAlign: TextAlign.center,
          ),
          css('p').styles(
            color: textMutedColor,
            fontSize: 0.88.rem,
            margin: Margin.zero,
          ),
        ]),
      ]),
    ]),
  ];
}
