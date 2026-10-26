import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';
import '../utils/video_url_helper.dart';

class VideoEmbedPlayer extends StatelessComponent {
  final String videoUrl;
  final String? title;
  final String? subtitle;
  final bool showBadge;

  const VideoEmbedPlayer({
    required this.videoUrl,
    this.title,
    this.subtitle,
    this.showBadge = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final parsed = VideoUrlHelper.parse(videoUrl);

    if (!parsed.isPlayable) {
      return div(classes: 'video-embed-container empty-player', [
        div(classes: 'video-empty-state', [
          span(classes: 'empty-play-icon', [Component.text('🎬')]),
          h4([Component.text(title ?? 'No Video Available')]),
          p([
            Component.text(
              subtitle ?? 'Video link is either empty or not a supported YouTube / Google Drive / MP4 URL.',
            ),
          ]),
        ]),
      ]);
    }

    return div(classes: 'video-embed-container', [
      if (title != null || showBadge)
        div(classes: 'video-player-top-bar', [
          div(classes: 'video-title-wrap', [
            if (title != null) strong([Component.text(title!)]),
            if (subtitle != null) span(classes: 'video-sub-text', [Component.text(subtitle!)]),
          ]),
          if (showBadge)
            span(
              classes: 'video-platform-pill ${parsed.isYouTube ? "pill-yt" : parsed.isGoogleDrive ? "pill-drive" : "pill-mp4"}',
              [Component.text('${parsed.platformBadgeIcon} ${parsed.platformLabel}')],
            ),
        ]),
      div(classes: 'video-embed-viewport', [
        if (parsed.isDirectVideo)
          video(
            controls: true,
            src: parsed.embedUrl,
            attributes: {'playsinline': 'true'},
            [],
          )
        else
          iframe(
            src: parsed.embedUrl,
            attributes: {
              'allowfullscreen': 'true',
              'allow': 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture',
              'frameborder': '0',
            },
            [],
          ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.video-embed-container', [
      css('&').styles(
        width: 100.percent,
        backgroundColor: Color.rgba(11, 17, 32, 0.95),
        border: Border.all(color: cardBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(18.px)),
        overflow: Overflow.hidden,
        shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 28.px, color: Color.rgba(0, 0, 0, 0.45)),
        margin: Margin.only(bottom: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
      ),
      css('&.empty-player').styles(
        padding: Padding.all(2.5.rem),
        raw: {'border-style': 'dashed'},
      ),
      css('.video-empty-state', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          justifyContent: JustifyContent.center,
          textAlign: TextAlign.center,
          padding: Padding.all(2.rem),
        ),
        css('.empty-play-icon').styles(
          fontSize: 3.rem,
          margin: Margin.only(bottom: 0.8.rem),
          raw: {'opacity': '0.7'},
        ),
        css('h4').styles(
          fontSize: 1.2.rem,
          color: textColor,
          margin: Margin.only(bottom: 0.4.rem),
        ),
        css('p').styles(
          fontSize: 0.9.rem,
          color: textMutedColor,
          margin: Margin.zero,
          maxWidth: 440.px,
        ),
      ]),
      css('.video-player-top-bar', [
        css('&').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          padding: Padding.symmetric(vertical: 0.85.rem, horizontal: 1.2.rem),
          backgroundColor: Color.rgba(15, 23, 42, 0.8),
          raw: {'border-bottom': '1px solid rgba(255, 255, 255, 0.06)'},
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(8.px),
        ),
        css('.video-title-wrap', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(10.px),
            flexWrap: FlexWrap.wrap,
          ),
          css('strong').styles(
            fontSize: 0.95.rem,
            color: textColor,
          ),
          css('.video-sub-text').styles(
            fontSize: 0.82.rem,
            color: primaryColor,
          ),
        ]),
        css('.video-platform-pill', [
          css('&').styles(
            padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
            radius: BorderRadius.all(Radius.circular(8.px)),
            fontSize: 0.78.rem,
            fontWeight: FontWeight.w700,
          ),
          css('&.pill-yt').styles(
            backgroundColor: Color.rgba(255, 0, 0, 0.15),
            color: Color('#ff4b4b'),
            border: Border.all(color: Color.rgba(255, 0, 0, 0.3), width: 1.px),
          ),
          css('&.pill-drive').styles(
            backgroundColor: Color.rgba(66, 133, 244, 0.15),
            color: Color('#60a5fa'),
            border: Border.all(color: Color.rgba(66, 133, 244, 0.3), width: 1.px),
          ),
          css('&.pill-mp4').styles(
            backgroundColor: Color.rgba(110, 242, 123, 0.15),
            color: emeraldAccent,
            border: Border.all(color: Color.rgba(110, 242, 123, 0.3), width: 1.px),
          ),
        ]),
      ]),
      css('.video-embed-viewport', [
        css('&').styles(
          position: Position.relative(),
          width: 100.percent,
          backgroundColor: Color('#000000'),
          raw: {
            'aspect-ratio': '16 / 9',
          },
        ),
        css('iframe, video').styles(
          position: Position.absolute(top: 0.px, left: 0.px),
          width: 100.percent,
          height: 100.percent,
          border: Border.unset,
          raw: {
            'object-fit': 'contain',
          },
        ),
      ]),
    ]),
  ];
}
