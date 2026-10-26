import 'dart:convert';
import 'dart:html' as html;

void downloadFile(String filename, String content) {
  try {
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..style.display = 'none';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  } catch (_) {}
}

Future<bool> copyToClipboard(String text) async {
  try {
    if (html.window.navigator.clipboard != null) {
      await html.window.navigator.clipboard!.writeText(text);
      return true;
    }
  } catch (_) {}
  return false;
}
