import 'scroll_helper_stub.dart'
    if (dart.library.html) 'scroll_helper_web.dart';

void scrollToTop() {
  resetScroll();
}

void scrollToId(String id) {
  scrollElementToView(id);
}
