import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoStat {
  final double duration;
  final double percent;
  final double seconds;

  const VideoStat(
      {required this.duration, required this.percent, required this.seconds});

  factory VideoStat.create(dynamic data) {
    return VideoStat(
        duration: data['duration'].toDouble(),
        percent: data['percent'].toDouble(),
        seconds: data['seconds'].toDouble());
  }
}

class VimeoController {
  late InAppWebViewController _controller;
  bool _isReady = false;
  bool _isPlaying = false;
  final void Function()? onReady;
  final void Function(VideoStat stats)? onPlay;
  final void Function(VideoStat stats)? onPause;
  final void Function(VideoStat stats)? onFinish;
  final void Function(VideoStat stats)? onSeek;
  final void Function(VideoStat stats)? onTimeUpdate;

  VimeoController(
      {this.onReady,
      this.onPlay,
      this.onPause,
      this.onFinish,
      this.onSeek,
      this.onTimeUpdate});

  bool get isReady {
    return _isReady;
  }

  bool get isPlaying {
    return _isPlaying;
  }

  void setController(InAppWebViewController controller) {
    _controller = controller;
  }

  Future<void> play() async {
    if (!_isReady) return;

    await _controller.evaluateJavascript(source: 'window.player.play();');
    _isPlaying = true;
  }

  Future<void> pause() async {
    if (!_isReady) return;

    await _controller.evaluateJavascript(source: 'window.player.pause();');
    _isPlaying = false;
  }

  Future<void> stop() async {
    if (!_isReady) return;

    await _controller.evaluateJavascript(source: 'window.player.stop();');
    _isPlaying = false;
  }

  Future<double> getCurrentTime() async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.getCurrentTime().then(function(seconds) {
    resolve(seconds);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    var result = await _controller.callAsyncJavaScript(functionBody: body);
    if (result?.value >= 0) {
      return result?.value;
    }
    return -1;
  }

  Future<void> setCurrentTime(double seconds) async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.setCurrentTime($seconds).then(function(seconds) {
    resolve(true);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    await _controller.callAsyncJavaScript(functionBody: body);
  }

  Future<void> goFullscreen() async {}

  Future<void> setMuted(bool muted) async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.setMuted($muted).then(function(muted) {
    resolve(true);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    await _controller.callAsyncJavaScript(functionBody: body);
  }

  Future<bool> getMuted() async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.getMuted().then(function(muted) {
    resolve(muted);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    var result = await _controller.callAsyncJavaScript(functionBody: body);
    if (result?.value >= 0) {
      return result?.value;
    }
    return false;
  }

  Future<void> setLoop(bool loop) async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.setLoop($loop).then(function(muted) {
    resolve(true);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    await _controller.callAsyncJavaScript(functionBody: body);
  }

  Future<bool> getLoop() async {
    String body = """
var p = new Promise(function (resolve, reject) {
  player.getLoop().then(function(loop) {
    resolve(loop);
  }).catch(function(error) {
    reject(error);
  });
});
await p;
return p;
""";
    var result = await _controller.callAsyncJavaScript(functionBody: body);
    if (result?.value >= 0) {
      return result?.value;
    }
    return false;
  }

  void dispose() {
    _controller.dispose();
  }

  void parseConsoleLog(String log) {
    var tmp = log.split("|");
    switch (tmp.first) {
      case 'onReady':
        _isReady = true;
        onReady?.call();
        break;
      case 'onPlay':
        _isPlaying = true;
        onPlay?.call(VideoStat.create(jsonDecode(tmp.last)));
        break;
      case 'onPause':
        _isPlaying = false;
        onPause?.call(VideoStat.create(jsonDecode(tmp.last)));
        break;
      case 'onFinish':
        _isPlaying = false;
        onFinish?.call(VideoStat.create(jsonDecode(tmp.last)));
        break;
      case 'onSeek':
        onSeek?.call(VideoStat.create(jsonDecode(tmp.last)));
        break;
      case 'onTimeUpdate':
        onTimeUpdate?.call(VideoStat.create(jsonDecode(tmp.last)));
        break;
    }
  }
}
