import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class Contact extends StatelessComponent {
  const Contact({super.key});

  @override
  Component build(BuildContext context) {
    return section([
      h1([Component.text('Get in Touch')]),
      p([Component.text('Feel free to reach out for collaborations or just a friendly hello!')]),
      div(classes: 'contact-card', [
        div(classes: 'contact-item', [
          span(classes: 'icon', [Component.text('✉️')]),
          a(href: 'mailto:contact@example.com', [Component.text('contact@example.com')]),
        ]),
        div(classes: 'contact-item', [
          span(classes: 'icon', [Component.text('🌐')]),
          a(href: 'https://github.com', target: Target.blank, [Component.text('GitHub Profile')]),
        ]),
        div(classes: 'contact-item', [
          span(classes: 'icon', [Component.text('💼')]),
          a(href: 'https://linkedin.com', target: Target.blank, [Component.text('LinkedIn Profile')]),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.contact-card', [
      css('&').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        padding: Padding.all(2.em),
        margin: Margin.only(top: 2.em),
        radius: BorderRadius.all(Radius.circular(16.px)),
        backgroundColor: surfaceColor,
        border: Border.all(color: surfaceBorder, width: 1.px),
        shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(0, 0, 0, 0.25)),
      ),
      css('.contact-item', [
        css('&').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          margin: Margin.symmetric(vertical: 0.8.em),
          fontSize: 1.1.rem,
        ),
        css('.icon').styles(
          margin: Margin.only(right: 1.em),
          fontSize: 1.5.rem,
        ),
        css('a').styles(
          color: primaryColor,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          fontWeight: FontWeight.w600,
        ),
        css('a:hover').styles(
          color: textColor,
          textDecoration: TextDecoration(line: TextDecorationLine.underline),
        ),
      ]),
    ]),
  ];
}
