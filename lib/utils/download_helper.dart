import 'download_helper_stub.dart'
    if (dart.library.html) 'download_helper_web.dart';

void triggerFileDownload(String filename, String content) {
  downloadFile(filename, content);
}

Future<bool> copyTextToClipboard(String text) {
  return copyToClipboard(text);
}
