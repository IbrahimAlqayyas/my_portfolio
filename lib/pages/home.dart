import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../data/projects_data.dart';
import '../models/project.dart';
import '../utils/scroll_helper.dart';

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  @css
  static List<StyleRule> get styles => _HomeState.styles;
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    return section(classes: 'home-container', [
      // Hero Section
      div(classes: 'hero-section', [
        div(classes: 'hero-badge', [
          Component.text('👋 Welcome to my Portfolio'),
        ]),
        h1([Component.text('Ibrahim AlQyas')]),
        p(classes: 'hero-title', [
          Component.text('Mobile & Web Software Engineer (Flutter & Jaspr)'),
        ]),
        p(classes: 'hero-bio', [
          Component.text(
            'I am an experienced software engineer with +6 years of experience specializing in Flutter and Jaspr. I am passionate about building high-quality, user-focused applications that solve real-world problems.',
          ),
          br(),
          br(),
          Component.text(
            'My expertise includes mobile app development, web applications, and end-to-end software solutions. I am committed to writing clean, maintainable code and delivering exceptional digital experiences.',
          ),
        ]),
        div(classes: 'hero-actions', [
          a(
            href: '#projects',
            classes: 'btn btn-primary',
            events: {
              'click': (e) {
                e.preventDefault();
                scrollToId('projects');
              },
            },
            [Component.text('Explore Projects ↓')],
          ),
          Link(to: '/contact', classes: 'btn btn-secondary', child: Component.text('Get in Touch')),
        ]),
      ]),

      // Projects Section
      div(id: 'projects', classes: 'projects-section', [
        div(classes: 'section-header', [
          h2([Component.text('Featured Work & Projects')]),
          p([Component.text('A showcase of my recent mobile apps, web applications, and technical projects.')]),
        ]),

        div(classes: 'projects-grid', [
          for (var project in projectsList) _ProjectCard(project: project),
        ]),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.home-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.all(2.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.hero-section', [
        css('&').styles(
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          textAlign: TextAlign.center,
          padding: Padding.symmetric(vertical: 4.rem, horizontal: 2.rem),
          margin: Margin.only(bottom: 4.rem),
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(0, 0, 0, 0.4)),
        ),
        css('.hero-badge').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.12),
          color: primaryColor,
          padding: Padding.symmetric(vertical: 8.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.2.rem),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
        ),
        css('h1').styles(
          fontSize: 3.8.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.zero,
        ),
        css('.hero-title').styles(
          fontSize: 1.5.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          margin: Margin.symmetric(vertical: 0.8.rem),
        ),
        css('.hero-bio').styles(
          fontSize: 1.15.rem,
          lineHeight: 1.7.em,
          color: textMutedColor,
          maxWidth: 750.px,
          margin: Margin.only(bottom: 2.rem),
        ),
        css('.hero-actions', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
          ),
          css('.btn').styles(
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            padding: Padding.symmetric(vertical: 14.px, horizontal: 28.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            fontWeight: FontWeight.w700,
            fontSize: 1.05.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            margin: Margin.symmetric(horizontal: 8.px, vertical: 6.px),
            transition: Transition('all', duration: Duration(milliseconds: 300)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.4)),
              transition: Transition('all', duration: Duration(milliseconds: 300)),
            ),
            css('&:hover').styles(
              backgroundColor: secondaryColor,
              color: textColor,
              shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 20.px, color: Color.rgba(255, 87, 123, 0.5)),
            ),
          ]),
          css('.btn-secondary', [
            css('&').styles(
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              color: textColor,
              border: Border.all(color: surfaceBorder, width: 1.px),
              transition: Transition('all', duration: Duration(milliseconds: 300)),
            ),
            css('&:hover').styles(
              border: Border.all(color: Color('#ffffff'), width: 1.px),
              shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(255, 255, 255, 0.15)),
            ),
          ]),
        ]),
      ]),
      css('.projects-section', [
        css('&').styles(
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
        css('.section-header', [
          css('&').styles(
            textAlign: TextAlign.center,
            margin: Margin.only(bottom: 2.5.rem),
          ),
          css('h2').styles(
            fontSize: 2.4.rem,
            fontWeight: FontWeight.w800,
            color: textColor,
            margin: Margin.only(bottom: 0.5.rem),
          ),
          css('p').styles(
            fontSize: 1.15.rem,
            color: textMutedColor,
          ),
        ]),
        css('.projects-grid', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            justifyContent: JustifyContent.center,
          ),
        ]),
      ]),
    ]),
    ..._ProjectCard.styles,
  ];
}

class _ProjectCard extends StatelessComponent {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  Component build(BuildContext context) {
    return Link(
      to: '/projects/${project.id}',
      child: div(classes: 'project-card', [
        div(classes: 'card-image-wrapper', [
          img(src: project.coverImage, alt: project.title),
        ]),
        div(classes: 'card-content', [
          div(classes: 'main-tag-wrapper', [
            span(classes: 'main-tag-badge', [Component.text(project.mainTag)]),
          ]),
          div(classes: 'card-tags', [
            for (var tag in project.tags.take(3)) span(classes: 'card-tag', [Component.text(tag)]),
          ]),
          h3([Component.text(project.title)]),
          p([Component.text(project.shortDescription)]),
          div(classes: 'card-footer', [
            span(classes: 'read-more', [Component.text('View Project Details →')]),
          ]),
        ]),
      ]),
    );
  }

  static List<StyleRule> get styles => [
    css('.project-card', [
      css('&').styles(
        width: 320.px,
        backgroundColor: surfaceColor,
        border: Border.all(color: surfaceBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(20.px)),
        overflow: Overflow.hidden,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        margin: Margin.all(12.px),
        shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.3)),
      ),
      css('&:hover').styles(
        border: Border.all(color: primaryColor, width: 1.px),
      ),
      css('.card-image-wrapper img').styles(
        width: 100.percent,
        height: 200.px,
        display: Display.block,
      ),
      css('.card-content', [
        css('&').styles(
          padding: Padding.all(1.5.rem),
          display: Display.flex,
          flexDirection: FlexDirection.column,
          flex: Flex(grow: 1),
        ),
        css('.main-tag-wrapper', [
          css('&').styles(
            margin: Margin.only(bottom: 0.6.rem),
          ),
          css('.main-tag-badge').styles(
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            backgroundColor: Color.rgba(255, 87, 123, 0.16),
            color: accentColor,
            border: Border.all(color: Color.rgba(255, 87, 123, 0.4), width: 1.px),
            padding: Padding.symmetric(vertical: 3.px, horizontal: 10.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.78.rem,
            fontWeight: FontWeight.w700,
          ),
        ]),
        css('.card-tags').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.card-tag').styles(
          fontSize: 0.8.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          backgroundColor: Color.rgba(251, 197, 26, 0.12),
          padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          margin: Margin.only(right: 6.px, bottom: 4.px),
        ),
        css('h3').styles(
          fontSize: 1.4.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 0.5.rem),
        ),
        css('p').styles(
          fontSize: 0.98.rem,
          color: textMutedColor,
          lineHeight: 1.5.em,
          margin: Margin.only(bottom: 1.2.rem),
          flex: Flex(grow: 1),
        ),
        css('.card-footer .read-more').styles(
          fontSize: 0.95.rem,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ]),
    ]),
  ];
}
