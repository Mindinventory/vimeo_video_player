/// Helper methods for working with Vimeo URLs.
///
/// This is a separate class from the [VimeoVideoPlayer] widget so the
/// two names don't collide. Call everything statically:
///   VimeoVideoPlayerUtils.extractVideoId(url);
class VimeoVideoPlayerUtils {
  // Private constructor — this class only holds static helpers,
  // so it should never be instantiated.
  VimeoVideoPlayerUtils._();

  static final RegExp _numeric = RegExp(r'^\d+$');
  static final RegExp _alnum = RegExp(r'^[a-zA-Z0-9]+$');

  /// Extracts the numeric Vimeo video ID from any common Vimeo URL.
  ///
  /// Supports:
  ///   https://vimeo.com/123456789
  ///   https://vimeo.com/123456789/abcdef1234        (unlisted)
  ///   https://player.vimeo.com/video/123456789
  ///   https://vimeo.com/channels/staffpicks/123456789
  ///   https://vimeo.com/album/123456/video/789012
  ///   123456789                                      (already an ID)
  ///
  /// Returns `null` if no valid ID is found.
  static String? extractVideoId(String url) {
    if (url.trim().isEmpty) return null;

    final uri = Uri.tryParse(url.trim());
    if (uri == null) return null;

    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();

    // Prefer an explicit `/video/{id}` segment (album/showcase URLs).
    for (var i = 0; i < segments.length - 1; i++) {
      if (segments[i] == 'video' && _numeric.hasMatch(segments[i + 1])) {
        return segments[i + 1];
      }
    }

    // Otherwise take the last purely-numeric path segment.
    for (final seg in segments.reversed) {
      if (_numeric.hasMatch(seg)) return seg;
    }

    return null;
  }

  /// Extracts the privacy hash (the `h` value) from an unlisted Vimeo URL.
  ///
  /// Handles both `vimeo.com/123456789/abcdef1234`
  /// and `vimeo.com/123456789?h=abcdef1234`.
  ///
  /// Returns `null` if there's no hash.
  static String? extractHash(String url) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null) return null;

    // Query-param style: ?h=xxxx
    final h = uri.queryParameters['h'];
    if (h != null && h.isNotEmpty) return h;

    // Path style: /{id}/{hash}
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    for (var i = 0; i < segments.length - 1; i++) {
      if (_numeric.hasMatch(segments[i]) &&
          _alnum.hasMatch(segments[i + 1]) &&
          !_numeric.hasMatch(segments[i + 1])) {
        return segments[i + 1];
      }
    }
    return null;
  }

  /// Convenience method that returns both values in one call.
  ///
  /// Example:
  ///   final result = VimeoVideoPlayerUtils.parse(url);
  ///   print(result.id);   // "123456789"
  ///   print(result.hash); // "abcdef1234" or null
  static ({String? id, String? hash}) parse(String url) {
    return (id: extractVideoId(url), hash: extractHash(url));
  }
}