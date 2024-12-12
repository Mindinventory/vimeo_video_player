# vimeo_video_player

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Android-deepskyblue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Web-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-deepskyblue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-deepskyblue">
</a>
<a href=""><img src="https://app.codacy.com/project/badge/Grade/dc683c9cc61b499fa7cdbf54e4d9ff35"/></a>
<a href="https://github.com/Mindinventory/vimeo_video_player/blob/master/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/github/license/Mindinventory/vimeo_video_player"></a>
<a href="https://pub.dev/packages/vimeo_video_player"><img src="https://img.shields.io/pub/v/vimeo_video_player?color=as&label=vimeo_video_player&logo=as1&logoColor=blue&style=social"></a>
<a href="https://github.com/Mindinventory/vimeo_video_player"><img src="https://img.shields.io/github/stars/Mindinventory/vimeo_video_player?style=social" alt="MIT License"></a>

A Flutter package to play Vimeo videos using their Video ID. Utilizes InAppWebView for smooth video
playback directly in your Flutter app.

## Key Features

* Easy way to play vimeo video in flutter app.
* Supports customizable controls like `isAutoPlay`, `isLooping`, `isMuted`, `showTitle`,
  `showByline`,
  `showControls`, `enableDNT`, `backgroundColor`.
* Event callbacks include `onReady`, `onPlay`, `onPause`, `onFinish`, and `onSeek`.

# Preview

![vimeo_video_player](https://github.com/Mindinventory/vimeo_video_player/raw/master/screenshots/vimeo_video_player.gif)

## Basic Usage

Import it to your project file

```dart
import 'package:vimeo_video_player/vimeo_video_player.dart';
```

And add it in its most basic form like it:

```dart
VimeoVideoPlayer(
  videoId: '12860646',
);
```

### Required parameters of VimeoVideoPlayer
------------

| Parameter      | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| String videoId | Defines the vimeo video ID to be played, it is required and cannot be empty |

### Optional parameters of VimeoVideoPlayer
------------

| Parameter              | Default      | Description                                                                                             |
|------------------------|--------------|---------------------------------------------------------------------------------------------------------|
| bool isAutoPlay        | false        | Used to auto-play the video once initialized                                                            |
| bool isLooping         | false        | Used to play the video in a loop after it ends                                                          |
| bool isMuted           | false        | Used to play the video with the sound muted                                                             |
| bool showTitle         | false        | Used to display the video title                                                                         |
| bool showByline        | false        | Used to display the video byline/author                                                                 |
| bool showControls      | true         | Used to display the video playback controls                                                             |
| bool enableDNT         | true         | Used to enable Do Not Track (DNT) mode, When enabled, the player will not track any viewing information |
| Color backgroundColor  | Colors.black | Defines the background color of the InAppWebView                                                        |
| VoidCallback? onReady  | -            | Defines a callback function triggered when the player is ready to play the video                        |
| VoidCallback? onPlay   | -            | Defines a callback function triggered when the video begins playing                                     |
| VoidCallback? onPause  | -            | Defines a callback function triggered when the video is paused                                          |
| VoidCallback? onFinish | -            | Defines a callback function triggered when the video playback finishes                                  |
| VoidCallback? onSeek   | -            | Defines a callback function triggered when the video playback position is modified                      |

### Dependencies

* [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview): ^6.1.5

## Guideline for contributors

* Contribution towards our repository is always welcome, we request contributors to create a pull
  request for development.

## Guideline to report an issue/feature request

It would be great for us if the reporter can share the below things to understand the root cause of
the issue.

* Library version
* Code snippet
* Logs if applicable
* Device specification like (Manufacturer, OS version, etc)
* Screenshot/video with steps to reproduce the issue
* Library used

## LICENSE!

**vimeo_video_player**
is [MIT-licensed.](https://github.com/Mindinventory/vimeo_video_player/blob/master/LICENSE)

## Let us know!

We’d be really happy if you send us links to your projects where you use our open-source libraries.
Just send an email to [sales@mindinventory.com](mailto:sales@mindinventory.com) And do let us know
if you have any questions or suggestion regarding our work.

Visit our website [mindinventory.com](https://www.mindinventory.com)

Let us know if you are interested to building Apps or Designing Products.
<p><a href="https://www.mindinventory.com/contact-us.php?utm_source=gthb&utm_medium=repo&utm_campaign=vimeo_video_player" target="__blank">
<img src="https://github.com/Mindinventory/vimeo_video_player/raw/master/assets/have_a_project_button.png" width="203" height="43"  alt="flutter app development">
</a></p>