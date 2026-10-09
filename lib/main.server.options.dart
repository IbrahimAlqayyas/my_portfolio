// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:my_portfolio/components/cosmic_canvas.dart' as _cosmic_canvas;
import 'package:my_portfolio/components/course_card.dart' as _course_card;
import 'package:my_portfolio/components/footer.dart' as _footer;
import 'package:my_portfolio/components/header.dart' as _header;
import 'package:my_portfolio/components/project_card.dart' as _project_card;
import 'package:my_portfolio/pages/about.dart' as _about;
import 'package:my_portfolio/pages/contact.dart' as _contact;
import 'package:my_portfolio/pages/courses.dart' as _courses;
import 'package:my_portfolio/pages/engineering_hub.dart' as _engineering_hub;
import 'package:my_portfolio/pages/home.dart' as _home;
import 'package:my_portfolio/pages/portfolio.dart' as _portfolio;
import 'package:my_portfolio/pages/project_detail.dart' as _project_detail;
import 'package:my_portfolio/pages/software_hub.dart' as _software_hub;
import 'package:my_portfolio/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_app.App: ClientTarget<_app.App>('app')},
  styles: () => [
    ..._cosmic_canvas.CosmicCanvas.styles,
    ..._course_card.CourseCard.styles,
    ..._footer.Footer.styles,
    ..._header.Header.styles,
    ..._project_card.ProjectCard.styles,
    ..._about.About.styles,
    ..._contact.Contact.styles,
    ..._courses.CoursesPage.styles,
    ..._engineering_hub.EngineeringHub.styles,
    ..._home.Home.styles,
    ..._portfolio.PortfolioPage.styles,
    ..._project_detail.ProjectDetailPage.styles,
    ..._software_hub.SoftwareHub.styles,
    ..._app.AppState.styles,
  ],
);
