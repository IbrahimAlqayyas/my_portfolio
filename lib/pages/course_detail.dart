import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/video_embed_player.dart';
import '../constants/theme.dart';
import '../data/courses_data.dart';
import '../models/course.dart';
import '../services/content_repository.dart';
import '../utils/scroll_helper.dart';

class CourseDetailPage extends StatefulComponent {
  final String courseId;
  const CourseDetailPage({required this.courseId, super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();

  @css
  static List<StyleRule> get styles => _CourseDetailPageState.styles;
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  String _activeVideoUrl = '';
  String _activeVideoTitle = 'Course Introduction & Overview';
  String? _activeLessonId;
  final Set<String> _expandedChapters = {};
  bool _initializedVideo = false;

  @override
  void initState() {
    super.initState();
    scrollToTop();
    contentRepository.init();
  }

  void _initCourseVideo(Course course) {
    if (_initializedVideo) return;
    _initializedVideo = true;

    // Expand all chapters by default
    for (var ch in course.chapters) {
      _expandedChapters.add(ch.id);
    }

    if (course.introVideoUrl != null && course.introVideoUrl!.trim().isNotEmpty) {
      _activeVideoUrl = course.introVideoUrl!.trim();
      _activeVideoTitle = 'Course Intro & Overview';
      _activeLessonId = null;
    } else if (course.chapters.isNotEmpty && course.chapters.first.lessons.isNotEmpty) {
      final firstLesson = course.chapters.first.lessons.first;
      _activeVideoUrl = firstLesson.videoUrl;
      _activeVideoTitle = firstLesson.title;
      _activeLessonId = firstLesson.id;
    }
  }

  void _selectVideo({required String url, required String title, String? lessonId}) {
    setState(() {
      _activeVideoUrl = url;
      _activeVideoTitle = title;
      _activeLessonId = lessonId;
    });
    // Scroll smoothly to player
    scrollToId('course-video-player-section');
  }

  void _toggleChapter(String chapterId) {
    setState(() {
      if (_expandedChapters.contains(chapterId)) {
        _expandedChapters.remove(chapterId);
      } else {
        _expandedChapters.add(chapterId);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final course = contentRepository.getCourseById(component.courseId) ?? getCourseById(component.courseId);

    if (course == null) {
      return section(classes: 'course-detail-container', [
        div(classes: 'not-found-box', [
          span(classes: 'not-found-icon', [Component.text('🔍')]),
          h1([Component.text('Course Not Found')]),
          p([Component.text('The course or learning module you are looking for does not exist.')]),
          Link(to: '/courses', classes: 'btn btn-primary', child: Component.text('← Back to Courses & Academy')),
        ]),
      ]);
    }

    _initCourseVideo(course);

    final isSoftware = course.category == 'software';

    return section(classes: 'course-detail-container', [
      // Top Navigation back link
      div(classes: 'back-nav', [
        Link(to: '/courses', child: Component.text('← Back to Courses & Academy Catalog')),
      ]),

      // Course Hero Header
      div(classes: 'course-hero', [
        div(classes: 'hero-badges-row', [
          span(
            classes: 'category-badge ${isSoftware ? "badge-software" : "badge-engineering"}',
            [Component.text('${course.icon} ${course.categoryLabel}')],
          ),
          span(classes: 'level-badge', [Component.text('🎯 ${course.level}')]),
          span(classes: 'badge-pill-accent', [Component.text(course.badge)]),
          if (course.isFree) span(classes: 'badge-free-pill', [Component.text('FREE')]),
        ]),
        h1([Component.text(course.title)]),
        p(classes: 'course-subtitle', [Component.text(course.subtitle)]),
        p(classes: 'course-desc-full', [Component.text(course.description)]),

        // Hero Stats Bar
        div(classes: 'hero-stats-row', [
          div(classes: 'stat-item', [
            span(classes: 'stat-icon', [Component.text('⏱️')]),
            div([
              span(classes: 'stat-label', [Component.text('Duration')]),
              strong([Component.text(course.duration)]),
            ]),
          ]),
          div(classes: 'stat-item', [
            span(classes: 'stat-icon', [Component.text('📚')]),
            div([
              span(classes: 'stat-label', [Component.text('Curriculum')]),
              strong([Component.text('${course.chapters.length} Chapters • ${course.totalLessonsCount} Lectures')]),
            ]),
          ]),
          div(classes: 'stat-item', [
            span(classes: 'stat-icon', [Component.text('⚡')]),
            div([
              span(classes: 'stat-label', [Component.text('Access')]),
              strong([Component.text(course.isFree ? 'Free Starter Access' : 'Full Lifetime Access')]),
            ]),
          ]),
        ]),
      ]),

      // 1. Interactive Embedded Video Theater
      div(id: 'course-video-player-section', classes: 'detail-section theater-section', [
        div(classes: 'player-header-bar', [
          div(classes: 'now-playing-info', [
            span(classes: 'live-dot', []),
            strong([Component.text('Now Playing: ')]),
            span(classes: 'now-playing-title', [Component.text(_activeVideoTitle)]),
          ]),
          if (_activeVideoUrl.isNotEmpty)
            a(
              href: _activeVideoUrl,
              target: Target.blank,
              classes: 'btn-open-external',
              [Component.text('Open Link ↗')],
            ),
        ]),
        VideoEmbedPlayer(
          videoUrl: _activeVideoUrl,
          title: _activeVideoTitle,
          subtitle: 'Direct embedded stream with quality controls (YouTube / Google Drive)',
        ),
        if (course.introVideoUrl != null && course.introVideoUrl!.isNotEmpty && _activeLessonId != null)
          div(classes: 'switch-intro-wrap', [
            button(
              classes: 'btn-switch-intro',
              events: {
                'click': (e) => _selectVideo(
                      url: course.introVideoUrl!,
                      title: 'Course Introduction & Overview',
                      lessonId: null,
                    ),
              },
              [Component.text('⏪ Switch Back to Course Intro Video')],
            ),
          ]),
      ]),

      // 2. Full Course Chapters & Lectures Curriculum (Accordion)
      div(classes: 'detail-section', [
        div(classes: 'section-heading-split', [
          div([
            h2([Component.text('📖 Course Chapters & Video Lectures')]),
            p(classes: 'section-sub-text', [
              Component.text(
                'Explore the syllabus below. Click any lecture to stream it directly in the embedded player above.',
              ),
            ]),
          ]),
          span(classes: 'curriculum-count-pill', [
            Component.text('${course.chapters.length} Chapters • ${course.totalLessonsCount} Lectures'),
          ]),
        ]),

        if (course.chapters.isEmpty)
          div(classes: 'empty-chapters-card', [
            p([Component.text('Curriculum chapters are currently being updated for this course.')]),
          ])
        else
          div(classes: 'chapters-accordion-list', [
            for (var i = 0; i < course.chapters.length; i++)
              _buildChapterAccordion(course.chapters[i], i + 1),
          ]),
      ]),

      // 3. Key Curriculum Topics & Takeaways
      if (course.topics.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('🎯 Key Curriculum Topics & Technical Skills')]),
          div(classes: 'topics-2col-grid', [
            for (var topic in course.topics)
              div(classes: 'topic-item-box', [
                span(classes: 'check-mark-circle', [Component.text('✓')]),
                span(classes: 'topic-item-text', [Component.text(topic)]),
              ]),
          ]),
        ]),

      // 4. What is Included & Deliverables
      if (course.features.isNotEmpty)
        div(classes: 'detail-section', [
          h2([Component.text('📦 What is Included in this Course')]),
          ul(classes: 'features-checklist', [
            for (var feat in course.features)
              li([
                span(classes: 'feature-star', [Component.text('★')]),
                span([Component.text(feat)]),
              ]),
          ]),
        ]),

      // 5. Enroll / Get in Touch Action Banner
      div(classes: 'course-enroll-banner', [
        div(classes: 'banner-text', [
          h3([Component.text('Ready to master this curriculum?')]),
          p([
            Component.text(
              'Get instant access to full course videos, repositories, and direct consulting support.',
            ),
          ]),
        ]),
        div(classes: 'banner-action', [
          if (course.ctaUrl != null && course.ctaUrl!.isNotEmpty)
            a(
              href: course.ctaUrl!,
              target: Target.blank,
              classes: 'btn btn-primary btn-lg',
              [Component.text(course.ctaText)],
            )
          else
            Link(
              to: '/contact',
              classes: 'btn btn-primary btn-lg',
              child: Component.text('Enroll / Inquire Now →'),
            ),
        ]),
      ]),
    ]);
  }

  Component _buildChapterAccordion(CourseChapter chapter, int index) {
    final isExpanded = _expandedChapters.contains(chapter.id);

    return div(classes: 'chapter-card ${isExpanded ? "expanded" : ""}', [
      div(
        classes: 'chapter-header-row',
        events: {'click': (e) => _toggleChapter(chapter.id)},
        [
          div(classes: 'chapter-title-group', [
            span(classes: 'chapter-num-badge', [Component.text('Chapter $index')]),
            h3(classes: 'chapter-title', [Component.text(chapter.title)]),
          ]),
          div(classes: 'chapter-meta-right', [
            span(classes: 'lessons-count-badge', [Component.text('${chapter.lessons.length} Lectures')]),
            span(classes: 'toggle-chevron', [Component.text(isExpanded ? '▲' : '▼')]),
          ]),
        ],
      ),
      if (isExpanded)
        div(classes: 'chapter-body', [
          if (chapter.description != null && chapter.description!.isNotEmpty)
            p(classes: 'chapter-desc', [Component.text(chapter.description!)]),
          if (chapter.lessons.isEmpty)
            p(classes: 'no-lessons-text', [Component.text('No lectures listed in this chapter yet.')])
          else
            div(classes: 'lessons-list', [
              for (var lesson in chapter.lessons) _buildLessonItem(lesson),
            ]),
        ]),
    ]);
  }

  Component _buildLessonItem(CourseLesson lesson) {
    final isSelected = _activeLessonId == lesson.id || (_activeVideoUrl.isNotEmpty && _activeVideoUrl == lesson.videoUrl);

    return div(classes: 'lesson-row ${isSelected ? "active-playing" : ""}', [
      div(classes: 'lesson-left-info', [
        span(classes: 'lesson-play-icon', [Component.text(isSelected ? '🔊' : '🎬')]),
        div(classes: 'lesson-title-box', [
          strong(classes: 'lesson-title', [Component.text(lesson.title)]),
          if (lesson.notes != null && lesson.notes!.isNotEmpty)
            p(classes: 'lesson-notes', [Component.text(lesson.notes!)]),
        ]),
      ]),
      div(classes: 'lesson-right-actions', [
        if (lesson.duration.isNotEmpty)
          span(classes: 'lesson-duration-pill', [Component.text('⏱️ ${lesson.duration}')]),
        if (lesson.isFreePreview)
          span(classes: 'badge-free-preview', [Component.text('FREE PREVIEW')]),
        if (lesson.videoUrl.isNotEmpty) ...[
          button(
            classes: 'btn-play-lesson ${isSelected ? "is-active" : ""}',
            events: {
              'click': (e) => _selectVideo(
                    url: lesson.videoUrl,
                    title: lesson.title,
                    lessonId: lesson.id,
                  ),
            },
            [Component.text(isSelected ? '▶ Playing' : '▶ Play')],
          ),
          a(
            href: lesson.videoUrl,
            target: Target.blank,
            classes: 'btn-external-icon',
            attributes: {'title': 'Open in new tab on YouTube / Google Drive'},
            [Component.text('↗')],
          ),
        ],
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.course-detail-container', [
      css('&').styles(
        width: 100.percent,
        maxWidth: 1200.px,
        margin: Margin.symmetric(horizontal: Unit.auto),
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
      ),
      css('.back-nav', [
        css('&').styles(margin: Margin.only(bottom: 2.rem)),
        css('a').styles(
          color: textMutedColor,
          fontWeight: FontWeight.w600,
          fontSize: 0.95.rem,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          transition: Transition('color', duration: Duration(milliseconds: 200)),
        ),
        css('a:hover').styles(color: primaryColor),
      ]),
      css('.course-hero', [
        css('&').styles(
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          margin: Margin.only(bottom: 2.5.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 32.px, color: Color.rgba(0, 0, 0, 0.4)),
          raw: cardBackdropFilter,
        ),
        css('.hero-badges-row').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(10.px),
          flexWrap: FlexWrap.wrap,
          margin: Margin.only(bottom: 1.2.rem),
        ),
        css('h1').styles(
          fontSize: 2.4.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          lineHeight: 1.25.em,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.course-subtitle').styles(
          fontSize: 1.2.rem,
          fontWeight: FontWeight.w600,
          color: primaryColor,
          lineHeight: 1.5.em,
          margin: Margin.only(bottom: 1.2.rem),
        ),
        css('.course-desc-full').styles(
          fontSize: 1.05.rem,
          color: textMutedColor,
          lineHeight: 1.7.em,
          margin: Margin.only(bottom: 2.rem),
          maxWidth: 900.px,
        ),
        css('.hero-stats-row', [
          css('&').styles(
            display: Display.grid,
            raw: {
              'grid-template-columns': 'repeat(auto-fit, minmax(220px, 1fr))',
              'gap': '1.2rem',
              'border-top': '1px solid rgba(255, 255, 255, 0.08)',
            },
            padding: Padding.only(top: 1.5.rem),
          ),
          css('.stat-item').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(12.px),
          ),
          css('.stat-icon').styles(fontSize: 1.8.rem),
          css('.stat-label').styles(
            display: Display.block,
            fontSize: 0.8.rem,
            color: textMutedColor,
            raw: {'text-transform': 'uppercase', 'letter-spacing': '0.5px'},
          ),
          css('strong').styles(
            fontSize: 0.98.rem,
            color: textColor,
          ),
        ]),
      ]),
      css('.detail-section', [
        css('&').styles(
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(22.px)),
          padding: Padding.all(2.2.rem),
          margin: Margin.only(bottom: 2.5.rem),
          boxSizing: BoxSizing.borderBox,
          raw: cardBackdropFilter,
        ),
        css('h2').styles(
          fontSize: 1.6.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.4.rem),
        ),
      ]),
      css('.theater-section', [
        css('.player-header-bar').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(10.px),
          margin: Margin.only(bottom: 1.2.rem),
          padding: Padding.symmetric(vertical: 0.6.rem, horizontal: 1.rem),
          backgroundColor: Color.rgba(15, 23, 42, 0.8),
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(14.px)),
        ),
        css('.now-playing-info').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(8.px),
          color: textColor,
          fontSize: 0.95.rem,
        ),
        css('.live-dot').styles(
          width: 10.px,
          height: 10.px,
          radius: BorderRadius.all(Radius.circular(5.px)),
          backgroundColor: emeraldAccent,
          raw: {'box-shadow': '0 0 10px #6ef27b'},
        ),
        css('.now-playing-title').styles(
          color: primaryColor,
          fontWeight: FontWeight.w700,
        ),
        css('.btn-open-external').styles(
          padding: Padding.symmetric(vertical: 5.px, horizontal: 12.px),
          radius: BorderRadius.all(Radius.circular(8.px)),
          backgroundColor: Color.rgba(255, 255, 255, 0.08),
          border: Border.all(color: surfaceBorder, width: 1.px),
          color: textColor,
          fontSize: 0.82.rem,
          fontWeight: FontWeight.w600,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
        ),
        css('.btn-open-external:hover').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.15),
          color: primaryColor,
          border: Border.all(color: primaryColor, width: 1.px),
        ),
        css('.switch-intro-wrap').styles(
          margin: Margin.only(top: 1.rem),
          display: Display.flex,
          justifyContent: JustifyContent.center,
        ),
        css('.btn-switch-intro').styles(
          backgroundColor: Color.rgba(255, 255, 255, 0.06),
          border: Border.all(color: surfaceBorder, width: 1.px),
          color: textColor,
          padding: Padding.symmetric(vertical: 8.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(10.px)),
          fontSize: 0.88.rem,
          fontWeight: FontWeight.w700,
          cursor: Cursor.pointer,
        ),
        css('.btn-switch-intro:hover').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.15),
          color: primaryColor,
          border: Border.all(color: primaryColor, width: 1.px),
        ),
      ]),
      css('.section-heading-split').styles(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(1.rem),
        margin: Margin.only(bottom: 1.5.rem),
      ),
      css('.section-sub-text').styles(
        color: textMutedColor,
        fontSize: 0.95.rem,
        margin: Margin.zero,
        lineHeight: 1.5.em,
      ),
      css('.curriculum-count-pill').styles(
        backgroundColor: Color.rgba(251, 197, 26, 0.12),
        color: primaryColor,
        border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
        padding: Padding.symmetric(vertical: 6.px, horizontal: 14.px),
        radius: BorderRadius.all(Radius.circular(20.px)),
        fontSize: 0.85.rem,
        fontWeight: FontWeight.w700,
      ),
      css('.chapters-accordion-list', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(1.2.rem),
        ),
        css('.chapter-card', [
          css('&').styles(
            backgroundColor: Color.rgba(15, 23, 42, 0.65),
            border: Border.all(color: surfaceBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(16.px)),
            overflow: Overflow.hidden,
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('&.expanded').styles(
            border: Border.all(color: Color.rgba(251, 197, 26, 0.35), width: 1.px),
          ),
          css('.chapter-header-row').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            padding: Padding.symmetric(vertical: 1.2.rem, horizontal: 1.5.rem),
            cursor: Cursor.pointer,
            backgroundColor: Color.rgba(255, 255, 255, 0.02),
            raw: {'user-select': 'none'},
          ),
          css('.chapter-header-row:hover').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.05),
          ),
          css('.chapter-title-group').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(12.px),
            flexWrap: FlexWrap.wrap,
          ),
          css('.chapter-num-badge').styles(
            backgroundColor: Color.rgba(251, 197, 26, 0.15),
            color: primaryColor,
            padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
            radius: BorderRadius.all(Radius.circular(8.px)),
            fontSize: 0.78.rem,
            fontWeight: FontWeight.w800,
          ),
          css('.chapter-title').styles(
            fontSize: 1.15.rem,
            fontWeight: FontWeight.w700,
            color: textColor,
            margin: Margin.zero,
          ),
          css('.chapter-meta-right').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(12.px),
          ),
          css('.lessons-count-badge').styles(
            fontSize: 0.82.rem,
            color: textMutedColor,
            fontWeight: FontWeight.w600,
          ),
          css('.toggle-chevron').styles(
            fontSize: 0.8.rem,
            color: primaryColor,
          ),
          css('.chapter-body').styles(
            padding: Padding.all(1.2.rem),
            backgroundColor: Color.rgba(11, 17, 32, 0.5),
            raw: {'border-top': '1px solid rgba(255, 255, 255, 0.05)'},
          ),
          css('.chapter-desc').styles(
            fontSize: 0.9.rem,
            color: textMutedColor,
            margin: Margin.only(bottom: 1.rem),
            lineHeight: 1.5.em,
          ),
        ]),
      ]),
      css('.lessons-list', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(8.px),
        ),
        css('.lesson-row', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            padding: Padding.symmetric(vertical: 10.px, horizontal: 14.px),
            backgroundColor: Color.rgba(15, 23, 42, 0.7),
            border: Border.all(color: surfaceBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            transition: Transition('all', duration: Duration(milliseconds: 150)),
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(10.px),
          ),
          css('&.active-playing').styles(
            border: Border.all(color: emeraldAccent, width: 1.px),
            backgroundColor: Color.rgba(110, 242, 123, 0.08),
          ),
          css('.lesson-left-info').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(10.px),
            flex: Flex(grow: 1),
          ),
          css('.lesson-play-icon').styles(fontSize: 1.2.rem),
          css('.lesson-title').styles(
            fontSize: 0.95.rem,
            color: textColor,
          ),
          css('.lesson-notes').styles(
            fontSize: 0.82.rem,
            color: textMutedColor,
            margin: Margin.only(top: 2.px),
          ),
          css('.lesson-right-actions').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(8.px),
          ),
          css('.lesson-duration-pill').styles(
            fontSize: 0.78.rem,
            color: textMutedColor,
            backgroundColor: Color.rgba(255, 255, 255, 0.05),
            padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
            radius: BorderRadius.all(Radius.circular(6.px)),
          ),
          css('.badge-free-preview').styles(
            fontSize: 0.72.rem,
            fontWeight: FontWeight.w800,
            color: emeraldAccent,
            backgroundColor: Color.rgba(110, 242, 123, 0.15),
            padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
            radius: BorderRadius.all(Radius.circular(6.px)),
          ),
          css('.btn-play-lesson', [
            css('&').styles(
              backgroundColor: primaryColor,
              color: backgroundColor,
              border: Border.unset,
              padding: Padding.symmetric(vertical: 6.px, horizontal: 14.px),
              radius: BorderRadius.all(Radius.circular(8.px)),
              fontWeight: FontWeight.w700,
              fontSize: 0.82.rem,
              cursor: Cursor.pointer,
            ),
            css('&.is-active').styles(
              backgroundColor: emeraldAccent,
              color: backgroundColor,
            ),
          ]),
          css('.btn-external-icon').styles(
            padding: Padding.symmetric(vertical: 5.px, horizontal: 8.px),
            radius: BorderRadius.all(Radius.circular(6.px)),
            backgroundColor: Color.rgba(255, 255, 255, 0.06),
            border: Border.all(color: surfaceBorder, width: 1.px),
            color: textMutedColor,
            fontSize: 0.82.rem,
            textDecoration: TextDecoration(line: TextDecorationLine.none),
          ),
          css('.btn-external-icon:hover').styles(color: primaryColor),
        ]),
      ]),
      css('.topics-2col-grid', [
        css('&').styles(
          display: Display.grid,
          raw: {
            'grid-template-columns': 'repeat(auto-fit, minmax(280px, 1fr))',
            'gap': '1rem',
          },
        ),
        css('.topic-item-box').styles(
          display: Display.flex,
          alignItems: AlignItems.start,
          gap: Gap.all(10.px),
          padding: Padding.all(1.rem),
          backgroundColor: Color.rgba(15, 23, 42, 0.6),
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
        ),
        css('.check-mark-circle').styles(
          color: emeraldAccent,
          fontWeight: FontWeight.w800,
          fontSize: 1.rem,
          lineHeight: 1.2.em,
        ),
        css('.topic-item-text').styles(
          fontSize: 0.92.rem,
          color: textColor,
          lineHeight: 1.45.em,
        ),
      ]),
      css('.features-checklist', [
        css('&').styles(
          listStyle: ListStyle.none,
          padding: Padding.zero,
          margin: Margin.zero,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(10.px),
        ),
        css('li').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
          gap: Gap.all(10.px),
          fontSize: 0.98.rem,
          color: textColor,
        ),
        css('.feature-star').styles(
          color: primaryColor,
          fontSize: 1.1.rem,
        ),
      ]),
      css('.course-enroll-banner', [
        css('&').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.08),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.35), width: 1.px),
          radius: BorderRadius.all(Radius.circular(22.px)),
          padding: Padding.all(2.5.rem),
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(1.5.rem),
          margin: Margin.only(top: 2.rem),
        ),
        css('h3').styles(
          fontSize: 1.6.rem,
          color: primaryColor,
          fontWeight: FontWeight.w800,
          margin: Margin.only(bottom: 0.4.rem),
        ),
        css('p').styles(
          fontSize: 1.rem,
          color: textMutedColor,
          margin: Margin.zero,
        ),
        css('.btn-lg').styles(
          padding: Padding.symmetric(vertical: 14.px, horizontal: 28.px),
          fontSize: 1.05.rem,
          fontWeight: FontWeight.w800,
          radius: BorderRadius.all(Radius.circular(14.px)),
        ),
      ]),
      css('.not-found-box', [
        css('&').styles(
          textAlign: TextAlign.center,
          padding: Padding.all(4.rem),
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
        ),
        css('.not-found-icon').styles(fontSize: 3.rem, margin: Margin.only(bottom: 1.rem)),
        css('h1').styles(fontSize: 2.rem, color: textColor, margin: Margin.only(bottom: 0.8.rem)),
        css('p').styles(color: textMutedColor, margin: Margin.only(bottom: 1.5.rem)),
      ]),
      css('.category-badge').styles(
        padding: Padding.symmetric(vertical: 4.px, horizontal: 12.px),
        radius: BorderRadius.all(Radius.circular(12.px)),
        fontSize: 0.82.rem,
        fontWeight: FontWeight.w700,
      ),
      css('.badge-software').styles(
        backgroundColor: Color.rgba(251, 197, 26, 0.15),
        color: primaryColor,
        border: Border.all(color: Color.rgba(251, 197, 26, 0.4), width: 1.px),
      ),
      css('.badge-engineering').styles(
        backgroundColor: Color.rgba(251, 197, 26, 0.15),
        color: primaryColor,
        border: Border.all(color: Color.rgba(251, 197, 26, 0.4), width: 1.px),
      ),
      css('.level-badge').styles(
        padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.8.rem,
        fontWeight: FontWeight.w600,
        backgroundColor: Color.rgba(255, 255, 255, 0.06),
        border: Border.all(color: surfaceBorder, width: 1.px),
        color: textColor,
      ),
      css('.badge-pill-accent').styles(
        padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.8.rem,
        fontWeight: FontWeight.w700,
        backgroundColor: Color.rgba(110, 242, 123, 0.15),
        border: Border.all(color: Color.rgba(110, 242, 123, 0.35), width: 1.px),
        color: emeraldAccent,
      ),
      css('.badge-free-pill').styles(
        padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.8.rem,
        fontWeight: FontWeight.w800,
        backgroundColor: Color.rgba(110, 242, 123, 0.25),
        border: Border.all(color: emeraldAccent, width: 1.px),
        color: emeraldAccent,
      ),
    ]),
  ];
}
