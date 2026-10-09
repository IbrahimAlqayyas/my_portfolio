import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../models/project.dart';

class ProjectCard extends StatelessComponent {
  final Project project;
  const ProjectCard({required this.project, super.key});

  @override
  Component build(BuildContext context) {
    final isSoftware = project.category == 'software';

    return Link(
      to: '/projects/${project.id}',
      child: div(classes: 'project-card', [
        div(classes: 'card-image-wrapper', [
          img(src: project.coverImage, alt: project.title),
          div(classes: 'category-badge ${isSoftware ? "badge-software" : "badge-engineering"}', [
            Component.text(isSoftware ? '💻 Software & Apps' : '⚡ E&I Engineering'),
          ]),
        ]),
        div(classes: 'card-content', [
          div(classes: 'main-tag-wrapper', [
            span(classes: 'main-tag-badge', [Component.text(project.mainTag)]),
            if (project.clientOrScope != null)
              span(classes: 'scope-tag', [Component.text(project.clientOrScope!)]),
          ]),
          h3([Component.text(project.title)]),
          p([Component.text(project.shortDescription)]),
          div(classes: 'card-tags', [
            for (var tag in project.tags.take(3))
              span(classes: 'card-tag', [Component.text(tag)]),
          ]),
          div(classes: 'card-footer', [
            span(classes: 'read-more', [Component.text('Explore Case Study →')]),
          ]),
        ]),
      ]),
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.project-card', [
      css('&').styles(
        width: 340.px,
        backgroundColor: cardBackground,
        border: Border.all(color: cardBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(20.px)),
        overflow: Overflow.hidden,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        margin: Margin.all(12.px),
        shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 20.px, color: Color.rgba(0, 0, 0, 0.35)),
        raw: {
          'backdrop-filter': 'blur(16px)',
          '-webkit-backdrop-filter': 'blur(16px)',
          'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        },
      ),
      css('&:hover').styles(
        border: Border.all(color: primaryColor, width: 1.px),
        shadow: BoxShadow(offsetX: 0.px, offsetY: 12.px, blur: 30.px, color: Color.rgba(251, 197, 26, 0.2)),
        raw: {'transform': 'translateY(-4px)'},
      ),
      css('.card-image-wrapper', [
        css('&').styles(
          position: Position.relative(),
          overflow: Overflow.hidden,
          height: 190.px,
        ),
        css('img').styles(
          width: 100.percent,
          height: 100.percent,
          display: Display.block,
          raw: {
            'object-fit': 'cover',
            'transition': 'transform 0.4s ease',
          },
        ),
        css('.category-badge').styles(
          position: Position.absolute(top: 12.px, left: 12.px),
          padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
          radius: BorderRadius.all(Radius.circular(10.px)),
          fontSize: 0.75.rem,
          fontWeight: FontWeight.w700,
          raw: {'backdrop-filter': 'blur(8px)'},
        ),
        css('.badge-software').styles(
          backgroundColor: Color.rgba(15, 23, 42, 0.85),
          color: primaryColor,
          border: Border.all(color: Color.rgba(251, 197, 26, 0.5), width: 1.px),
        ),
        css('.badge-engineering').styles(
          backgroundColor: Color.rgba(15, 23, 42, 0.85),
          color: secondaryColor,
          border: Border.all(color: Color.rgba(255, 87, 123, 0.5), width: 1.px),
        ),
      ]),
      css('&:hover .card-image-wrapper img').styles(
        raw: {'transform': 'scale(1.05)'},
      ),
      css('.card-content', [
        css('&').styles(
          padding: Padding.all(1.4.rem),
          display: Display.flex,
          flexDirection: FlexDirection.column,
          flex: Flex(grow: 1),
        ),
        css('.main-tag-wrapper', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(6.px),
            margin: Margin.only(bottom: 0.6.rem),
          ),
          css('.main-tag-badge').styles(
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            backgroundColor: Color.rgba(255, 87, 123, 0.16),
            color: accentColor,
            border: Border.all(color: Color.rgba(255, 87, 123, 0.4), width: 1.px),
            padding: Padding.symmetric(vertical: 2.px, horizontal: 8.px),
            radius: BorderRadius.all(Radius.circular(8.px)),
            fontSize: 0.75.rem,
            fontWeight: FontWeight.w700,
          ),
          css('.scope-tag').styles(
            fontSize: 0.75.rem,
            color: textMutedColor,
          ),
        ]),
        css('h3').styles(
          fontSize: 1.3.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 0.5.rem),
          lineHeight: 1.35.em,
        ),
        css('p').styles(
          fontSize: 0.95.rem,
          color: textMutedColor,
          lineHeight: 1.55.em,
          margin: Margin.only(bottom: 1.2.rem),
          flex: Flex(grow: 1),
        ),
        css('.card-tags').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(6.px),
          margin: Margin.only(bottom: 1.2.rem),
        ),
        css('.card-tag').styles(
          fontSize: 0.78.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          backgroundColor: Color.rgba(251, 197, 26, 0.1),
          padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
          radius: BorderRadius.all(Radius.circular(8.px)),
        ),
        css('.card-footer', [
          css('&').styles(
            raw: {'border-top': '1px solid rgba(255, 255, 255, 0.08)'},
            padding: Padding.only(top: 1.rem),
          ),
          css('.read-more').styles(
            fontSize: 0.92.rem,
            fontWeight: FontWeight.w700,
            color: primaryColor,
            transition: Transition('color', duration: Duration(milliseconds: 200)),
          ),
        ]),
      ]),
      css('&:hover .card-footer .read-more').styles(
        color: secondaryColor,
      ),
    ]),
  ];
}
