## 1.0.0

* **BREAKING CHANGE**: The library now uses an `InAppWebView` to play Vimeo videos,
  as the public `config` endpoint of vimeo has been deprecated and is no longer in use.
* Added customizable controls and event callbacks using the InAppWebView, including options like
  `isAutoPlay`, `isLooping`, `isMuted`, `showTitle`, `showByline`, `showControls`, `enableDNT`,
  `backgroundColor` and event callbacks include `onReady`, `onPlay`, `onPause`, `onFinish`, and
  `onSeek`.
* Updated the library details.

## 0.0.16

* Fixed the issue.
    - [#41](https://github.com/Mindinventory/vimeo_video_player/issues/41) - Version failure.
* Merged the PR.
    - [#44](https://github.com/Mindinventory/vimeo_video_player/pull/44) - Update flick_video_player
      to 0.8.0 Thanks to [harmjanr](https://github.com/harmjanr).
* Updated the library details.

## 0.0.15

* Updated the config response of vimeo video.
* Updated the example for android.
* Updated the library details.

## 0.0.14

* Updated the vimeo video regular expression to accurately retrieve the Vimeo video ID from the
  matching pattern.
* Updated the library details.

## 0.0.13

* Fixed the issue.
    - [#36](https://github.com/Mindinventory/vimeo_video_player/issues/36) - Video URL not working.
* Updated the library details.

## 0.0.12

* Updated the library details.

## 0.0.11

* **BREAKING CHANGE**: The library now requires Dart version `3.2.0` or higher,
  and Flutter version `3.16.0` or higher.
* Fixed the issues.
    - [#29](https://github.com/Mindinventory/vimeo_video_player/issues/29) - App crash pressed
      back button.
    - [#31](https://github.com/Mindinventory/vimeo_video_player/issues/31) - CORS issues when
      using VimeoVideoPlayer.
    - [#34](https://github.com/Mindinventory/vimeo_video_player/issues/34) - Old version of
      dependencies.
* Merged the PR.
    - [#30](https://github.com/Mindinventory/vimeo_video_player/pull/30) - fix: crash on back when
      the video is playing Thanks to [phankietit](https://github.com/phankietit).
* Updated the library details.

## 0.0.10

* Fixed the issue.
    - [#25](https://github.com/Mindinventory/vimeo_video_player/issues/25) - Callbacks onFinished
      and onProgress not work.
* Improved the code.
* Updated the library details.

## 0.0.9

* Improved the code.
* Updated the library details.

## 0.0.8

* Updated the config response of vimeo video and video player initialization.
* Updated the library details.

## 0.0.7

* Merged the PR.
    - [#17](https://github.com/Mindinventory/vimeo_video_player/pull/17) - Autoplay video
      Thanks to [mrossi-os](https://github.com/mrossi-os).
* Improved the code.
* Updated the library details.

## 0.0.6

* Fixed the issue.
    - [#7](https://github.com/Mindinventory/vimeo_video_player/issues/7) - Auto video rotate not
      working when device rotate.
* Updated the library details.

## 0.0.5

* Merged the PR.
    - [#8](https://github.com/Mindinventory/vimeo_video_player/pull/8) - Start time, progress &
      finish listeners Thanks to [piotrszych](https://github.com/piotrszych).
* Updated the library details.

## 0.0.4

* Updated the config response of vimeo video.
* Updated the library details.

## 0.0.3

* Fixed the issues.
    - [#1](https://github.com/Mindinventory/vimeo_video_player/issues/1) - flick_video_player
      version is depricated and cause conflict with provider v6.
    - [#2](https://github.com/Mindinventory/vimeo_video_player/issues/2) - It only show video screen
      without the video.
    - [#4](https://github.com/Mindinventory/vimeo_video_player/issues/4) - VideoStream.fromJson is
      broken.
* Enhanced the library by adding additional utilities.
* Updated the library details.

## 0.0.2

* Updated the library details.

## 0.0.1

* Initial release of `vimeo_video_player` library.