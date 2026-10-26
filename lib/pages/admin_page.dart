import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import '../services/content_repository.dart';
import '../utils/scroll_helper.dart';
import 'admin/admin_courses_tab.dart';
import 'admin/admin_engineering_tab.dart';
import 'admin/admin_projects_tab.dart';
import 'admin/admin_software_tab.dart';
import 'admin/admin_sync_tab.dart';

class AdminPage extends StatefulComponent {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();

  @css
  static List<StyleRule> get styles => _AdminPageState.styles;
}

class _AdminPageState extends State<AdminPage> {
  String _activeTab = 'software'; // 'software', 'engineering', 'projects', 'courses', 'sync'
  bool _showSavedToast = false;

  @override
  void initState() {
    super.initState();
    scrollToTop();
    contentRepository.init();
    contentRepository.addListener(_onRepoChanged);
  }

  @override
  void dispose() {
    contentRepository.removeListener(_onRepoChanged);
    super.dispose();
  }

  void _onRepoChanged() {
    setState(() {});
  }

  void _triggerSave() {
    contentRepository.save();
    setState(() {
      _showSavedToast = true;
    });
  }

  @override
  Component build(BuildContext context) {
    return section(classes: 'admin-container', [
      // Top Header & Sticky Control Bar
      div(classes: 'admin-header-bar', [
        div(classes: 'admin-header-left', [
          div(classes: 'admin-brand-tag', [
            span(classes: 'status-dot', []),
            Component.text('CMS STUDIO • LIVE'),
          ]),
          h1([Component.text('Portfolio Content Dashboard')]),
          p(classes: 'admin-desc', [
            Component.text('Systematic UI control for titles, descriptions, services, featured order, and resources.'),
          ]),
        ]),
        div(classes: 'admin-header-right', [
          Link(to: '/', classes: 'btn btn-secondary', child: Component.text('👁️ View Website')),
          button(
            classes: 'btn btn-primary btn-save-master',
            events: {'click': (e) => _triggerSave()},
            [Component.text('💾 Save All Changes')],
          ),
        ]),
      ]),

      if (_showSavedToast)
        div(classes: 'admin-toast-banner', [
          span([Component.text('✅ All changes successfully saved to local persistent storage!')]),
          button(
            classes: 'toast-close',
            events: {'click': (e) => setState(() => _showSavedToast = false)},
            [Component.text('✕')],
          ),
        ]),

      // Main Navigation Tabs
      div(classes: 'admin-tabs-nav', [
        button(
          classes: 'admin-tab-btn ${_activeTab == "software" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeTab = 'software')},
          [Component.text('💻 Software Hub')],
        ),
        button(
          classes: 'admin-tab-btn ${_activeTab == "engineering" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeTab = 'engineering')},
          [Component.text('⚡ Engineering Hub')],
        ),
        button(
          classes: 'admin-tab-btn ${_activeTab == "projects" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeTab = 'projects')},
          [Component.text('🚀 Projects (CRUD & Featured)')],
        ),
        button(
          classes: 'admin-tab-btn ${_activeTab == "courses" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeTab = 'courses')},
          [Component.text('🎓 Courses & Categories')],
        ),
        button(
          classes: 'admin-tab-btn ${_activeTab == "sync" ? "active" : ""}',
          events: {'click': (e) => setState(() => _activeTab = 'sync')},
          [Component.text('☁️ Sync & GitHub Commit')],
        ),
      ]),

      // Tab Content Views
      if (_activeTab == 'software')
        AdminSoftwareTab(
          initialContent: contentRepository.softwareHub,
          onChange: (newContent) {
            contentRepository.updateSoftwareHub(newContent);
          },
        )
      else if (_activeTab == 'engineering')
        AdminEngineeringTab(
          initialContent: contentRepository.engineeringHub,
          onChange: (newContent) {
            contentRepository.updateEngineeringHub(newContent);
          },
        )
      else if (_activeTab == 'projects')
        const AdminProjectsTab()
      else if (_activeTab == 'courses')
        const AdminCoursesTab()
      else if (_activeTab == 'sync')
        const AdminSyncTab(),
    ]);
  }

