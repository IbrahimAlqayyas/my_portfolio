import 'dart:html' as html;
import 'dart:js' as js;

void resetScroll() {
  html.window.scrollTo(0, 0);
}

void scrollElementToView(String id) {
  js.context.callMethod('eval', ['document.getElementById("$id")?.scrollIntoView({behavior: "smooth"})']);
}
