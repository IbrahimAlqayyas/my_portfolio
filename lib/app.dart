import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/cosmic_canvas.dart';
import 'components/header.dart';
import 'data/projects_data.dart';
import 'pages/about.dart';
import 'pages/contact.dart';
import 'pages/home.dart';
import 'pages/project_detail.dart';

@client
class App extends StatefulComponent {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      print("Hello client");
    } else {
      print("Hello server");
    }
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'main', [
      const CosmicCanvas(),
      Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Component.fragment([
            Header(activePath: state.location),
            child,
          ]),
          routes: [
            Route(path: '/', title: 'Home', builder: (context, state) => const Home()),
            for (var project in projectsList)
              Route(
                path: '/projects/${project.id}',
                title: project.title,
                builder: (context, state) => ProjectDetailPage(projectId: project.id),
              ),
            Route(path: '/about', title: 'About', builder: (context, state) => const About()),
            Route(path: '/contact', title: 'Contact', builder: (context, state) => const Contact()),
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
    ...ProjectDetailPage.styles,
  ];
}
