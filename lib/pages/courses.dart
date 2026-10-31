import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/course_card.dart';
import '../constants/theme.dart';
import '../models/course.dart';
import '../services/content_repository.dart';
import '../utils/scroll_helper.dart';

class CoursesPage extends StatefulComponent {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();

  @css
  static List<StyleRule> get styles => _CoursesPageState.styles;
}

class _CoursesPageState extends State<CoursesPage> {
  String selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    scrollToTop();
    contentRepository.init();
    contentRepository.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    contentRepository.removeListener(_onContentChanged);
    super.dispose();
  }

  void _onContentChanged() {
    setState(() {});
  }

  List<Course> get filteredCourses {
    return contentRepository.getCoursesByCategory(selectedFilter);
  }

  @override
  Component build(BuildContext context) {
    final list = filteredCourses;
    final allCourses = contentRepository.courses;
    final categories = contentRepository.courseCategories;

    return section(classes: 'courses-container', [
      div(classes: 'page-header', [
        div(classes: 'header-badge', [
          Component.text('🎓 Academy & Knowledge Hub'),
        ]),
        h1([Component.text('Courses & Digital Resources')]),
        p(classes: 'header-subtitle', [
          Component.text(
            'High-impact engineering training, architecture masterclasses, and free quality documentation packs designed to accelerate your career and operations.',
          ),
        ]),
      ]),

      // Interactive Filter Tabs (Dynamic Categories + Automatic All Resources tab)
      div(classes: 'filter-tabs', [
        button(
          classes: 'filter-btn ${selectedFilter == "all" ? "active" : ""}',
          events: {
            'click': (e) {
              setState(() {
                selectedFilter = 'all';
              });
            },
          },
          [
            Component.text('🌐 All Resources (${allCourses.length})'),
          ],
        ),
        for (var cat in categories)
          button(
            classes: 'filter-btn ${selectedFilter == cat.id ? "active" : ""}',
            events: {
              'click': (e) {
                setState(() {
                  selectedFilter = cat.id;
                });
              },
            },
            [
              Component.text(
                '${cat.icon} ${cat.label} (${allCourses.where((c) => c.category.toLowerCase() == cat.id.toLowerCase()).length})',
              ),
            ],
          ),
      ]),

      // Courses Grid
      div(classes: 'courses-grid', [
        for (var course in list) CourseCard(course: course),
      ]),

      // Mentorship / Custom Training CTA
      div(classes: 'consultation-banner', [
        div(classes: 'banner-content', [
          h3([Component.text('Need Custom Training or Team Workshops?')]),
          p([
            Component.text(
              'I deliver customized corporate training in Flutter engineering practices as well as site QA/QC inspection standards for EPC contracting teams.',
            ),
          ]),
        ]),
        Link(
          to: '/contact',
          classes: 'btn btn-primary',
          child: Component.text('Request Custom Training →'),
        ),
      ]),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.courses-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 3.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
      ),
      css('.page-header', [
        css('&').styles(
          textAlign: TextAlign.center,
          maxWidth: 820.px,
          margin: Margin.only(bottom: 2.5.rem),
        ),
        css('.header-badge').styles(
          display: Display.inlineFlex,
          backgroundColor: Color.rgba(110, 242, 123, 0.12),
          color: emeraldAccent,
          padding: Padding.symmetric(vertical: 6.px, horizontal: 16.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          fontSize: 0.9.rem,
          fontWeight: FontWeight.w600,
          margin: Margin.only(bottom: 1.rem),
          border: Border.all(color: Color.rgba(110, 242, 123, 0.35), width: 1.px),
        ),
        css('h1').styles(
          fontSize: 3.2.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.8.rem),
        ),
        css('.header-subtitle').styles(
          fontSize: 1.15.rem,
          color: textMutedColor,
          lineHeight: 1.6.em,
        ),
      ]),
      css('.filter-tabs', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(12.px),
          margin: Margin.only(bottom: 3.rem),
        ),
        css('.filter-btn', [
          css('&').styles(
            padding: Padding.symmetric(vertical: 10.px, horizontal: 20.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            backgroundColor: cardBackground,
            border: Border.all(color: cardBorder, width: 1.px),
            color: textMutedColor,
            fontSize: 0.95.rem,
            fontWeight: FontWeight.w600,
            cursor: Cursor.pointer,
            transition: Transition('all', duration: Duration(milliseconds: 200)),
            raw: {
              ...cardBackdropFilter,
              'outline': 'none',
            },
          ),
          css('&:hover').styles(
            color: textColor,
            raw: {'border-color': '#6ef27b'},
          ),
          css('&.active').styles(
            backgroundColor: emeraldAccent,
            color: backgroundColor,
            fontWeight: FontWeight.w700,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(110, 242, 123, 0.35)),
            raw: {'border-color': '#6ef27b'},
          ),
        ]),
      ]),
      css('.courses-grid', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          width: 100.percent,
          margin: Margin.only(bottom: 4.rem),
        ),
      ]),
      css('.consultation-banner', [
        css('&').styles(
          width: 100.percent,
          maxWidth: 950.px,
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(24.px)),
          padding: Padding.all(2.5.rem),
          boxSizing: BoxSizing.borderBox,
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(1.5.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 30.px, color: Color.rgba(0, 0, 0, 0.3)),
          raw: cardBackdropFilter,
        ),
        css('.banner-content', [
          css('&').styles(maxWidth: 600.px),
          css('h3').styles(
            fontSize: 1.5.rem,
            fontWeight: FontWeight.w700,
            color: textColor,
            margin: Margin.only(bottom: 0.5.rem),
          ),
          css('p').styles(
            fontSize: 1.rem,
            color: textMutedColor,
            lineHeight: 1.55.em,
            margin: Margin.zero,
          ),
        ]),
        css('.btn').styles(
          padding: Padding.symmetric(vertical: 14.px, horizontal: 26.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          fontWeight: FontWeight.w700,
          fontSize: 1.rem,
          textDecoration: TextDecoration(line: TextDecorationLine.none),
          transition: Transition('all', duration: Duration(milliseconds: 200)),
          whiteSpace: WhiteSpace.noWrap,
        ),
        css('.btn-primary', [
          css('&').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 12.px, color: Color.rgba(251, 197, 26, 0.3)),
          ),
          css('&:hover').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            raw: {'filter': 'brightness(1.12)'},
            shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 16.px, color: Color.rgba(251, 197, 26, 0.45)),
          ),
        ]),
      ]),
    ]),
    ...CourseCard.styles,
  ];
}
