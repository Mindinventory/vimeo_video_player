import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'model/vimeo_video_config.dart';

class VimeoPlayerModel {
  /// vimeo video url
  final String url;

  /// hide/show device status-bar
  final List<SystemUiOverlay> systemUiOverlay;

  /// If this value is set, video will have initial position
  /// set to given minute/second.
  ///
  /// Incorrect values (exceeding the video duration) will be ignored.
  final Duration? startAt;

  /// If this function is provided, it will be called periodically with
  /// current video position (approximately every 500 ms).
  final void Function(Duration timePoint)? onProgress;

  /// If this function is provided, it will be called when video
  /// finishes playback.
  final VoidCallback? onFinished;

  /// deviceOrientation of video view
  DeviceOrientation deviceOrientation;

  VimeoPlayerModel({
    Key? key,
    required this.url,
    this.systemUiOverlay = const [SystemUiOverlay.top, SystemUiOverlay.bottom],
    this.deviceOrientation = DeviceOrientation.portraitUp,
    this.startAt,
    this.onProgress,
    this.onFinished,
  });
}

class VimeoVideoPlayer extends StatefulWidget {
  const VimeoVideoPlayer({
    Key? key,
    required this.vimeoPlayerModel,
  }) : super(key: key);

  final VimeoPlayerModel vimeoPlayerModel;

  @override
  _VimeoVideoPlayerState createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  /// video player controller
  late VideoPlayerController _videoPlayerController;

  /// flick manager to manage the flick player
  late FlickManager _flickManager;

  /// used to notify that video is loaded or not
  ValueNotifier<bool> isVimeoVideoLoaded = ValueNotifier(false);

  /// used to check that the url format is valid vimeo video format
  bool get _isVimeoVideo {
    var regExp = RegExp(
      r"^((https?):\/\/)?(www.)?vimeo\.com\/([0-9]+).*$",
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(widget.vimeoPlayerModel.url);
    if (match != null && match.groupCount >= 1) return true;
    return false;
  }

  @override
  void initState() {
    super.initState();

    /// checking that vimeo url is valid or not
    if (_isVimeoVideo) {
      _videoPlayer();
    }
  }

  @override
  void deactivate() {
    _videoPlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    /// disposing the controllers
    _flickManager.dispose();
    _videoPlayerController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
  }

  void _setVideoInitialPosition(VideoPlayerController controller) {
    final Duration? startAt = widget.vimeoPlayerModel.startAt;
    if (startAt != null) {
      if (controller.value.duration > startAt) {
        controller.seekTo(startAt);
      } // else ignore, incorrect value
    }
  }

  void _setVideoListeners(VideoPlayerController controller) {
    final onProgressCallback = widget.vimeoPlayerModel.onProgress;
    final onFinishCallback = widget.vimeoPlayerModel.onFinished;

    if (onProgressCallback != null || onFinishCallback != null) {
      _videoPlayerController.addListener(() {
        final VideoPlayerValue videoData = _videoPlayerController.value;
        if (videoData.isInitialized) {
          if (videoData.isPlaying) {
            if (onProgressCallback != null) {
              onProgressCallback.call(videoData.position);
            }
          } else if (videoData.duration == videoData.position) {
            if (onFinishCallback != null) {
              onFinishCallback.call();
            }
          }
        }
      });
    }
  }

  void _videoPlayer() {
    /// getting the vimeo video configuration from api and setting managers
    _getVimeoVideoConfigFromUrl(widget.vimeoPlayerModel.url)
        .then((value) async {
      final progressiveList = value?.request?.files?.progressive;

      var vimeoMp4Video = '';

      if (progressiveList != null && progressiveList.isNotEmpty) {
        progressiveList.map((element) {
          if (element != null &&
              element.url != null &&
              element.url != '' &&
              vimeoMp4Video == '') {
            vimeoMp4Video = element.url ?? '';
          }
        }).toList();
        if (vimeoMp4Video.isEmpty || vimeoMp4Video == '') {
          showAlertDialog(context);
        }
      }

      _videoPlayerController = VideoPlayerController.network(vimeoMp4Video);
      await _videoPlayerController.initialize();
      _setVideoInitialPosition(_videoPlayerController);
      _setVideoListeners(_videoPlayerController);

      _flickManager = FlickManager(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
      );

      isVimeoVideoLoaded.value = !isVimeoVideoLoaded.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isVimeoVideoLoaded,
      builder: (context, bool isVideo, child) => Container(
        child: isVideo
            ? FlickVideoPlayer(
                key: ObjectKey(_flickManager),
                flickManager: _flickManager,
                systemUIOverlay: widget.vimeoPlayerModel.systemUiOverlay,
                preferredDeviceOrientation: const [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
                flickVideoWithControls: const FlickVideoWithControls(
                  videoFit: BoxFit.fitWidth,
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  backgroundColor: Colors.white,
                ),
              ),
      ),
    );
  }

  /// used to get valid vimeo video configuration
  Future<VimeoVideoConfig?> _getVimeoVideoConfigFromUrl(
    String url, {
    bool trimWhitespaces = true,
  }) async {
    if (trimWhitespaces) url = url.trim();

    /// here i'm converting the vimeo video id only and calling config api for vimeo video .mp4
    /// supports this types of urls
    /// https://vimeo.com/70591644 => 70591644
    /// www.vimeo.com/70591644 => 70591644
    /// vimeo.com/70591644 => 70591644
    var vimeoVideoId = '';
    var videoIdGroup = 4;
    for (var exp in [
      RegExp(r"^((https?):\/\/)?(www.)?vimeo\.com\/([0-9]+).*$"),
    ]) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        vimeoVideoId = match.group(videoIdGroup) ?? '';
      }
    }

    final response = await _getVimeoVideoConfig(vimeoVideoId: vimeoVideoId);
    return (response != null) ? response : null;
  }

  /// give vimeo video configuration from api
  Future<VimeoVideoConfig?> _getVimeoVideoConfig({
    required String vimeoVideoId,
  }) async {
    try {
      Response responseData = await Dio().get(
        'https://player.vimeo.com/video/$vimeoVideoId/config',
      );
      var vimeoVideo = VimeoVideoConfig.fromJson(responseData.data);
      return vimeoVideo;
    } on DioError catch (e) {
      log('Dio Error : ', name: e.error.toString());
      return null;
    } on Exception catch (e) {
      log('Error : ', name: e.toString());
      return null;
    }
  }
}

extension _ on _VimeoVideoPlayerState {
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Some thing wrong with this url"),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
