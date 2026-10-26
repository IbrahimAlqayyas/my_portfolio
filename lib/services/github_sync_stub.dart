class GitHubSyncResult {
  final bool success;
  final String message;
  final String? commitUrl;

  const GitHubSyncResult({
    required this.success,
    required this.message,
    this.commitUrl,
  });
}

Future<GitHubSyncResult> performGitHubCommit({
  required String repo, // 'owner/repo'
  required String branch,
  required String path,
  required String content,
  required String token,
  required String commitMessage,
}) async {
  return const GitHubSyncResult(
    success: false,
    message: 'GitHub Direct Commit is only supported in web browser environment.',
  );
}
