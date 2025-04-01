import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'vimeo_controller.dart';

class VimeoVideoPlayer extends StatelessWidget {
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

  /// Defines the background color of the InAppWebView
  ///
  /// Default Value: [Colors.black]
  final Color backgroundColor;

  final String? secret;

  final VimeoController controller;

  VimeoVideoPlayer({
    super.key,
    required this.videoId,
    required this.controller,
    this.isAutoPlay = false,
    this.isLooping = false,
    this.isMuted = false,
    this.showTitle = false,
    this.showByline = false,
    this.showControls = true,
    this.enableDNT = true,
    this.backgroundColor = Colors.black,
    this.secret,
  }) : assert(videoId.isNotEmpty, 'videoId cannot be empty!');

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        useHybridComposition: true,
      ),
      initialData: InAppWebViewInitialData(
        data: _buildHtmlContent(),
        baseUrl: WebUri("https://player.vimeo.com"),
      ),
      onConsoleMessage: (webController, consoleMessage) {
        final message = consoleMessage.message;
        dev.log('onConsoleMessage :: $message');
        if (message.startsWith('vimeo|')) {
          controller.parseConsoleLog(message.substring(6));
        }
      },
      onWebViewCreated: (webController) {
        controller.setController(webController);
      },
      onReceivedError: (controller, request, error) {},
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
            background-color: ${_colorToHex(backgroundColor)};
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
          window.player = new Vimeo.Player('player');
          window.player.ready().then(() => console.log('vimeo|onReady'));
          window.player.on('play', (data) => console.log('vimeo|onPlay|' + JSON.stringify(data)));
          window.player.on('pause', (data) => console.log('vimeo|onPause|' + JSON.stringify(data)));
          window.player.on('ended', (data) => console.log('vimeo|onFinish|' + JSON.stringify(data)));
          window.player.on('seeked', (data) => console.log('vimeo|onSeek|' + JSON.stringify(data)));
          window.player.on('timeupdate', (data) => console.log('vimeo|onTimeUpdate|' + JSON.stringify(data)));
        </script>
      </body>
    </html>
    ''';
  }

  /// Builds the iframe URL
  String _buildIframeUrl() {
    var additional = secret == null ? '' : '&h=$secret';
    return 'https://player.vimeo.com/video/$videoId?'
        'autoplay=$isAutoPlay'
        '&loop=$isLooping'
        '&muted=$isMuted'
        '&title=$showTitle'
        '&byline=$showByline'
        '&controls=$showControls'
        '&dnt=$enableDNT'
        '$additional';
  }

  /// Converts Color to a hexadecimal string
  String _colorToHex(Color color) {
    final hex = color.value.toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2)}'; // Remove the leading 'ff' for opacity
  }
}
