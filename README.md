# vimeo_video_player

<a href="https://flutter.dev/"><img src="https://img.shields.io/badge/flutter-website-deepskyblue.svg" alt="Flutter Website"></a>
<a href="https://dart.dev"><img src="https://img.shields.io/badge/dart-website-deepskyblue.svg" alt="Dart Website"></a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Android-deepskyblue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-deepskyblue">
</a>
<a href=""><img src="https://app.codacy.com/project/badge/Grade/dc683c9cc61b499fa7cdbf54e4d9ff35"/></a>
<a href="https://github.com/Mindinventory/vimeo_video_player/blob/master/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/github/license/Mindinventory/vimeo_video_player"></a>
<a href="https://pub.dev/packages/vimeo_video_player"><img src="https://img.shields.io/pub/v/vimeo_video_player?color=as&label=vimeo_video_player&logo=as1&logoColor=blue&style=social"></a>
<a href="https://github.com/Mindinventory/vimeo_video_player"><img src="https://img.shields.io/github/stars/Mindinventory/vimeo_video_player?style=social" alt="MIT License"></a>

A Video Player For Vimeo Videos in Flutter.
This plugin allow us to play video from vimeo and it's supports Android and iOS platforms.

## Key Features
* easy way to play vimeo video in video player.

# Preview
![vimeo_video_player](https://github.com/mi-ghanshyam/vimeo_video_player/blob/master/assets/vimeo.gif)

## Basic Usage

Import it to your project file

```dart
import 'package:vimeo_video_player/vimeo_video_player.dart';
```

And add it in its most basic form like it:
```dart
VimeoVideoPlayer(
  url: 'https://vimeo.com/70591644',
);
```

### Required parameters of VimeoVideoPlayer
------------
| Parameter  | Description                         |
|------------|-------------------------------------|
| String url | the string url of valid vimeo video |

### Optional parameters of VimeoVideoPlayer
------------
| Parameter                                | Description                                                                             |
|------------------------------------------|-----------------------------------------------------------------------------------------|
| List<SystemUiOverlay> systemUiOverlay    | top-bottom overlay to hide/show status bars                                             |
| DeviceOrientation deviceOrientation      | deviceOrientation of video view                                                         |
| Duration? startAt                        | video will have initial position set to given minute/second                             |
| Function(Duration timePoint)? onProgress | it will be called periodically with current video position (approximately every 500 ms) |
| VoidCallback? onFinished                 | it will be called when video finishes playback                                          |
| bool autoPlay                            | to auto-play the video once initialized                                                 |

### Dependencies

* [dio](https://pub.dev/packages/dio): ^5.2.0
* [flick_video_player](https://pub.dev/packages/flick_video_player): ^0.5.0
* [video_player](https://pub.dev/packages/video_player): ^2.6.1

### Guideline for contributors
------------
* Contribution towards our repository is always welcome, we request contributors to create a pull request for development.

### Guideline to report an issue/feature request
------------
It would be great for us if the reporter can share the below things to understand the root cause of the issue.

* Library version
* Code snippet
* Logs if applicable
* Device specification like (Manufacturer, OS version, etc)
* Screenshot/video with steps to reproduce the issue
* Library used

LICENSE!
------------
**vimeo_video_player** is [MIT-licensed.](https://github.com/Mindinventory/vimeo_video_player/blob/master/LICENSE)

Let us know!
------------
We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.
