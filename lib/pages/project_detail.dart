import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../data/projects_data.dart';
import '../utils/scroll_helper.dart';

class ProjectDetailPage extends StatefulComponent {
  final String projectId;
  const ProjectDetailPage({required this.projectId, super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();

  @css
  static List<StyleRule> get styles => _ProjectDetailPageState.styles;
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
    scrollToTop();
  }

  @override
  Component build(BuildContext context) {
    final project = getProjectById(component.projectId);

    if (project == null) {
      return section(classes: 'project-detail-container', [
        div(classes: 'not-found', [
          h1([Component.text('Project Not Found')]),
          p([Component.text('The project you are looking for does not exist.')]),
          Link(to: '/', child: Component.text('← Back to Portfolio')),
        ]),
      ]);
    }

    return section(classes: 'project-detail-container', [
      // Top Navigation back link
      div(classes: 'back-nav', [
        Link(to: '/', child: Component.text('← Back to Portfolio')),
      ]),

      // Hero Header
      div(classes: 'project-hero', [
        div(classes: 'main-tag-wrapper', [
          span(classes: 'main-tag-badge', [Component.text(project.mainTag)]),
        ]),
        div(classes: 'tags-list', [
          for (var tag in project.tags) span(classes: 'tag-chip', [Component.text(tag)]),
        ]),
        h1([Component.text(project.title)]),
        p(classes: 'project-subtitle', [Component.text(project.subtitle)]),

        // Links
        div(classes: 'project-links', [
          if (project.demoUrl != null)
            a(
              href: project.demoUrl!,
              target: Target.blank,
              classes: 'btn btn-primary',
              [Component.text('🚀 View Live Demo')],
            ),
          if (project.githubUrl != null)
            a(
              href: project.githubUrl!,
              target: Target.blank,
              classes: 'btn btn-secondary',
              [Component.text('💻 Source Code')],
            ),
        ]),
      ]),

      // Overview / Full Description Section
      div(classes: 'detail-section', [
        h2([Component.text('Project Overview')]),
        p(classes: 'full-description', [Component.text(project.fullDescription)]),
      ]),

      // 1. Image Gallery Section
      if (project.images.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('📷 Screenshots & Gallery')]),
          div(classes: 'gallery-grid', [
            for (var imgUrl in project.images)
              div(classes: 'media-card', [
                img(src: imgUrl, alt: project.title),
              ]),
          ]),
        ]),

      // 2. Video Demos Section
      if (project.videos.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('🎥 Video Demos & Screen Recordings')]),
          div(classes: 'video-grid', [
            for (var videoUrl in project.videos)
              div(classes: 'video-card', [
                video(
                  controls: true,
                  src: videoUrl,
                  [],
                ),
              ]),
          ]),
        ]),

      // 3. Animated GIFs Section
      if (project.gifs.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('✨ Animated GIFs & Interactions')]),
          div(classes: 'gallery-grid', [
            for (var gifUrl in project.gifs)
              div(classes: 'media-card gif-card', [
                img(src: gifUrl, alt: '${project.title} GIF'),
              ]),
          ]),
        ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.project-detail-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.all(2.rem),
        boxSizing: BoxSizing.borderBox,
      ),
      css('.back-nav', [
        css('&').styles(
          width: 100.percent,
          margin: Margin.only(bottom: 2.rem),
        ),
        css('a').styles(
          color: primaryColor,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          fontSize: 1.1.rem,
        ),
        css('a:hover').styles(
          color: textColor,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
        ),
      ]),
      css('.project-hero', [
        css('&').styles(
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          padding: Padding.all(2.5.rem),
          margin: Margin.only(bottom: 3.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(0, 0, 0, 0.3)),
        ),
        css('h1').styles(
          fontSize: 3.rem,
          fontWeight: FontWeight.w800,
          margin: Margin.symmetric(vertical: 0.5.rem),
        ),
        css('.project-subtitle').styles(
          fontSize: 1.3.rem,
          color: textMutedColor,
          margin: Margin.only(bottom: 1.5.rem),
        ),
      ]),
      css('.main-tag-wrapper', [
        css('&').styles(
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.main-tag-badge').styles(
          display: Display.inlineFlex,
          alignItems: AlignItems.center,
          backgroundColor: Color.rgba(129, 140, 248, 0.16),
          color: accentColor,
          border: Border.all(color: Color.rgba(129, 140, 248, 0.4), width: 1.px),
          padding: Padding.symmetric(vertical: 4.px, horizontal: 12.px),
          radius: BorderRadius.all(Radius.circular(14.px)),
          fontSize: 0.85.rem,
          fontWeight: FontWeight.w700,
        ),
      ]),
      css('.tags-list', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          margin: Margin.only(bottom: 1.rem),
        ),
        css('.tag-chip').styles(
          backgroundColor: Color.rgba(56, 189, 248, 0.15),
          color: primaryColor,
          padding: Padding.symmetric(vertical: 6.px, horizontal: 14.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          margin: Margin.only(right: 8.px, bottom: 8.px),
          fontSize: 0.9.rem,
          fontWeight: FontWeight.w600,
          border: Border.all(color: Color.rgba(56, 189, 248, 0.3), width: 1.px),
        ),
      ]),
      css('.project-links', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          margin: Margin.only(top: 1.5.rem),
        ),
        css('.btn').styles(
          display: Display.inlineFlex,
          alignItems: AlignItems.center,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 24.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          fontWeight: FontWeight.w700,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          margin: Margin.only(right: 1.rem, bottom: 0.5.rem),
        ),
        css('.btn-primary').styles(
          backgroundColor: primaryColor,
          color: backgroundColor,
        ),
        css('.btn-secondary').styles(
          backgroundColor: Color.rgba(255, 255, 255, 0.08),
          color: textColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
        ),
      ]),
      css('.detail-section', [
        css('&').styles(
          margin: Margin.only(bottom: 3.5.rem),
        ),
        css('h2').styles(
          fontSize: 1.8.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 1.2.rem),
          border: Border.only(
            bottom: BorderSide.solid(color: surfaceBorder, width: 1.px),
          ),
          padding: Padding.only(bottom: 0.5.rem),
        ),
        css('.full-description').styles(
          fontSize: 1.15.rem,
          lineHeight: 1.8.em,
          color: textMutedColor,
          whiteSpace: WhiteSpace.preWrap,
        ),
      ]),
      css('.gallery-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
        ),
        css('.media-card').styles(
          width: 300.px,
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          overflow: Overflow.hidden,
          margin: Margin.all(10.px),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.2)),
        ),
        css('.media-card img').styles(
          width: 100.percent,
          height: 240.px,
          display: Display.block,
        ),
      ]),
      css('.video-grid', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
        ),
        css('.video-card').styles(
          backgroundColor: surfaceColor,
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          overflow: Overflow.hidden,
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('.video-card video').styles(
          width: 100.percent,
          maxHeight: 500.px,
          display: Display.block,
        ),
      ]),
    ]),
  ];
}
