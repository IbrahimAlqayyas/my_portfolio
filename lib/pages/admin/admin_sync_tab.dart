import 'dart:convert';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../services/content_repository.dart';
import '../../services/dart_code_generator.dart';
import '../../services/github_sync_service.dart';
import '../../services/storage_service.dart';
import '../../utils/download_helper.dart';

class AdminSyncTab extends StatefulComponent {
  const AdminSyncTab({super.key});

  @override
  State<AdminSyncTab> createState() => _AdminSyncTabState();
}

class _AdminSyncTabState extends State<AdminSyncTab> {
  String _githubToken = '';
  String _githubRepo = 'IbrahimAlqayyas/my_portfolio';
  String _githubBranch = 'main';
  String _githubPath = 'content/portfolio_content.json';
  String _commitMessage = 'Update portfolio content from Admin Dashboard';

  bool _isCommitting = false;
  String? _syncStatusMessage;
  bool? _syncSuccess;
  String? _commitLink;

  String _importJsonText = '';
  String? _importStatus;

  String? _copyFeedback;

  String _val(dynamic e) => (e.target as dynamic)?.value?.toString() ?? '';

  @override
  void initState() {
    super.initState();
    _loadSavedGithubConfig();
  }

  void _loadSavedGithubConfig() {
    final raw = StorageService.loadGithubConfig();
    if (raw != null && raw.isNotEmpty) {
      try {
        final Map<String, dynamic> map = jsonDecode(raw) as Map<String, dynamic>;
        _githubToken = map['token'] as String? ?? '';
        _githubRepo = map['repo'] as String? ?? 'IbrahimAlqayyas/my_portfolio';
        _githubBranch = map['branch'] as String? ?? 'main';
        _githubPath = map['path'] as String? ?? 'content/portfolio_content.json';
      } catch (_) {}
    }
  }

  void _saveGithubConfig() {
    final map = {
      'token': _githubToken.trim(),
      'repo': _githubRepo.trim(),
      'branch': _githubBranch.trim(),
      'path': _githubPath.trim(),
    };
    StorageService.saveGithubConfig(jsonEncode(map));
  }

