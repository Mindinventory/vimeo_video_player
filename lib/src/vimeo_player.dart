import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'model/vimeo_video_config.dart';

class VimeoVideoPlayer extends StatefulWidget {
  const VimeoVideoPlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  /// vimeo video url
  final String url;

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
    final match = regExp.firstMatch(widget.url);
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
    super.dispose();
  }

  void _videoPlayer() {
    if (_isVimeoVideo) {
      /// getting the vimeo video configuration from api and setting managers
      _getVimeoVideoConfigFromUrl(widget.url).then((value) {
        var vimeoMp4Video = value?.request?.files?.progressive?[0]?.url ?? '';

        _videoPlayerController = VideoPlayerController.network(vimeoMp4Video);
        _flickManager = FlickManager(
          videoPlayerController: _videoPlayerController,
          autoPlay: false,
        );

        isVimeoVideoLoaded.value = !isVimeoVideoLoaded.value;
      });
    }
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
                preferredDeviceOrientation: const [
                  DeviceOrientation.portraitUp,
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
    /// https://vimeo.com/70591644 => 70591644
    /// www.vimeo.com/70591644 => 70591644
    /// vimeo.com/70591644 => 70591644
    var vimeoVideoId = '';
    for (var exp in [
      RegExp(r"^((https?):\/\/)?(www.)?vimeo\.com\/([0-9]+).*$"),
    ]) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        vimeoVideoId = match.group(4) ?? '';
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
      dynamic data = responseData.data;
      var vimeoVideo = VimeoVideoConfig.fromJson(data);
      return vimeoVideo;
    } on DioError catch (e) {
      debugPrint('Dio Error : ${e.error}');
      return null;
    } on Exception catch (e) {
      debugPrint('Error : ${e.toString()}');
      return null;
    }
  }
}
