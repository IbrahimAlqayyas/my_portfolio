import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/header.dart';
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
      Router(routes: [
        ShellRoute(
          builder: (context, state, child) => Component.fragment([
            const Header(),
            child,
          ]),
          routes: [
            Route(path: '/', title: 'Home', builder: (context, state) => const Home()),
            Route(path: '/projects/:id', title: 'Project Details', builder: (context, state) => ProjectDetailPage(projectId: state.params['id'] ?? '')),
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
      ),
      css('section').styles(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        alignItems: AlignItems.center,
        width: 100.percent,
        flex: Flex(grow: 1),
      ),
    ]),
    ...ProjectDetailPage.styles,
  ];
}
