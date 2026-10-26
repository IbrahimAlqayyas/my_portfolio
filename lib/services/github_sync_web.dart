import 'dart:convert';
import 'dart:html' as html;

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
  try {
    final cleanRepo = repo.trim().replaceAll('https://github.com/', '');
    final cleanBranch = branch.trim().isEmpty ? 'main' : branch.trim();
    final cleanPath = path.trim().startsWith('/') ? path.trim().substring(1) : path.trim();

    final getUrl = 'https://api.github.com/repos/$cleanRepo/contents/$cleanPath?ref=$cleanBranch';

    String? existingSha;
    try {
      final getReq = await html.HttpRequest.request(
        getUrl,
        method: 'GET',
        requestHeaders: {
          'Authorization': 'Bearer ${token.trim()}',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      if (getReq.status == 200 && getReq.responseText != null) {
        final Map<String, dynamic> body = jsonDecode(getReq.responseText!) as Map<String, dynamic>;
        existingSha = body['sha'] as String?;
      }
    } catch (_) {
      // 404 is normal if the file doesn't exist yet
    }

    final bytes = utf8.encode(content);
    final base64Content = base64.encode(bytes);

    final putUrl = 'https://api.github.com/repos/$cleanRepo/contents/$cleanPath';
    final payload = <String, dynamic>{
      'message': commitMessage,
      'content': base64Content,
      'branch': cleanBranch,
    };
    if (existingSha != null) {
      payload['sha'] = existingSha;
    }

    final putReq = await html.HttpRequest.request(
      putUrl,
      method: 'PUT',
      requestHeaders: {
        'Authorization': 'Bearer ${token.trim()}',
        'Accept': 'application/vnd.github.v3+json',
        'Content-Type': 'application/json',
      },
      sendData: jsonEncode(payload),
    );

    if (putReq.status == 200 || putReq.status == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(putReq.responseText ?? '{}') as Map<String, dynamic>;
      final commitObj = responseBody['commit'] as Map<String, dynamic>?;
      final htmlUrl = commitObj?['html_url'] as String?;

      return GitHubSyncResult(
        success: true,
        message: 'Successfully committed to $cleanRepo ($cleanBranch)!',
        commitUrl: htmlUrl,
      );
    } else {
      return GitHubSyncResult(
        success: false,
        message: 'GitHub API responded with status ${putReq.status}: ${putReq.responseText}',
      );
    }
  } catch (e) {
    return GitHubSyncResult(
      success: false,
      message: 'Network or authentication error: $e',
    );
  }
}
