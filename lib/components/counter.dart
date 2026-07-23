import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

class Counter extends StatefulComponent {
  const Counter({super.key});

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int count = 0;

  @override
  Component build(BuildContext context) {
    return div([
      div(classes: 'counter', [
        button(
          onClick: () {
            setState(() => count--);
          },
          [Component.text('-')],
        ),
        span([Component.text('$count')]),
        button(
          onClick: () {
            setState(() => count++);
          },
          [Component.text('+')],
        ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.counter', [
      css('&').styles(
        display: Display.flex,
        padding: Padding.symmetric(vertical: 12.px, horizontal: 20.px),
        backgroundColor: surfaceColor,
        border: Border.all(color: surfaceBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(16.px)),
        alignItems: AlignItems.center,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.2)),
      ),
      css('button', [
        css('&').styles(
          display: Display.flex,
          width: 2.2.em,
          height: 2.2.em, 
          border: Border.all(color: surfaceBorder, width: 1.px), 
          radius: BorderRadius.all(Radius.circular(2.em)),
          cursor: Cursor.pointer,
          justifyContent: JustifyContent.center, 
          alignItems: AlignItems.center,
          fontSize: 1.5.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          backgroundColor: Color.rgba(255, 255, 255, 0.06),
        ),
        css('&:hover').styles(
          backgroundColor: Color.rgba(255, 255, 255, 0.12),
          color: primaryColor,
        ),
      ]),
      css('span').styles(
        minWidth: 2.5.em,
        padding: Padding.symmetric(horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox, 
        color: primaryColor, 
        textAlign: TextAlign.center,
        fontSize: 3.rem,
        fontWeight: FontWeight.w800,
      ),
    ]),
  ];
}