  Future<void> _handleGitHubCommit() async {
    if (_githubToken.trim().isEmpty) {
      setState(() {
        _syncSuccess = false;
        _syncStatusMessage = 'Please enter a GitHub Personal Access Token.';
      });
      return;
    }

    _saveGithubConfig();
    setState(() {
      _isCommitting = true;
      _syncStatusMessage = 'Connecting to GitHub REST API...';
      _syncSuccess = null;
      _commitLink = null;
    });

    final jsonContent = contentRepository.exportJson();
    final result = await GitHubSyncService.commitFile(
      repo: _githubRepo,
      branch: _githubBranch,
      path: _githubPath,
      content: jsonContent,
      token: _githubToken,
      commitMessage: _commitMessage,
    );

    setState(() {
      _isCommitting = false;
      _syncSuccess = result.success;
      _syncStatusMessage = result.message;
      _commitLink = result.commitUrl;
    });
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'admin-tab-pane', [
      // 1. BROWSER LOCAL STORAGE PERSISTENCE
      _buildSectionHeader('1. Local Persistence (Zero Backend)', 'All changes you make are instantly active and cached in your browser.'),
      div(classes: 'admin-card', [
        div(classes: 'sync-status-box', [
          div(classes: 'status-indicator-row', [
            span(classes: 'status-dot-active', []),
            strong([Component.text('Local State: Active & Live in Browser')]),
          ]),
          p([
            Component.text(
              'Your edits are stored in your browser LocalStorage. Navigating through the portfolio shows your changes immediately.',
            ),
          ]),
          div(classes: 'inline-actions', [
            button(
              classes: 'btn btn-primary',
              events: {
                'click': (e) {
                  contentRepository.save();
                  setState(() {
                    _copyFeedback = '✅ All changes saved to browser storage!';
                  });
                },
              },
              [Component.text('💾 Force Save LocalState')],
            ),
            button(
              classes: 'btn btn-outline',
              events: {
                'click': (e) {
                  final json = contentRepository.exportJson();
                  triggerFileDownload('portfolio_content.json', json);
                },
              },
              [Component.text('📥 Download JSON Backup')],
            ),
            button(
              classes: 'btn-icon-danger-pill',
              events: {
                'click': (e) {
                  contentRepository.resetToDefaults();
                  setState(() {
                    _copyFeedback = '🔄 Reset to factory defaults!';
                  });
                },
              },
              [Component.text('⚠️ Reset to Factory Defaults')],
            ),
          ]),
          if (_copyFeedback != null)
            p(classes: 'feedback-success-text', [Component.text(_copyFeedback!)]),
        ]),
      ]),

      // 2. GITHUB DIRECT COMMIT (Web-to-GitHub API)
      _buildSectionHeader('2. GitHub Direct Commit (Git as Database)', 'Commit changes directly to your GitHub repository without opening a terminal or cloning code.'),
      div(classes: 'admin-card', [
        p(classes: 'hint-text', [
          Component.text(
            'Create a fine-grained or classic GitHub Personal Access Token (PAT) with "Contents: Read & Write" permission. Your token is stored ONLY locally in your browser.',
          ),
        ]),
        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('GitHub Repository (owner/repo)')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _githubRepo,
              events: {'input': (e) => _githubRepo = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('Branch')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _githubBranch,
              events: {'input': (e) => _githubBranch = _val(e)},
            ),
          ]),
        ]),
        div(classes: 'form-grid-2', [
          div(classes: 'form-group', [
            label([Component.text('File Path in Repository')]),
            input(
              type: InputType.text,
              classes: 'admin-input',
              value: _githubPath,
              events: {'input': (e) => _githubPath = _val(e)},
            ),
          ]),
          div(classes: 'form-group', [
            label([Component.text('GitHub Personal Access Token')]),
            input(
              type: InputType.password,
              classes: 'admin-input',
              value: _githubToken,
              attributes: {'placeholder': 'ghp_...'},
              events: {'input': (e) => _githubToken = _val(e)},
            ),
          ]),
        ]),
        div(classes: 'form-group', [
          label([Component.text('Commit Message')]),
          input(
            type: InputType.text,
            classes: 'admin-input',
            value: _commitMessage,
            events: {'input': (e) => _commitMessage = _val(e)},
          ),
        ]),
        div(classes: 'inline-actions', [
          button(
            classes: 'btn btn-primary btn-commit ${_isCommitting ? "disabled" : ""}',
            events: {
              'click': (e) {
                if (!_isCommitting) _handleGitHubCommit();
              },
            },
            [
              Component.text(_isCommitting ? '⏳ Committing to GitHub...' : '🚀 Commit & Push to GitHub Repo'),
            ],
          ),
        ]),
        if (_syncStatusMessage != null)
          div(classes: 'commit-feedback-box ${_syncSuccess == true ? "feedback-ok" : "feedback-err"}', [
            p([Component.text(_syncStatusMessage!)]),
            if (_commitLink != null)
              a(
                href: _commitLink!,
                attributes: {'target': '_blank'},
                classes: 'commit-link',
                [Component.text('🔗 View Commit on GitHub →')],
              ),
          ]),
      ]),

      // 3. EXPORT AS DART CODE (For Baking Directly into Codebase)
      _buildSectionHeader('3. Export to Dart Code', 'Generate clean Dart code to paste directly into your project files for 100% static builds.'),
      div(classes: 'admin-card', [
        p(classes: 'hint-text', [
          Component.text('Click to copy the compiled Dart arrays for your project repository:'),
        ]),
        div(classes: 'inline-actions', [
          button(
            classes: 'btn btn-outline',
            events: {
              'click': (e) async {
                final code = DartCodeGenerator.generateProjectsDart(contentRepository.projects);
                await copyTextToClipboard(code);
                setState(() => _copyFeedback = '📋 Copied projects_data.dart code to clipboard!');
              },
            },
            [Component.text('📋 Copy projects_data.dart Code')],
          ),
          button(
            classes: 'btn btn-outline',
            events: {
              'click': (e) async {
                final code = DartCodeGenerator.generateCoursesDart(contentRepository.courses);
                await copyTextToClipboard(code);
                setState(() => _copyFeedback = '📋 Copied courses_data.dart code to clipboard!');
              },
            },
            [Component.text('📋 Copy courses_data.dart Code')],
          ),
        ]),
      ]),

      // 4. RESTORE / IMPORT JSON
      _buildSectionHeader('4. Import JSON Data', 'Paste a previous JSON backup to restore all portfolio content.'),
      div(classes: 'admin-card', [
        div(classes: 'form-group', [
          textarea(
            classes: 'admin-textarea admin-textarea-lg',
            attributes: {'placeholder': 'Paste JSON content here...'},
            events: {'input': (e) => _importJsonText = _val(e)},
            [Component.text(_importJsonText)],
          ),
        ]),
        button(
          classes: 'btn btn-secondary',
          events: {
            'click': (e) {
              if (_importJsonText.trim().isNotEmpty) {
                final ok = contentRepository.importJson(_importJsonText);
                setState(() {
                  _importStatus = ok ? '✅ Successfully imported JSON data!' : '❌ Invalid JSON format.';
                });
              }
            },
          },
          [Component.text('🔄 Import & Overwrite Content')],
        ),
        if (_importStatus != null)
          p(classes: 'hint-text', [Component.text(_importStatus!)]),
      ]),
    ]);
  }

  Component _buildSectionHeader(String title, String subtitle) {
    return div(classes: 'admin-section-header', [
      h3([Component.text(title)]),
      p([Component.text(subtitle)]),
    ]);
  }
}
