import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/mobile/web_listener_stub.dart'
    if (dart.library.js_interop) 'package:vimeo_video_player/web/web_listener_web.dart';

/// Vimeo video player with customizable controls and event callbacks using the InAppWebView
class VimeoVideoPlayer extends StatefulWidget {
  /// Defines the vimeo video ID to be played
  ///
  /// [videoId] is required and cannot be empty
  final String videoId;

  /// Used to auto-play the video once initialized
  ///
  /// Default value: [false]
  final bool isAutoPlay;

  /// Used to play the video in a loop after it ends
  ///
  /// Default value: [false]
  final bool isLooping;

  /// Used to play the video with the sound muted
  ///
  /// Default value: [false]
  final bool isMuted;

  /// Used to display the video title
  ///
  /// Default value: [false]
  final bool showTitle;

  /// Used to display the video byline/author
  ///
  /// Default value: [false]
  final bool showByline;

  /// Used to display the video playback controls
  ///
  /// Default value: [true]
  final bool showControls;

  /// Used to enable Do Not Track (DNT) mode
  /// When enabled, the player will not track any viewing information
  ///
  /// Default value: [true]
  final bool enableDNT;

  /// Defines the hash for the unlisted vimeo video
  /// [privacyHash] is needed only for unlisted video.
  final String? privacyHash;

  /// Used to display the profile avatar
  ///
  /// Default value: [false]
  final bool portrait;

  /// Used to display the vimeo logo
  ///
  /// Default value: [false]
  final bool badge;

  /// Used to enable fullscreen mode when playing
  /// When enabled, the player go full screen when play is hit
  ///
  /// Default value: [false]
  final bool enableFullScreenOnPlay;

  /// Defines the background color of the InAppWebView
  ///
  /// Default Value: [Colors.black]
  final Color backgroundColor;

  /// Defines a callback function triggered when the player is ready to play the video
  final VoidCallback? onReady;

  /// Defines a callback function triggered when the video begins playing
  final VoidCallback? onPlay;

  /// Defines a callback function triggered when the video is paused
  final VoidCallback? onPause;

  /// Defines a callback function triggered when the video playback finishes
  final VoidCallback? onFinish;

  /// Defines a callback function triggered when the video playback position is modified
  final VoidCallback? onSeek;

  /// Defines a callback function triggered when the WebView is created
  final Function(InAppWebViewController controller)? onInAppWebViewCreated;

  /// Defines a callback function triggered when the WebView starts to load an url
  final Function(InAppWebViewController controller, WebUri? url)?
  onInAppWebViewLoadStart;

  /// Defines a callback function triggered when the WebView finishes loading an url
  final Function(InAppWebViewController controller, WebUri? url)?
  onInAppWebViewLoadStop;

  /// Defines a callback function triggered when the WebView encounters an error loading a request
  final Function(
    InAppWebViewController controller,
    WebResourceRequest request,
    WebResourceError error,
  )?
  onInAppWebViewReceivedError;

  /// Defines a callback function triggered when the WebView enters full screen
  final void Function(InAppWebViewController controller)? onEnterFullscreen;

  /// Defines a callback function triggered when the WebView exits full screen
  final void Function(InAppWebViewController controller)? onExitFullscreen;

  /// Defines a callback function that notifies current video position
  final ValueChanged<double>? currentPositionInSeconds;

  /// Defines the initial video position in seconds
  int? initialPositionInSeconds;

  VimeoVideoPlayer({
    super.key,
    required this.videoId,
    this.isAutoPlay = false,
    this.isLooping = false,
    this.isMuted = false,
    this.showTitle = false,
    this.showByline = false,
    this.showControls = true,
    this.enableDNT = true,
    this.privacyHash,
    this.portrait = false,
    this.badge = false,
    this.enableFullScreenOnPlay = false,
    this.backgroundColor = Colors.black,
    this.onReady,
    this.onPlay,
    this.onPause,
    this.onFinish,
    this.onSeek,
    this.onInAppWebViewCreated,
    this.onInAppWebViewLoadStart,
    this.onInAppWebViewLoadStop,
    this.onInAppWebViewReceivedError,
    this.onEnterFullscreen,
    this.onExitFullscreen,
    this.currentPositionInSeconds,
    this.initialPositionInSeconds,
  }) : assert(videoId.isNotEmpty, 'videoId cannot be empty!');

