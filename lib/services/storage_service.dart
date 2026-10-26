import 'storage_service_stub.dart'
    if (dart.library.html) 'storage_service_web.dart';

class StorageService {
  static const String contentStorageKey = 'alqyas_portfolio_content_v1';
  static const String githubConfigKey = 'alqyas_github_config_v1';

  static String? loadContent() => getLocalStorageItem(contentStorageKey);

  static void saveContent(String json) {
    setLocalStorageItem(contentStorageKey, json);
  }

  static void clearContent() {
    removeLocalStorageItem(contentStorageKey);
  }

  static String? loadGithubConfig() => getLocalStorageItem(githubConfigKey);

  static void saveGithubConfig(String json) {
    setLocalStorageItem(githubConfigKey, json);
  }
}
