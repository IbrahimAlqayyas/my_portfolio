import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';

class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = RouteState.of(context).location;

    return header([
      nav([
        for (var route in [
          (label: 'Home', path: '/'),
          (label: 'About', path: '/about'),
          (label: 'Contact', path: '/contact'),
        ])
          div(classes: activePath == route.path ? 'active' : null, [
            Link(to: route.path, child: Component.text(route.label)),
          ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: Display.flex,
        padding: Padding.all(1.5.em),
        justifyContent: JustifyContent.center,
      ),
      css('nav', [
        css('&').styles(
          display: Display.flex,
          height: 3.2.em,
          radius: BorderRadius.all(Radius.circular(16.px)), 
          overflow: Overflow.clip,
          justifyContent: JustifyContent.spaceBetween,
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 20.px, color: Color.rgba(0, 0, 0, 0.3)),
        ),
        css('a', [
          css('&').styles(
            display: Display.flex,
            height: 100.percent,
            padding: Padding.symmetric(horizontal: 1.8.em),
            alignItems: AlignItems.center,
            color: textMutedColor,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
          ),
          css('&:hover').styles(
            color: textColor,
            backgroundColor: Color.rgba(255, 255, 255, 0.05),
          ),
        ]),
        css('div.active', [
          css('&').styles(position: Position.relative()),
          css('a').styles(
            color: primaryColor,
            fontWeight: FontWeight.w700,
          ),
          css('&::before').styles(
            content: '',
            display: Display.block,
            position: Position.absolute(bottom: 0.4.em, left: 1.5.em, right: 1.5.em),
            height: 3.px,
            radius: BorderRadius.circular(2.px),
            backgroundColor: primaryColor,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 0.px, blur: 8.px, color: primaryColor),
          ),
        ])
      ]),
    ]),
  ];
}
