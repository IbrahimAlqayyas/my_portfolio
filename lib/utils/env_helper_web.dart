import 'dart:html' as html;

bool get isLocalEnvironment {
  try {
    final host = html.window.location.hostname?.toLowerCase().trim() ?? '';
    return host == 'localhost' ||
        host == '127.0.0.1' ||
        host == '::1' ||
        host == '0.0.0.0' ||
        host.endsWith('.local') ||
        host.isEmpty;
  } catch (_) {
    return false;
  }
}
