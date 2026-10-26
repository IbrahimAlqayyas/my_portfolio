enum VideoPlatform {
  youtube,
  googleDrive,
  directVideo,
  unknown,
}

class ParsedVideoInfo {
  final VideoPlatform platform;
  final String embedUrl;
  final String originalUrl;
  final String? videoId;

  const ParsedVideoInfo({
    required this.platform,
    required this.embedUrl,
    required this.originalUrl,
    this.videoId,
  });

  bool get isPlayable => platform != VideoPlatform.unknown && embedUrl.isNotEmpty;
  bool get isYouTube => platform == VideoPlatform.youtube;
  bool get isGoogleDrive => platform == VideoPlatform.googleDrive;
  bool get isDirectVideo => platform == VideoPlatform.directVideo;

  String get platformLabel {
    switch (platform) {
      case VideoPlatform.youtube:
        return 'YouTube Player';
      case VideoPlatform.googleDrive:
        return 'Google Drive Stream';
      case VideoPlatform.directVideo:
        return 'HTML5 Direct Player';
      case VideoPlatform.unknown:
        return 'External Link';
    }
  }

  String get platformBadgeIcon {
    switch (platform) {
      case VideoPlatform.youtube:
        return '▶️';
      case VideoPlatform.googleDrive:
        return '📁';
      case VideoPlatform.directVideo:
        return '🎬';
      case VideoPlatform.unknown:
        return '🔗';
    }
  }
}

class VideoUrlHelper {
  static ParsedVideoInfo parse(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const ParsedVideoInfo(
        platform: VideoPlatform.unknown,
        embedUrl: '',
        originalUrl: '',
      );
    }

    final url = raw.trim();

    // 1. YouTube Detection
    if (url.contains('youtu.be') || url.contains('youtube.com')) {
      final id = _extractYouTubeId(url);
      if (id != null && id.isNotEmpty) {
        return ParsedVideoInfo(
          platform: VideoPlatform.youtube,
          embedUrl: 'https://www.youtube-nocookie.com/embed/$id?rel=0&modestbranding=1',
          originalUrl: url,
          videoId: id,
        );
      }
    }

    // 2. Google Drive Detection
    if (url.contains('drive.google.com')) {
      final id = _extractGoogleDriveId(url);
      if (id != null && id.isNotEmpty) {
        return ParsedVideoInfo(
          platform: VideoPlatform.googleDrive,
          embedUrl: 'https://drive.google.com/file/d/$id/preview',
          originalUrl: url,
          videoId: id,
        );
      }
    }

    // 3. Direct HTML5 Video Detection (.mp4, .webm, .ogg, .mov)
    final lower = url.toLowerCase().split('?').first;
    if (lower.endsWith('.mp4') || lower.endsWith('.webm') || lower.endsWith('.ogg') || lower.endsWith('.mov')) {
      return ParsedVideoInfo(
        platform: VideoPlatform.directVideo,
        embedUrl: url,
        originalUrl: url,
      );
    }

    // Fallback: If it's already an embed URL or other link
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return ParsedVideoInfo(
        platform: VideoPlatform.unknown,
        embedUrl: url,
        originalUrl: url,
      );
    }

    return const ParsedVideoInfo(
      platform: VideoPlatform.unknown,
      embedUrl: '',
      originalUrl: '',
    );
  }

  static String? _extractYouTubeId(String url) {
    // Standard: https://www.youtube.com/watch?v=VIDEO_ID
    final vMatch = RegExp(r'[?&]v=([a-zA-Z0-9_-]{6,15})').firstMatch(url);
    if (vMatch != null) return vMatch.group(1);

    // Shortened: https://youtu.be/VIDEO_ID
    final shortMatch = RegExp(r'youtu\.be\/([a-zA-Z0-9_-]{6,15})').firstMatch(url);
    if (shortMatch != null) return shortMatch.group(1);

    // Embed: https://www.youtube.com/embed/VIDEO_ID
    final embedMatch = RegExp(r'youtube\.com\/embed\/([a-zA-Z0-9_-]{6,15})').firstMatch(url);
    if (embedMatch != null) return embedMatch.group(1);

    // Shorts: https://www.youtube.com/shorts/VIDEO_ID
    final shortsMatch = RegExp(r'youtube\.com\/shorts\/([a-zA-Z0-9_-]{6,15})').firstMatch(url);
    if (shortsMatch != null) return shortsMatch.group(1);

    return null;
  }

  static String? _extractGoogleDriveId(String url) {
    // /file/d/FILE_ID/view or /file/d/FILE_ID/preview
    final fileMatch = RegExp(r'\/file\/d\/([a-zA-Z0-9_-]{20,60})').firstMatch(url);
    if (fileMatch != null) return fileMatch.group(1);

    // ?id=FILE_ID or &id=FILE_ID
    final idMatch = RegExp(r'[?&]id=([a-zA-Z0-9_-]{20,60})').firstMatch(url);
    if (idMatch != null) return idMatch.group(1);

    return null;
  }
}
