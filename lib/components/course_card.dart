import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../models/course.dart';

class CourseCard extends StatelessComponent {
  final Course course;
  const CourseCard({required this.course, super.key});

  @override
  Component build(BuildContext context) {
    final isSoftware = course.category == 'software';

    return div(classes: 'course-card', [
      div(classes: 'course-header', [
        div(classes: 'header-top', [
          span(classes: 'course-icon', [Component.text(course.icon)]),
          span(
            classes: 'course-badge ${course.isFree ? "badge-free" : isSoftware ? "badge-software" : "badge-engineering"}',
            [Component.text(course.badge)],
          ),
        ]),
        h3([Component.text(course.title)]),
        p(classes: 'course-subtitle', [Component.text(course.subtitle)]),
      ]),
      div(classes: 'course-meta', [
        span(classes: 'meta-item', [
          Component.text('⏱️ ${course.duration}'),
        ]),
        span(classes: 'meta-item', [
          Component.text('🎯 ${course.level}'),
        ]),
      ]),
      p(classes: 'course-desc', [Component.text(course.description)]),
      div(classes: 'course-topics-title', [
        Component.text('Key Curriculum & Deliverables:'),
      ]),
      ul(classes: 'course-topics', [
        for (var topic in course.topics)
          li([
            span(classes: 'check-icon', [Component.text('✓')]),
            span([Component.text(topic)]),
          ]),
      ]),
      div(classes: 'course-footer', [
        Link(
          to: '/courses/${course.id}',
          classes: 'btn ${course.isFree ? "btn-free" : "btn-primary"}',
          child: Component.text('Explore Curriculum & Videos →'),
        ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.course-card', [
      css('&').styles(
        width: 350.px,
        backgroundColor: cardBackground,
        border: Border.all(color: cardBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(20.px)),
        overflow: Overflow.hidden,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        margin: Margin.all(12.px),
        padding: Padding.all(1.8.rem),
        boxSizing: BoxSizing.borderBox,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 24.px, color: Color.rgba(0, 0, 0, 0.35)),
        raw: {
          'backdrop-filter': 'blur(16px)',
          '-webkit-backdrop-filter': 'blur(16px)',
          'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        },
      ),
      css('&:hover').styles(
        border: Border.all(color: primaryColor, width: 1.px),
        shadow: BoxShadow(offsetX: 0.px, offsetY: 12.px, blur: 32.px, color: Color.rgba(251, 197, 26, 0.18)),
        raw: {'transform': 'translateY(-4px)'},
      ),
      css('.course-header', [
        css('.header-top', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            margin: Margin.only(bottom: 1.rem),
          ),
          css('.course-icon').styles(
            fontSize: 2.2.rem,
          ),
          css('.course-badge').styles(
            padding: Padding.symmetric(vertical: 4.px, horizontal: 12.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.78.rem,
            fontWeight: FontWeight.w700,
          ),
          css('.badge-free').styles(
            backgroundColor: Color.rgba(110, 242, 123, 0.15),
            color: emeraldAccent,
            border: Border.all(color: Color.rgba(110, 242, 123, 0.4), width: 1.px),
          ),
          css('.badge-software').styles(
            backgroundColor: Color.rgba(251, 197, 26, 0.15),
            color: primaryColor,
            border: Border.all(color: Color.rgba(251, 197, 26, 0.4), width: 1.px),
          ),
          css('.badge-engineering').styles(
            backgroundColor: Color.rgba(255, 87, 123, 0.15),
            color: secondaryColor,
            border: Border.all(color: Color.rgba(255, 87, 123, 0.4), width: 1.px),
          ),
        ]),
        css('h3').styles(
          fontSize: 1.35.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 0.4.rem),
          lineHeight: 1.35.em,
        ),
        css('.course-subtitle').styles(
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          margin: Margin.only(bottom: 1.rem),
        ),
      ]),
      css('.course-meta', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(6.px),
          padding: Padding.all(0.8.rem),
          backgroundColor: Color.rgba(15, 23, 42, 0.6),
          radius: BorderRadius.all(Radius.circular(12.px)),
          margin: Margin.only(bottom: 1.rem),
          border: Border.all(color: Color.rgba(255, 255, 255, 0.05), width: 1.px),
        ),
        css('.meta-item').styles(
          fontSize: 0.85.rem,
          color: textMutedColor,
          fontWeight: FontWeight.w500,
        ),
      ]),
      css('.course-desc').styles(
        fontSize: 0.92.rem,
        color: textMutedColor,
        lineHeight: 1.55.em,
        margin: Margin.only(bottom: 1.2.rem),
        flex: Flex(grow: 1),
      ),
      css('.course-topics-title').styles(
        fontSize: 0.85.rem,
        fontWeight: FontWeight.w700,
        color: textColor,
        margin: Margin.only(bottom: 0.6.rem),
        raw: {'text-transform': 'uppercase'},
      ),
      css('.course-topics', [
        css('&').styles(
          listStyle: ListStyle.none,
          padding: Padding.zero,
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('li', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.start,
            fontSize: 0.88.rem,
            color: textMutedColor,
            margin: Margin.only(bottom: 6.px),
            lineHeight: 1.4.em,
          ),
          css('.check-icon').styles(
            color: emeraldAccent,
            fontWeight: FontWeight.w800,
            margin: Margin.only(right: 8.px),
          ),
        ]),
      ]),
      css('.course-footer', [
        css('&').styles(
          margin: Margin.only(top: Unit.auto),
          width: 100.percent,
        ),
        css('.btn').styles(
          display: Display.flex,
          justifyContent: JustifyContent.center,
          alignItems: AlignItems.center,
          width: 100.percent,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          fontWeight: FontWeight.w700,
          fontSize: 0.95.rem,
          boxSizing: BoxSizing.borderBox,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          transition: Transition('all', duration: Duration(milliseconds: 250)),
        ),
        css('.btn-primary', [
          css('&').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 12.px, color: Color.rgba(251, 197, 26, 0.3)),
          ),
          css('&:hover').styles(
            backgroundColor: secondaryColor,
            color: textColor,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 18.px, color: Color.rgba(255, 87, 123, 0.4)),
          ),
        ]),
        css('.btn-free', [
          css('&').styles(
            backgroundColor: Color.rgba(110, 242, 123, 0.15),
            color: emeraldAccent,
            border: Border.all(color: Color.rgba(110, 242, 123, 0.5), width: 1.px),
          ),
          css('&:hover').styles(
            backgroundColor: emeraldAccent,
            color: backgroundColor,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(110, 242, 123, 0.4)),
          ),
        ]),
      ]),
    ]),
  ];
}
