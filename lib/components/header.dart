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
      div(classes: 'header-inner', [
        Link(
          to: '/',
          child: div(classes: 'brand-logo', [
            span(classes: 'logo-accent', [Component.text('I')]),
            Component.text('brahim AlQyas'),
          ]),
        ),
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
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: Display.flex,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 1.5.rem, horizontal: 2.rem),
        justifyContent: JustifyContent.center,
        boxSizing: BoxSizing.borderBox,
      ),
      css('.header-inner', [
        css('&').styles(
          display: Display.flex,
          maxWidth: 1200.px,
          width: 100.percent,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
        ),
        css('a').styles(
          textDecoration: TextDecoration(line: TextDecorationLine.none),
        ),
        css('.brand-logo', [
          css('&').styles(
            fontSize: 1.35.rem,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          css('.logo-accent').styles(
            color: primaryColor,
            fontSize: 1.5.rem,
          ),
        ]),
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
              padding: Padding.symmetric(horizontal: 1.6.em),
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
              position: Position.absolute(bottom: 0.4.em, left: 1.4.em, right: 1.4.em),
              height: 3.px,
              radius: BorderRadius.circular(2.px),
              backgroundColor: primaryColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 0.px, blur: 8.px, color: primaryColor),
            ),
          ])
        ]),
      ]),
    ]),
  ];
}
