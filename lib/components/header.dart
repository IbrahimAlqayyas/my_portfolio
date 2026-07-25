import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';

class Header extends StatelessComponent {
  final String? activePath;
  const Header({this.activePath, super.key});

  @override
  Component build(BuildContext context) {
    String currentPath =
        activePath ??
        () {
          try {
            return RouteState.of(context).location;
          } catch (_) {
            return '/';
          }
        }();

    return header([
      div(classes: 'header-inner', [
        Link(
          to: '/',
          child: div(classes: 'brand-logo', [
            img(src: '/images/logo1.png', alt: 'Ibrahim'),
            img(src: '/images/logo2.png', alt: 'AlQyas'),
          ]),
        ),
        nav([
          for (var route in [
            (label: 'Home', path: '/'),
            (label: 'About', path: '/about'),
            (label: 'Contact', path: '/contact'),
          ])
            div(classes: currentPath == route.path ? 'active' : null, [
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
        padding: Padding.symmetric(vertical: 1.5.rem, horizontal: 0.px),
        justifyContent: JustifyContent.center,
        boxSizing: BoxSizing.borderBox,
      ),
      css('.header-inner', [
        css('&').styles(
          display: Display.flex,
          maxWidth: 1200.px,
          width: 100.percent,
          padding: Padding.symmetric(horizontal: 2.rem),
          boxSizing: BoxSizing.borderBox,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
        ),
        css('a').styles(
          textDecoration: TextDecoration(line: TextDecorationLine.none),
        ),
        css('.brand-logo', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(12.px),
          ),
          css('img', [
            css('&').styles(
              height: 22.px,
              width: Unit.auto,
              display: Display.block,
              transition: Transition('filter', duration: Duration(milliseconds: 300)),
              raw: {
                'filter': 'drop-shadow(0 0 3px rgba(255, 87, 123, 0.35)) drop-shadow(0 0 6px rgba(255, 87, 123, 0.18))',
              },
            ),
            css('&:last-child').styles(
              raw: {
                'animation': 'electrical-flicker 6s infinite linear',
              },
            ),
            css('&:hover').styles(
              raw: {
                'filter': 'drop-shadow(0 0 6px rgba(255, 87, 123, 0.6)) drop-shadow(0 0 10px rgba(255, 87, 123, 0.3))',
              },
            ),
          ]),
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
          ]),
        ]),
      ]),
    ]),
    css.keyframes('electrical-flicker', {
      '0%, 40%': Styles(
        raw: {
          'opacity': '1',
          'filter': 'drop-shadow(0 0 3px rgba(255, 87, 123, 0.35)) drop-shadow(0 0 6px rgba(255, 87, 123, 0.18))',
        },
      ),
      // Burst 1: 4 Movements (41% - 48%)
      '41%': Styles(
        raw: {
          'opacity': '0.2',
          'filter': 'none',
        },
      ),
      '42%': Styles(
        raw: {
          'opacity': '0.85',
          'filter': 'drop-shadow(0 0 2px rgba(255, 87, 123, 0.2))',
        },
      ),
      '43%': Styles(
        raw: {
          'opacity': '0.35',
          'filter': 'drop-shadow(0 0 1px rgba(255, 87, 123, 0.1))',
        },
      ),
      '44%': Styles(
        raw: {
          'opacity': '0.9',
          'filter': 'drop-shadow(0 0 2px rgba(255, 87, 123, 0.25))',
        },
      ),
      '45%': Styles(
        raw: {
          'opacity': '0.15',
          'filter': 'none',
        },
      ),
      '46%': Styles(
        raw: {
          'opacity': '0.8',
          'filter': 'drop-shadow(0 0 2px rgba(255, 87, 123, 0.2))',
        },
      ),
      '47%': Styles(
        raw: {
          'opacity': '0.4',
          'filter': 'drop-shadow(0 0 1px rgba(255, 87, 123, 0.15))',
        },
      ),
      '48%, 82%': Styles(
        raw: {
          'opacity': '1',
          'filter': 'drop-shadow(0 0 3px rgba(255, 87, 123, 0.35)) drop-shadow(0 0 6px rgba(255, 87, 123, 0.18))',
        },
      ),
      // Burst 2: 4 Movements (83% - 90%)
      '83%': Styles(
        raw: {
          'opacity': '0.25',
          'filter': 'none',
        },
      ),
      '84%': Styles(
        raw: {
          'opacity': '0.9',
          'filter': 'drop-shadow(0 0 2px rgba(255, 87, 123, 0.25))',
        },
      ),
      '85%': Styles(
        raw: {
          'opacity': '0.3',
          'filter': 'drop-shadow(0 0 1px rgba(255, 87, 123, 0.1))',
        },
      ),
      '86%': Styles(
        raw: {
          'opacity': '0.85',
          'filter': 'drop-shadow(0 0 2px rgba(255, 87, 123, 0.2))',
        },
      ),
      '87%': Styles(
        raw: {
          'opacity': '0.18',
          'filter': 'none',
        },
      ),
      '88%': Styles(
        raw: {
          'opacity': '0.95',
          'filter': 'drop-shadow(0 0 3px rgba(255, 87, 123, 0.3))',
        },
      ),
      '89%': Styles(
        raw: {
          'opacity': '0.35',
          'filter': 'drop-shadow(0 0 1px rgba(255, 87, 123, 0.15))',
        },
      ),
      '90%, 100%': Styles(
        raw: {
          'opacity': '1',
          'filter': 'drop-shadow(0 0 3px rgba(255, 87, 123, 0.35)) drop-shadow(0 0 6px rgba(255, 87, 123, 0.18))',
        },
      ),
    }),
  ];
}
