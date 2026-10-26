import 'github_sync_stub.dart'
    if (dart.library.html) 'github_sync_web.dart';

class GitHubSyncService {
  static Future<GitHubSyncResult> commitFile({
    required String repo,
    required String branch,
    required String path,
    required String content,
    required String token,
    required String commitMessage,
  }) {
    return performGitHubCommit(
      repo: repo,
      branch: branch,
      path: path,
      content: content,
      token: token,
      commitMessage: commitMessage,
    );
  }
}
