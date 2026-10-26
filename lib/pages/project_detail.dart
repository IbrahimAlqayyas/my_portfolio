import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/video_embed_player.dart';
import '../constants/theme.dart';
import '../data/projects_data.dart';
import '../services/content_repository.dart';
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
    contentRepository.init();
  }

  @override
  Component build(BuildContext context) {
    String currentId = component.projectId;
    if (currentId.isEmpty) {
      try {
        final loc = RouteState.of(context).location;
        final segments = loc.split('?').first.split('/').where((seg) => seg.isNotEmpty).toList();
        if (segments.length >= 2 && segments[0] == 'projects') {
          currentId = segments[1];
        }
      } catch (_) {}
    }

    final project = contentRepository.getProjectById(currentId) ?? getProjectById(currentId);

    if (project == null) {
      return section(classes: 'project-detail-container', [
        div(classes: 'not-found', [
          h1([Component.text('Project Not Found')]),
          p([Component.text('The project you are looking for does not exist.')]),
          Link(to: '/projects', child: Component.text('← Back to Shared Portfolio')),
        ]),
      ]);
    }

    final isSoftware = project.category == 'software';

    return section(classes: 'project-detail-container', [
      // Top Navigation back link
      div(classes: 'back-nav', [
        Link(to: '/projects', child: Component.text('← Back to Shared Portfolio')),
      ]),

      // Hero Header
      div(classes: 'project-hero', [
        div(classes: 'hero-badges-row', [
          span(
            classes: 'category-badge ${isSoftware ? "badge-software" : "badge-engineering"}',
            [Component.text(isSoftware ? '💻 Software & Mobile App' : '⚡ E&I Industrial Engineering')],
          ),
          span(classes: 'main-tag-badge', [Component.text(project.mainTag)]),
          if (project.clientOrScope != null)
            span(classes: 'scope-tag', [Component.text('Scope: ${project.clientOrScope!}')]),
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
          Link(
            to: '/contact',
            classes: 'btn btn-secondary',
            child: Component.text('Inquire About This Scope →'),
          ),
        ]),
      ]),

      // Overview / Full Description Section
      div(classes: 'detail-section', [
        h2([Component.text('Project Overview & Architecture')]),
        p(classes: 'full-description', [Component.text(project.fullDescription)]),
      ]),

      // Key Deliverables & Engineering Outcomes
      if (project.deliverables.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('🎯 Key Deliverables & Outcomes')]),
          ul(classes: 'deliverables-list', [
            for (var item in project.deliverables)
              li([
                span(classes: 'check-bullet', [Component.text('✓')]),
                span([Component.text(item)]),
              ]),
          ]),
        ]),

      // 1. Image Gallery Section
      if (project.images.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('📷 Documentation & Visual Gallery')]),
          div(classes: 'gallery-grid', [
            for (var imgUrl in project.images)
              div(classes: 'media-card', [
                img(src: imgUrl, alt: project.title),
              ]),
          ]),
        ]),

      // 2. Video Demos Section (Embedded Player for YouTube, Google Drive, or MP4)
      if (project.primaryVideoUrl != null && project.primaryVideoUrl!.trim().isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('🎥 Video Walkthrough & Screen Recording')]),
          p(classes: 'section-sub-text', [
            Component.text('Watch the live interactive walkthrough. Direct embedded playback supports quality settings on YouTube and Google Drive.'),
          ]),
          VideoEmbedPlayer(
            videoUrl: project.primaryVideoUrl!,
            title: '${project.title} • Video Walkthrough',
            subtitle: 'Live Embedded Stream',
          ),
          if (project.videos.length > 1)
            for (var videoUrl in project.videos.where((v) => v != project.primaryVideoUrl))
              VideoEmbedPlayer(
                videoUrl: videoUrl,
                title: 'Additional Feature Video',
              ),
        ]),

      // 3. Animated GIFs Section
      if (project.gifs.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('✨ Animated Demos & Interactions')]),
          div(classes: 'gallery-grid', [
            for (var gifUrl in project.gifs)
              div(classes: 'media-card gif-card', [
                img(src: gifUrl, alt: '${project.title} GIF'),
              ]),
          ]),
        ]),

      // Bottom Navigation / CTA
      div(classes: 'detail-bottom-cta', [
        h3([Component.text('Interested in replicating these results?')]),
        p([Component.text('Let’s discuss your technical scope or software application requirements.')]),
        div(classes: 'bottom-actions', [
          Link(to: '/contact', classes: 'btn btn-primary', child: Component.text('Schedule Consultation / Hire →')),
          Link(to: '/projects', classes: 'btn btn-secondary', child: Component.text('Browse More Projects →')),
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
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
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
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          margin: Margin.only(bottom: 3.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 24.px, color: Color.rgba(0, 0, 0, 0.3)),
          raw: cardBackdropFilter,
        ),
        css('.hero-badges-row', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(10.px),
            margin: Margin.only(bottom: 1.rem),
          ),
          css('.category-badge').styles(
            padding: Padding.symmetric(vertical: 4.px, horizontal: 12.px),
            radius: BorderRadius.all(Radius.circular(10.px)),
            fontSize: 0.82.rem,
            fontWeight: FontWeight.w700,
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
          css('.main-tag-badge').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.08),
            color: textColor,
            border: Border.all(color: surfaceBorder, width: 1.px),
            padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
            radius: BorderRadius.all(Radius.circular(10.px)),
            fontSize: 0.82.rem,
            fontWeight: FontWeight.w600,
          ),
          css('.scope-tag').styles(
            color: textMutedColor,
            fontSize: 0.85.rem,
          ),
        ]),
        css('h1').styles(
          fontSize: 3.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.8.rem),
          lineHeight: 1.2.em,
        ),
        css('.project-subtitle').styles(
          fontSize: 1.25.rem,
          color: textMutedColor,
          lineHeight: 1.6.em,
          margin: Margin.only(bottom: 2.rem),
        ),
        css('.tags-list', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            margin: Margin.only(bottom: 1.5.rem),
          ),
          css('.tag-chip').styles(
            backgroundColor: Color.rgba(251, 197, 26, 0.1),
            color: primaryColor,
            border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
            padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.88.rem,
            fontWeight: FontWeight.w600,
            margin: Margin.only(right: 8.px, bottom: 8.px),
          ),
        ]),
        css('.project-links', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            padding: Padding.symmetric(vertical: 12.px, horizontal: 24.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontWeight: FontWeight.w700,
            fontSize: 1.05.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
            ),
            css('&:hover').styles(
              backgroundColor: secondaryColor,
              color: textColor,
            ),
          ]),
          css('.btn-secondary', [
            css('&').styles(
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              color: textColor,
              border: Border.all(color: surfaceBorder, width: 1.px),
            ),
            css('&:hover').styles(
              raw: {'border-color': '#ffffff'},
            ),
          ]),
        ]),
      ]),
      css('.detail-section', [
        css('&').styles(
          width: 100.percent,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          padding: Padding.all(2.rem),
          margin: Margin.only(bottom: 2.5.rem),
          boxSizing: BoxSizing.borderBox,
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 1.8.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 1.2.rem),
        ),
        css('.section-sub-text').styles(
          color: textMutedColor,
          fontSize: 0.95.rem,
          margin: Margin.only(bottom: 1.2.rem),
          lineHeight: 1.5.em,
        ),
        css('.full-description').styles(
          fontSize: 1.1.rem,
          color: textMutedColor,
          lineHeight: 1.7.em,
          whiteSpace: WhiteSpace.preLine,
        ),
        css('.deliverables-list', [
          css('&').styles(
            listStyle: ListStyle.none,
            padding: Padding.zero,
            margin: Margin.zero,
          ),
          css('li', [
            css('&').styles(
              display: Display.flex,
              alignItems: AlignItems.center,
              fontSize: 1.05.rem,
              color: textColor,
              margin: Margin.only(bottom: 10.px),
            ),
            css('.check-bullet').styles(
              color: emeraldAccent,
              fontWeight: FontWeight.w800,
              margin: Margin.only(right: 10.px),
            ),
          ]),
        ]),
      ]),
      css('.gallery-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(1.2.rem),
        ),
        css('.media-card').styles(
          width: 320.px,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          overflow: Overflow.hidden,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 16.px, color: Color.rgba(0, 0, 0, 0.2)),
        ),
        css('.media-card img').styles(
          width: 100.percent,
          height: 220.px,
          display: Display.block,
          raw: {'object-fit': 'cover'},
        ),
      ]),
      css('.video-grid', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(1.5.rem),
        ),
        css('.video-card').styles(
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          overflow: Overflow.hidden,
        ),
        css('.video-card video').styles(
          width: 100.percent,
          maxHeight: 500.px,
          display: Display.block,
        ),
      ]),
      css('.detail-bottom-cta', [
        css('&').styles(
          width: 100.percent,
          backgroundColor: cardBackground,
          border: Border.all(color: primaryColor, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          padding: Padding.all(2.5.rem),
          boxSizing: BoxSizing.borderBox,
          textAlign: TextAlign.center,
          margin: Margin.only(top: 1.rem, bottom: 3.rem),
          raw: cardBackdropFilter,
        ),
        css('h3').styles(
          fontSize: 1.6.rem,
          fontWeight: FontWeight.w700,
          color: textColor,
          margin: Margin.only(bottom: 0.6.rem),
        ),
        css('p').styles(
          fontSize: 1.05.rem,
          color: textMutedColor,
          margin: Margin.only(bottom: 1.8.rem),
        ),
        css('.bottom-actions', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.center,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(12.px),
          ),
          css('.btn').styles(
            padding: Padding.symmetric(vertical: 12.px, horizontal: 24.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontWeight: FontWeight.w700,
            fontSize: 0.95.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('.btn-primary', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
            ),
            css('&:hover').styles(
              backgroundColor: secondaryColor,
              color: textColor,
            ),
          ]),
          css('.btn-secondary', [
            css('&').styles(
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              color: textColor,
              border: Border.all(color: surfaceBorder, width: 1.px),
            ),
            css('&:hover').styles(
              raw: {'border-color': '#ffffff'},
            ),
          ]),
        ]),
      ]),
    ]),
  ];
}