  static List<StyleRule> get styles => [
    css('.admin-container', [
      css('&').styles(
        maxWidth: 1200.px,
        width: 100.percent,
        padding: Padding.symmetric(vertical: 2.5.rem, horizontal: 1.5.rem),
        boxSizing: BoxSizing.borderBox,
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.stretch,
      ),
      css('.admin-header-bar', [
        css('&').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(1.5.rem),
          padding: Padding.all(2.rem),
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          margin: Margin.only(bottom: 2.rem),
          shadow: BoxShadow(offsetX: 0.px, offsetY: 8.px, blur: 28.px, color: Color.rgba(0, 0, 0, 0.4)),
          raw: cardBackdropFilter,
        ),
        css('.admin-brand-tag', [
          css('&').styles(
            display: Display.inlineFlex,
            alignItems: AlignItems.center,
            gap: Gap.all(6.px),
            backgroundColor: Color.rgba(110, 242, 123, 0.12),
            color: emeraldAccent,
            border: Border.all(color: Color.rgba(110, 242, 123, 0.3), width: 1.px),
            padding: Padding.symmetric(vertical: 4.px, horizontal: 12.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.78.rem,
            fontWeight: FontWeight.w700,
            margin: Margin.only(bottom: 0.8.rem),
          ),
          css('.status-dot').styles(
            width: 8.px,
            height: 8.px,
            radius: BorderRadius.all(Radius.circular(4.px)),
            backgroundColor: emeraldAccent,
            raw: {'box-shadow': '0 0 8px #6ef27b'},
          ),
        ]),
        css('h1').styles(
          fontSize: 2.4.rem,
          fontWeight: FontWeight.w800,
          color: textColor,
          margin: Margin.only(bottom: 0.4.rem),
        ),
        css('.admin-desc').styles(
          fontSize: 1.05.rem,
          color: textMutedColor,
          margin: Margin.zero,
          maxWidth: 650.px,
        ),
        css('.admin-header-right', [
          css('&').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(12.px),
            flexWrap: FlexWrap.wrap,
          ),
          css('.btn-save-master').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            padding: Padding.symmetric(vertical: 14.px, horizontal: 24.px),
            fontWeight: FontWeight.w800,
            fontSize: 1.05.rem,
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.4)),
          ),
        ]),
      ]),

      css('.admin-toast-banner', [
        css('&').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          backgroundColor: Color.rgba(110, 242, 123, 0.18),
          border: Border.all(color: emeraldAccent, width: 1.px),
          color: emeraldAccent,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 18.px),
          radius: BorderRadius.all(Radius.circular(14.px)),
          margin: Margin.only(bottom: 1.5.rem),
          fontWeight: FontWeight.w600,
        ),
        css('.toast-close').styles(
          backgroundColor: Colors.transparent,
          border: Border.unset,
          color: emeraldAccent,
          fontSize: 1.2.rem,
          cursor: Cursor.pointer,
        ),
      ]),

      css('.admin-tabs-nav', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(10.px),
          margin: Margin.only(bottom: 2.rem),
          raw: {'border-bottom': '1px solid rgba(255, 255, 255, 0.08)'},
          padding: Padding.only(bottom: 1.rem),
        ),
        css('.admin-tab-btn', [
          css('&').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.04),
            border: Border.all(color: surfaceBorder, width: 1.px),
            color: textMutedColor,
            padding: Padding.symmetric(vertical: 12.px, horizontal: 20.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            fontSize: 0.98.rem,
            fontWeight: FontWeight.w700,
            cursor: Cursor.pointer,
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('&:hover').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.08),
            color: textColor,
          ),
          css('&.active').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            border: Border.all(color: primaryColor, width: 1.px),
            shadow: BoxShadow(offsetX: 0.px, offsetY: 4.px, blur: 14.px, color: Color.rgba(251, 197, 26, 0.35)),
          ),
        ]),
      ]),

      css('.admin-tab-pane', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(2.rem),
          width: 100.percent,
        ),
      ]),

      css('.admin-section-header', [
        css('&').styles(margin: Margin.only(bottom: 0.5.rem)),
        css('h3').styles(
          fontSize: 1.45.rem,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          margin: Margin.only(bottom: 0.3.rem),
        ),
        css('p').styles(
          fontSize: 0.95.rem,
          color: textMutedColor,
          margin: Margin.zero,
        ),
      ]),

      css('.admin-section-header-split', [
        css('&').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(1.rem),
          margin: Margin.only(bottom: 1.rem),
        ),
        css('h3').styles(
          fontSize: 1.45.rem,
          fontWeight: FontWeight.w800,
          color: primaryColor,
          margin: Margin.only(bottom: 0.3.rem),
        ),
        css('p').styles(
          fontSize: 0.95.rem,
          color: textMutedColor,
          margin: Margin.zero,
        ),
      ]),

      css('.admin-card', [
        css('&').styles(
          backgroundColor: cardBackground,
          border: Border.all(color: cardBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(20.px)),
          padding: Padding.all(2.rem),
          boxSizing: BoxSizing.borderBox,
          shadow: BoxShadow(offsetX: 0.px, offsetY: 6.px, blur: 20.px, color: Color.rgba(0, 0, 0, 0.3)),
          raw: cardBackdropFilter,
        ),
      ]),

      // Form Styles
      css('.form-group', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(6.px),
          margin: Margin.only(bottom: 1.2.rem),
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
        ),
        css('label').styles(
          fontSize: 0.88.rem,
          fontWeight: FontWeight.w600,
          color: textMutedColor,
        ),
      ]),
      css('.form-grid-2', [
        css('&').styles(
          display: Display.grid,
          raw: {
            'grid-template-columns': 'repeat(auto-fit, minmax(280px, 1fr))',
            'gap': '1.2rem',
          },
          width: 100.percent,
        ),
      ]),
      css('.form-grid-3', [
        css('&').styles(
          display: Display.grid,
          raw: {
            'grid-template-columns': 'repeat(auto-fit, minmax(220px, 1fr))',
            'gap': '1.2rem',
          },
          width: 100.percent,
        ),
      ]),
      css('.admin-input', [
        css('&').styles(
          backgroundColor: Color.rgba(15, 23, 42, 0.7),
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          color: textColor,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 16.px),
          fontSize: 0.95.rem,
          outline: Outline.unset,
          width: 100.percent,
          boxSizing: BoxSizing.borderBox,
          transition: Transition('border-color', duration: Duration(milliseconds: 200)),
        ),
        css('&:focus').styles(
          border: Border.all(color: primaryColor, width: 1.px),
        ),
      ]),
      css('.admin-textarea', [
        css('&').styles(
          backgroundColor: Color.rgba(15, 23, 42, 0.7),
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(12.px)),
          color: textColor,
          padding: Padding.symmetric(vertical: 12.px, horizontal: 16.px),
          fontSize: 0.95.rem,
          outline: Outline.unset,
          minHeight: 90.px,
          boxSizing: BoxSizing.borderBox,
          width: 100.percent,
          raw: {'resize': 'vertical'},
        ),
        css('&:focus').styles(
          border: Border.all(color: primaryColor, width: 1.px),
        ),
        css('&.admin-textarea-lg').styles(minHeight: 160.px),
      ]),

      // Metrics editor
      css('.metrics-editor-grid', [
        css('&').styles(
          display: Display.grid,
          raw: {
            'grid-template-columns': 'repeat(auto-fit, minmax(220px, 1fr))',
            'gap': '1.2rem',
          },
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('.metric-edit-card', [
          css('&').styles(
            backgroundColor: Color.rgba(15, 23, 42, 0.6),
            border: Border.all(color: surfaceBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(16.px)),
            padding: Padding.all(1.2.rem),
            boxSizing: BoxSizing.borderBox,
          ),
          css('.metric-card-header').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            margin: Margin.only(bottom: 0.8.rem),
          ),
        ]),
      ]),

      // Services editor
      css('.services-list', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(1.2.rem),
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('.service-editor-card', [
          css('&').styles(
            backgroundColor: Color.rgba(15, 23, 42, 0.6),
            border: Border.all(color: surfaceBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(16.px)),
            padding: Padding.all(1.4.rem),
            boxSizing: BoxSizing.borderBox,
          ),
          css('.service-editor-top').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            margin: Margin.only(bottom: 1.rem),
          ),
        ]),
      ]),

      css('.add-service-box', [
        css('&').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.05),
          border: Border.all(color: Color.rgba(251, 197, 26, 0.3), width: 1.px),
          radius: BorderRadius.all(Radius.circular(16.px)),
          padding: Padding.all(1.5.rem),
          margin: Margin.only(top: 1.2.rem),
        ),
        css('h4').styles(
          color: primaryColor,
          margin: Margin.only(bottom: 1.rem),
          fontSize: 1.15.rem,
        ),
      ]),

      // Order Items / Featured list rows
      css('.items-order-list', [
        css('&').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.all(10.px),
          margin: Margin.only(top: 1.rem),
        ),
        css('.order-item-row', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            backgroundColor: Color.rgba(15, 23, 42, 0.5),
            border: Border.all(color: surfaceBorder, width: 1.px),
            radius: BorderRadius.all(Radius.circular(14.px)),
            padding: Padding.symmetric(vertical: 12.px, horizontal: 16.px),
            transition: Transition('all', duration: Duration(milliseconds: 200)),
          ),
          css('&.is-featured-row').styles(
            border: Border.all(color: primaryColor, width: 1.px),
            backgroundColor: Color.rgba(251, 197, 26, 0.06),
          ),
          css('.order-item-info', [
            css('&').styles(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.all(14.px),
            ),
            css('.item-thumb').styles(
              width: 50.px,
              height: 50.px,
              radius: BorderRadius.all(Radius.circular(10.px)),
              raw: {'object-fit': 'cover'},
            ),
            css('.item-icon-circle').styles(
              width: 44.px,
              height: 44.px,
              display: Display.flex,
              alignItems: AlignItems.center,
              justifyContent: JustifyContent.center,
              fontSize: 1.6.rem,
              backgroundColor: Color.rgba(255, 255, 255, 0.06),
              radius: BorderRadius.all(Radius.circular(10.px)),
            ),
            css('.item-title-wrap').styles(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.all(8.px),
              margin: Margin.only(bottom: 4.px),
            ),
            css('.item-sub').styles(
              fontSize: 0.85.rem,
              color: textMutedColor,
            ),
          ]),
        ]),
      ]),

      // Badge / Chip Manager
      css('.badge-manager-container', [
        css('.badges-chips-wrap', [
          css('&').styles(
            display: Display.flex,
            flexWrap: FlexWrap.wrap,
            gap: Gap.all(8.px),
            margin: Margin.only(bottom: 1.5.rem),
          ),
          css('.admin-chip', [
            css('&').styles(
              display: Display.inlineFlex,
              alignItems: AlignItems.center,
              gap: Gap.all(8.px),
              backgroundColor: Color.rgba(15, 23, 42, 0.7),
              border: Border.all(color: surfaceBorder, width: 1.px),
              padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
              radius: BorderRadius.all(Radius.circular(10.px)),
              fontSize: 0.9.rem,
              color: textColor,
            ),
            css('.chip-remove-btn').styles(
              backgroundColor: Colors.transparent,
              border: Border.unset,
              color: secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 1.rem,
              cursor: Cursor.pointer,
              padding: Padding.zero,
            ),
          ]),
        ]),
        css('.add-badge-row', [
          css('&').styles(
            display: Display.flex,
            gap: Gap.all(10.px),
            maxWidth: 600.px,
          ),
        ]),
      ]),

      // Projects & Courses Grids in Admin
      css('.admin-projects-grid, .admin-courses-grid', [
        css('&').styles(
          display: Display.grid,
          raw: {
            'grid-template-columns': 'repeat(auto-fill, minmax(320px, 1fr))',
            'gap': '1.5rem',
          },
        ),
      ]),
      css('.admin-item-card, .admin-course-card', [
        css('&').styles(
          backgroundColor: Color.rgba(15, 23, 42, 0.65),
          border: Border.all(color: surfaceBorder, width: 1.px),
          radius: BorderRadius.all(Radius.circular(18.px)),
          overflow: Overflow.hidden,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          transition: Transition('all', duration: Duration(milliseconds: 200)),
        ),
        css('&.featured-border').styles(
          border: Border.all(color: primaryColor, width: 1.px),
          raw: {'box-shadow': '0 0 16px rgba(251, 197, 26, 0.15)'},
        ),
        css('.item-card-image', [
          css('&').styles(
            position: Position.relative(),
            height: 160.px,
            overflow: Overflow.hidden,
          ),
          css('img').styles(
            width: 100.percent,
            height: 100.percent,
            raw: {'object-fit': 'cover'},
          ),
          css('.badge-pos-left').styles(
            position: Position.absolute(top: 10.px, left: 10.px),
          ),
          css('.badge-pos-right').styles(
            position: Position.absolute(top: 10.px, right: 10.px),
          ),
        ]),
        css('.item-card-body', [
          css('&').styles(
            padding: Padding.all(1.4.rem),
            display: Display.flex,
            flexDirection: FlexDirection.column,
            flex: Flex(grow: 1),
          ),
          css('h4').styles(
            fontSize: 1.2.rem,
            fontWeight: FontWeight.w700,
            color: textColor,
            margin: Margin.only(bottom: 0.4.rem),
          ),
        ]),
        css('.course-card-top-bar', [
          css('&').styles(
            display: Display.flex,
            justifyContent: JustifyContent.spaceBetween,
            alignItems: AlignItems.center,
            padding: Padding.all(1.2.rem),
            raw: {'border-bottom': '1px solid rgba(255, 255, 255, 0.05)'},
          ),
          css('.course-icon-lg').styles(fontSize: 2.rem),
          css('.badges-wrap').styles(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.all(6.px),
          ),
        ]),
      ]),

      // Subnav bar
      css('.admin-subnav-bar', [
        css('&').styles(
          display: Display.flex,
          gap: Gap.all(12.px),
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('.subnav-tab', [
          css('&').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.04),
            border: Border.all(color: surfaceBorder, width: 1.px),
            color: textMutedColor,
            padding: Padding.symmetric(vertical: 10.px, horizontal: 18.px),
            radius: BorderRadius.all(Radius.circular(12.px)),
            fontSize: 0.92.rem,
            fontWeight: FontWeight.w700,
            cursor: Cursor.pointer,
          ),
          css('&.active').styles(
            backgroundColor: Color.rgba(251, 197, 26, 0.15),
            color: primaryColor,
            border: Border.all(color: primaryColor, width: 1.px),
          ),
        ]),
      ]),

      // Common helper classes
      css('.featured-pill').styles(
        backgroundColor: Color.rgba(251, 197, 26, 0.2),
        color: primaryColor,
        border: Border.all(color: primaryColor, width: 1.px),
        padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.75.rem,
        fontWeight: FontWeight.w700,
      ),
      css('.free-pill').styles(
        backgroundColor: Color.rgba(110, 242, 123, 0.2),
        color: emeraldAccent,
        border: Border.all(color: emeraldAccent, width: 1.px),
        padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.75.rem,
        fontWeight: FontWeight.w700,
      ),
      css('.admin-badge-cat').styles(
        backgroundColor: Color.rgba(15, 23, 42, 0.85),
        color: textColor,
        border: Border.all(color: surfaceBorder, width: 1.px),
        padding: Padding.symmetric(vertical: 3.px, horizontal: 8.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.75.rem,
        fontWeight: FontWeight.w600,
      ),
      css('.badge-num').styles(
        fontSize: 0.82.rem,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        backgroundColor: Color.rgba(251, 197, 26, 0.1),
        padding: Padding.symmetric(vertical: 2.px, horizontal: 8.px),
        radius: BorderRadius.all(Radius.circular(6.px)),
      ),
      css('.item-desc-short').styles(
        fontSize: 0.9.rem,
        color: textMutedColor,
        lineHeight: 1.5.em,
        margin: Margin.only(bottom: 1.rem),
        flex: Flex(grow: 1),
      ),
      css('.item-actions-footer', [
        css('&').styles(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          margin: Margin.only(top: Unit.auto),
          padding: Padding.only(top: 1.rem),
          raw: {'border-top': '1px solid rgba(255, 255, 255, 0.06)'},
        ),
      ]),
      css('.btn-action-featured', [
        css('&').styles(
          backgroundColor: Color.rgba(255, 255, 255, 0.05),
          border: Border.all(color: surfaceBorder, width: 1.px),
          color: textMutedColor,
          padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
          radius: BorderRadius.all(Radius.circular(10.px)),
          fontSize: 0.82.rem,
          fontWeight: FontWeight.w700,
          cursor: Cursor.pointer,
        ),
        css('&.active').styles(
          backgroundColor: Color.rgba(251, 197, 26, 0.2),
          color: primaryColor,
          border: Border.all(color: primaryColor, width: 1.px),
        ),
      ]),
      css('.btn-outline-sm').styles(
        backgroundColor: Colors.transparent,
        border: Border.all(color: surfaceBorder, width: 1.px),
        color: textColor,
        padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
        radius: BorderRadius.all(Radius.circular(10.px)),
        fontSize: 0.82.rem,
        fontWeight: FontWeight.w600,
        cursor: Cursor.pointer,
      ),
      css('.btn-icon-danger').styles(
        backgroundColor: Color.rgba(255, 87, 123, 0.12),
        border: Border.all(color: Color.rgba(255, 87, 123, 0.3), width: 1.px),
        color: secondaryColor,
        padding: Padding.symmetric(vertical: 6.px, horizontal: 10.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
        fontSize: 0.82.rem,
        fontWeight: FontWeight.w700,
        cursor: Cursor.pointer,
      ),
      css('.btn-icon-danger-pill').styles(
        backgroundColor: Color.rgba(255, 87, 123, 0.12),
        border: Border.all(color: Color.rgba(255, 87, 123, 0.4), width: 1.px),
        color: secondaryColor,
        padding: Padding.symmetric(vertical: 10.px, horizontal: 18.px),
        radius: BorderRadius.all(Radius.circular(12.px)),
        fontSize: 0.9.rem,
        fontWeight: FontWeight.w700,
        cursor: Cursor.pointer,
      ),
      css('.inline-actions').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(12.px),
      ),
      css('.hint-text').styles(
        fontSize: 0.9.rem,
        color: textMutedColor,
        margin: Margin.only(bottom: 1.2.rem),
        lineHeight: 1.5.em,
      ),
      css('.commit-feedback-box', [
        css('&').styles(
          padding: Padding.all(1.2.rem),
          radius: BorderRadius.all(Radius.circular(12.px)),
          margin: Margin.only(top: 1.2.rem),
        ),
        css('&.feedback-ok').styles(
          backgroundColor: Color.rgba(110, 242, 123, 0.12),
          border: Border.all(color: emeraldAccent, width: 1.px),
          color: emeraldAccent,
        ),
        css('&.feedback-err').styles(
          backgroundColor: Color.rgba(255, 87, 123, 0.12),
          border: Border.all(color: secondaryColor, width: 1.px),
          color: secondaryColor,
        ),
        css('.commit-link').styles(
          color: emeraldAccent,
          fontWeight: FontWeight.w700,
          textDecoration: TextDecoration(line: TextDecorationLine.underline),
          margin: Margin.only(top: 6.px),
          display: Display.inlineBlock,
        ),
      ]),
      css('.filter-bar-row').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.spaceBetween,
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(1.rem),
      ),
      css('.category-pills', [
        css('&').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(6.px),
        ),
        css('.btn-pill', [
          css('&').styles(
            backgroundColor: Color.rgba(255, 255, 255, 0.05),
            border: Border.all(color: surfaceBorder, width: 1.px),
            color: textMutedColor,
            padding: Padding.symmetric(vertical: 6.px, horizontal: 12.px),
            radius: BorderRadius.all(Radius.circular(20.px)),
            fontSize: 0.82.rem,
            fontWeight: FontWeight.w600,
            cursor: Cursor.pointer,
          ),
          css('&.active').styles(
            backgroundColor: primaryColor,
            color: backgroundColor,
            border: Border.all(color: primaryColor, width: 1.px),
          ),
        ]),
      ]),
      css('.cat-row-card').styles(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        padding: Padding.all(1.2.rem),
        backgroundColor: Color.rgba(15, 23, 42, 0.5),
        border: Border.all(color: surfaceBorder, width: 1.px),
        radius: BorderRadius.all(Radius.circular(14.px)),
        margin: Margin.only(bottom: 10.px),
      ),
      css('.cat-info').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.all(14.px),
      ),
      css('.cat-icon-badge').styles(
        fontSize: 1.8.rem,
        padding: Padding.all(6.px),
        backgroundColor: Color.rgba(255, 255, 255, 0.05),
        radius: BorderRadius.all(Radius.circular(10.px)),
      ),
      css('.cat-id-code').styles(
        fontSize: 0.78.rem,
        color: textMutedColor,
        margin: Margin.symmetric(horizontal: 8.px),
      ),
      css('.cat-count-pill').styles(
        fontSize: 0.78.rem,
        fontWeight: FontWeight.w700,
        color: emeraldAccent,
        backgroundColor: Color.rgba(110, 242, 123, 0.12),
        padding: Padding.symmetric(vertical: 2.px, horizontal: 8.px),
        radius: BorderRadius.all(Radius.circular(8.px)),
      ),
      css('.auto-tab-preview').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.all(14.px),
      ),
      css('.tab-preview-icon').styles(fontSize: 2.rem),
      css('.badge-pill-fixed').styles(
        margin: Margin.only(left: Unit.auto),
        backgroundColor: Color.rgba(56, 189, 248, 0.15),
        color: blueAccent,
        border: Border.all(color: blueAccent, width: 1.px),
        padding: Padding.symmetric(vertical: 4.px, horizontal: 10.px),
        radius: BorderRadius.all(Radius.circular(10.px)),
        fontSize: 0.8.rem,
        fontWeight: FontWeight.w700,
      ),
      css('.form-group-checkbox').styles(
        margin: Margin.symmetric(vertical: 1.rem),
      ),
      css('.checkbox-label').styles(
        display: Display.inlineFlex,
        alignItems: AlignItems.center,
        gap: Gap.all(8.px),
        fontSize: 0.95.rem,
        color: textColor,
        fontWeight: FontWeight.w600,
        cursor: Cursor.pointer,
      ),
      css('.form-actions-bottom').styles(
        display: Display.flex,
        gap: Gap.all(12.px),
        margin: Margin.only(top: 1.5.rem),
      ),
      css('.sync-status-box').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap.all(1.rem),
      ),
      css('.status-indicator-row').styles(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.all(8.px),
        color: emeraldAccent,
      ),
      css('.status-dot-active').styles(
        width: 10.px,
        height: 10.px,
        radius: BorderRadius.all(Radius.circular(5.px)),
        backgroundColor: emeraldAccent,
        raw: {'box-shadow': '0 0 10px #6ef27b'},
      ),
      css('.feedback-success-text').styles(
        color: emeraldAccent,
        fontWeight: FontWeight.w700,
        fontSize: 0.95.rem,
        margin: Margin.zero,
      ),
    ]),
  ];
}
