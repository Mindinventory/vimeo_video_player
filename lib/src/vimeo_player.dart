import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Vimeo video player with customizable controls and event callbacks using the InAppWebView
class VimeoVideoPlayer extends StatefulWidget {
  /// Defines the vimeo video ID to be played
  /// [videoId] is required and cannot be empty
  final String videoId;

  /// Used to auto-play the video once initialized
  /// Default value: [false]
  final bool isAutoPlay;

  /// Used to play the video in a loop after it ends
  /// Default value: [false]
  final bool isLooping;

  /// Used to play the video with the sound muted
  /// Default value: [false]
  final bool isMuted;

  /// Used to display the video title
  /// Default value: [false]
  final bool showTitle;

  /// Used to display the video byline/author
  /// Default value: [false]
  final bool showByline;

  /// Used to display the video playback controls
  /// Default value: [true]
  final bool showControls;

  /// Used to enable Do Not Track (DNT) mode
  /// When enabled, the player will not track any viewing information
  /// Default value: [true]
  final bool enableDNT;

  /// Defines the background color of the InAppWebView
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
    this.backgroundColor = Colors.black,
    this.onReady,
    this.onPlay,
    this.onPause,
    this.onFinish,
    this.onSeek,
  }) : assert(videoId.isNotEmpty, 'videoId cannot be empty!');

  @override
  State<VimeoVideoPlayer> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  /// Used to notify that video is loaded or not
  bool isVideoLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialSettings: InAppWebViewSettings(
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
            useHybridComposition: true,
          ),
          initialData: InAppWebViewInitialData(
            data: _buildHtmlContent(),
            baseUrl: WebUri("https://player.vimeo.com"),
          ),
          onConsoleMessage: (controller, consoleMessage) {
            final message = consoleMessage.message;
            dev.log('onConsoleMessage :: $message');
            if (message.startsWith('vimeo:')) {
              _manageVimeoPlayerEvent(message.substring(6));
            }
          },
          onLoadStart: (controller, url) {
            setState(() {
              isVideoLoading = true;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              isVideoLoading = false;
            });
          },
        ),
        if (isVideoLoading)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
              backgroundColor: Colors.white,
            ),
          ),
      ],
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
        <div class="video-container">
          <iframe 
            id="player"
            src="${_buildIframeUrl()}"
            frameborder="0"
            allow="autoplay; fullscreen; picture-in-picture"
            allowfullscreen 
            webkitallowfullscreen 
            mozallowfullscreen>
          </iframe>
        </div>
        <script>
          const player = new Vimeo.Player('player');
          player.ready().then(() => console.log('vimeo:onReady'));
          player.on('play', () => console.log('vimeo:onPlay'));
          player.on('pause', () => console.log('vimeo:onPause'));
          player.on('ended', () => console.log('vimeo:onFinish'));
          player.on('seeked', () => console.log('vimeo:onSeek'));
        </script>
      </body>
    </html>
    ''';
  }

  /// Builds the iframe URL
  String _buildIframeUrl() {
    return 'https://player.vimeo.com/video/${widget.videoId}?'
        'autoplay=${widget.isAutoPlay}'
        '&loop=${widget.isLooping}'
        '&muted=${widget.isMuted}'
        '&title=${widget.showTitle}'
        '&byline=${widget.showByline}'
        '&controls=${widget.showControls}'
        '&dnt=${widget.enableDNT}';
  }

  /// Manage vimeo player events received from the WebView
  void _manageVimeoPlayerEvent(String event) {
    debugPrint('Vimeo event: $event');
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
    final hex = color.value.toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2)}'; // Remove the leading 'ff' for opacity
  }
}