  @override
  State<VimeoVideoPlayer> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  @override
  void initState() {
    super.initState();
    setupWebListener((event) {
      _manageVimeoPlayerEvent(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        useHybridComposition: true,
        iframeAllow: "autoplay; fullscreen; picture-in-picture",
        iframeAllowFullscreen: true,
      ),
      initialData: InAppWebViewInitialData(
        data: _buildHtmlContent(),
        baseUrl: WebUri("https://player.vimeo.com"),
      ),
      onWebViewCreated: (controller) {
        widget.onInAppWebViewCreated!(controller);
        if (!kIsWeb) {
          // Handle JavaScript callbacks
          controller.addJavaScriptHandler(
            handlerName: 'onVimeoEvent',
            callback: (args) {
              String event = args.isNotEmpty ? args[0].toString() : "unknown";
              _manageVimeoPlayerEvent(event);
            },
          );
        }
      },
      onLoadStart: widget.onInAppWebViewLoadStart,
      onLoadStop: widget.onInAppWebViewLoadStop,
      onReceivedError: widget.onInAppWebViewReceivedError,
      onEnterFullscreen: (controller) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        if (widget.onEnterFullscreen != null) {
          widget.onEnterFullscreen?.call(controller);
        }
      },
      onExitFullscreen: (controller) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        if (widget.onExitFullscreen != null) {
          widget.onExitFullscreen?.call(controller);
        }
      },
    );
  }

  /// Builds the HTML content for the vimeo player
  String _buildHtmlContent() {
    return '''
    <!DOCTYPE html>
    <html>
      <head>
        <style>
          body {
            margin: 0;
            padding: 0;
            background-color: ${_colorToHex(widget.backgroundColor)};
          }
          .video-container {
            position: relative;
            width: 100%;
            height: 100vh;
          }
          iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
          }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
      <script src="https://player.vimeo.com/api/player.js"></script>
    </head>
    <body>
      <iframe id="vimeoPlayer" src="${_buildIframeUrl()}" 
      frameborder="0" allow="autoplay; fullscreen; picture-in-picture"allowfullscreen 
            webkitallowfullscreen 
            mozallowfullscreen>
      </iframe>

      <script>
        var iframe = document.getElementById('vimeoPlayer');
        var player = new Vimeo.Player(iframe);

        function sendEventToFlutter(eventName) {
          if (window.flutter_inappwebview) {
            // Mobile (Android/iOS)
            window.flutter_inappwebview.callHandler('onVimeoEvent', eventName);
          } else {
            // Web
            window.parent.postMessage({ vimeoEvent: eventName }, "*");
          }
        }

        player.on('play', function() { sendEventToFlutter('onPlay'); });
        player.on('pause', function() { sendEventToFlutter('onPause'); });
        player.on('loaded', function() { 
          sendEventToFlutter('onReady'); 
          ${widget.initialPositionInSeconds != null ? 'player.setCurrentTime(${widget.initialPositionInSeconds});' : ''}  
        });
        player.on('seeked', function() { sendEventToFlutter('onSeek'); });
        player.on('ended', function() { sendEventToFlutter('onFinish'); });
        player.on('timeupdate', function(data) {
          sendEventToFlutter('currentPosition:' + data.seconds);
        });
      </script>
    </body>
    </html>
    ''';
  }

  /// Builds the iframe URL
  String _buildIframeUrl() {
    return 'https://player.vimeo.com/video/${widget.videoId}?'
        'autoplay=${widget.isAutoPlay.toFlag()}'
        '&loop=${widget.isLooping.toFlag()}'
        '&muted=${widget.isMuted.toFlag()}'
        '&byline=${widget.showByline.toFlag()}'
        '&controls=${widget.showControls.toFlag()}'
        '&dnt=${widget.enableDNT.toFlag()}'
        '${widget.privacyHash != null ? '&h=${widget.privacyHash}' : ''}'
        '&portrait=${widget.portrait.toFlag()}'
        '&badge=${(!widget.badge).toFlag()}'
        '&playsinline=${(!widget.enableFullScreenOnPlay).toFlag()}';
  }

  /// Manage vimeo player events received from the WebView
  void _manageVimeoPlayerEvent(String event) {
    debugPrint('Vimeo event: $event');
    if (widget.currentPositionInSeconds != null &&
        event.contains("currentPosition")) {
      final position = event.split(":").last.trim();
      widget.currentPositionInSeconds?.call(double.tryParse(position) ?? 0);
    }
    switch (event) {
      case 'onReady':
        widget.onReady?.call();
        break;
      case 'onPlay':
        widget.onPlay?.call();
        break;
      case 'onPause':
        widget.onPause?.call();
        break;
      case 'onFinish':
        widget.onFinish?.call();
        break;
      case 'onSeek':
        widget.onSeek?.call();
        break;
    }
  }

  /// Converts Color to a hexadecimal string
  String _colorToHex(Color color) {
    final hex = color.toARGB32().toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2)}'; // Remove the leading 'ff' for opacity
  }
}

extension BoolToFlag on bool {
  String toFlag() => this ? "1" : "0";
}
