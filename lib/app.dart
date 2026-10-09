import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/cosmic_canvas.dart';
import 'components/footer.dart';
import 'components/header.dart';
import 'data/projects_data.dart';
import 'pages/about.dart';
import 'pages/contact.dart';
import 'pages/courses.dart';
import 'pages/engineering_hub.dart';
import 'pages/home.dart';
import 'pages/portfolio.dart';
import 'pages/project_detail.dart';
import 'pages/software_hub.dart';

@client
class App extends StatefulComponent {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Component build(BuildContext context) {
    return div(classes: 'main', [
      const CosmicCanvas(),
      Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Component.fragment([
            Header(activePath: state.location),
            child,
            const Footer(),
          ]),
          routes: [
            Route(path: '/', title: 'Home - Ibrahim AlQyas', builder: (context, state) => const Home()),
            Route(
              path: '/software',
              title: 'Software & Flutter Development - Ibrahim AlQyas',
              builder: (context, state) => const SoftwareHub(),
            ),
            Route(
              path: '/engineering',
              title: 'E&I Engineering & Inspection - Ibrahim AlQyas',
              builder: (context, state) => const EngineeringHub(),
            ),
            Route(
              path: '/projects',
              title: 'Shared Portfolio - Ibrahim AlQyas',
              builder: (context, state) => const PortfolioPage(),
            ),
            for (var project in projectsList)
              Route(
                path: '/projects/${project.id}',
                title: '${project.title} - Ibrahim AlQyas',
                builder: (context, state) => ProjectDetailPage(projectId: project.id),
              ),
            Route(
              path: '/projects/:id',
              title: 'Project Detail - Ibrahim AlQyas',
              builder: (context, state) => ProjectDetailPage(projectId: state.params['id'] ?? ''),
            ),
            Route(
              path: '/courses',
              title: 'Courses & Resources - Ibrahim AlQyas',
              builder: (context, state) => const CoursesPage(),
            ),
            Route(path: '/about', title: 'About - Ibrahim AlQyas', builder: (context, state) => const About()),
            Route(path: '/contact', title: 'Contact - Ibrahim AlQyas', builder: (context, state) => const Contact()),
          ],
        ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.main', [
      css('&').styles(
        display: Display.flex,
        minHeight: 100.vh,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        width: 100.percent,
        position: Position.relative(),
        zIndex: ZIndex(1),
      ),
      css('section').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        width: 100.percent,
        flex: Flex(grow: 1),
      ),
    ]),
    ...CosmicCanvas.styles,
    ...Header.styles,
    ...Footer.styles,
    ...Home.styles,
    ...SoftwareHub.styles,
    ...EngineeringHub.styles,
    ...PortfolioPage.styles,
    ...CoursesPage.styles,
    ...About.styles,
    ...Contact.styles,
    ...ProjectDetailPage.styles,
  ];
}
