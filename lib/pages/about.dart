import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class About extends StatelessComponent {
  const About({super.key});

  @override
  Component build(BuildContext context) {
    return section([
      ol([
        li([
          h3([Component.text('📖 Documentation')]),
          Component.text('Jaspr\'s '),
          a(href: 'https://docs.jaspr.site', target: Target.blank, [Component.text('official documentation')]),
          Component.text(' provides you with all information you need to get started.'),
        ]),
        li([
          h3([Component.text('💬 Community')]),
          Component.text('Got stuck? Ask your question on the official '),
          a(href: 'https://discord.gg/XGXrGEk4c6', target: Target.blank, [Component.text('Discord server')]),
          Component.text(' for the Jaspr community.'),
        ]),
        li([
          h3([Component.text('📦 Ecosystem')]),
          Component.text(
              'Get official packages and integrations for your project like jaspr_router, jaspr_tailwind or jaspr_riverpod. Find packages built for Jaspr on pub.dev using the '),
          a(href: 'https://pub.dev/packages?q=topic%3Ajaspr', target: Target.blank, [Component.text('#jaspr')]),
          Component.text(' topic, or publish your own.'),
        ]),
        li([
          h3([Component.text('💙 Support Jaspr')]),
          Component.text('If you like Jaspr, consider starring us on '),
          a(href: 'https://github.com/schultek/jaspr', target: Target.blank, [Component.text('Github')]),
          Component.text(' and tell your friends.'),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('ol', [
      css('&').styles(
        maxWidth: 600.px,
        padding: Padding.zero,
        listStyle: ListStyle.none,
      ),
      css('li', [
        css('&').styles(
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          padding: Padding.all(1.5.em),
          margin: Margin.only(bottom: 1.2.em),
          color: textMutedColor,
          lineHeight: 1.6.em,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.2)),
        ),
        css('h3').styles(
          margin: Margin.only(bottom: 0.5.em),
          color: textColor,
          fontSize: 1.3.rem,
        ),
        css('a').styles(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          cursor: Cursor.pointer,
        ),
        css('a:hover').styles(
          color: textColor,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
        ),
      ]),
    ]),
  ];
}
