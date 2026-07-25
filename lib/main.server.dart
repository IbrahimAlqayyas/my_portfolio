/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/dom.dart';
// Server-specific Jaspr import.
import 'package:jaspr/server.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

import 'constants/theme.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  runApp(Document(
    base: '/my_portfolio/',
    title: 'my_portfolio',
    styles: [
      css.import('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap'),
      css('html, body').styles(
        raw: {'scroll-behavior': 'smooth'},
        width: 100.percent,
        minHeight: 100.vh,
        padding: Padding.zero,
        margin: Margin.zero,
        backgroundColor: backgroundColor,
        color: textColor,
        fontFamily: const FontFamily.list([FontFamily('Inter'), FontFamilies.sansSerif]),
      ),
      css('h1').styles(
        margin: Margin.unset,
        fontSize: 3.5.rem,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
      css('p').styles(
        color: textMutedColor,
        fontSize: 1.1.rem,
      ),
      css('a, a:hover, a:visited, a:active').styles(
        textDecoration: TextDecoration(line: TextDecorationLine.none),
        cursor: Cursor.pointer,
      ),
    ],
    body: App(),
  ));
}
