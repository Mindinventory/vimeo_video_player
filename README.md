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
* Event callbacks include `onReady`, `onPlay`, `onPause`, `onFinish`, `onSeek`,
  `onInAppWebViewCreated`, `onInAppWebViewLoadStart`, `onInAppWebViewLoadStop`, and
  `onInAppWebViewReceivedError`.

# Preview

![vimeo_video_player](https://github.com/Mindinventory/vimeo_video_player/raw/master/screenshots/vimeo_video_player.gif)

## Basic Usage

Import it to your project file

```dart
import 'package:vimeo_video_player/vimeo_video_player.dart';
```

And add it in its most basic form like it:

```dart
@override
Widget build(BuildContext context) {
  return VimeoVideoPlayer(
    videoId: '12860646',
  );
}
```

### Required parameters of VimeoVideoPlayer
------------

| Parameter      | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| String videoId | Defines the vimeo video ID to be played, it is required and cannot be empty |

### Optional parameters of VimeoVideoPlayer with Default value
------------

| Parameter                                                                                                                     | Default      | Description                                                                                             |
|-------------------------------------------------------------------------------------------------------------------------------|--------------|---------------------------------------------------------------------------------------------------------|
| bool isAutoPlay                                                                                                               | false        | Used to auto-play the video once initialized                                                            |
| bool isLooping                                                                                                                | false        | Used to play the video in a loop after it ends                                                          |
| bool isMuted                                                                                                                  | false        | Used to play the video with the sound muted                                                             |
| bool showTitle                                                                                                                | false        | Used to display the video title                                                                         |
| bool showByline                                                                                                               | false        | Used to display the video byline/author                                                                 |
| bool showControls                                                                                                             | true         | Used to display the video playback controls                                                             |
| bool enableDNT                                                                                                                | true         | Used to enable Do Not Track (DNT) mode, When enabled, the player will not track any viewing information |
| bool portrait                                                                                                                 | false        | Used to display the profile avatar                                                                      |
| bool badge                                                                                                                    | false        | Used to display the vimeo logo                                                                          |
| bool enableFullScreenOnPlay                                                                                                   | false        | Used to enable fullscreen mode when playing. When enabled, the player go full screen when play is hit   |
| Color backgroundColor                                                                                                         | Colors.black | Defines the background color of the InAppWebView                                                        |


### Optional parameters of VimeoVideoPlayer
------------

| Parameter                                                                                                                     | Description                                                                                         |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| String? privacyHash                                                                                                           | Used to define the the hash for the unlisted vimeo video                                            |
| VoidCallback? onReady                                                                                                         | Used to define a callback function triggered when the player is ready to play the video             |
| VoidCallback? onPlay                                                                                                          | Used to define a callback function triggered when the video begins playing                          |
| VoidCallback? onPause                                                                                                         | Used to define a callback function triggered when the video is paused                               |
| VoidCallback? onFinish                                                                                                        | Used to define a callback function triggered when the video playback finishes                       |
| VoidCallback? onSeek                                                                                                          | Used to define a callback function triggered when the video playback position is modified           |
| Function(InAppWebViewController controller)? onInAppWebViewCreated                                                            | Used to define a callback function triggered when the WebView is created                            |
| Function(InAppWebViewController controller, WebUri? uri)? onInAppWebViewLoadStart                                             | Used to define a callback function triggered when the WebView starts to load an url                 |
| Function(InAppWebViewController controller, WebUri? uri)? onInAppWebViewLoadStop                                              | Used to define a callback function triggered when the WebView finishes loading an url               |
| Function(InAppWebViewController controller, WebResourceRequest request, WebResourceError? error)? onInAppWebViewReceivedError | Used to define a callback function triggered when the WebView encounters an error loading a request |
| final void Function(InAppWebViewController controller)? onEnterFullscreen                                                     | Used to define a callback function triggered when the WebView enters full screen                    |
| final void Function(InAppWebViewController controller)? onExitFullscreen                                                      | Used to define a callback function triggered when the WebView exits full screen                     |
| final ValueChanged<double>? currentPositionInSeconds                                                                          | Used to define a callback function that notifies current video position                             |
| int? initialPositionInSeconds                                                                                                 | Used to define the initial video position in seconds                                                |

## Utility Methods

The `VimeoVideoPlayerUtils` class provides helper methods to extract the video ID and privacy
hash from any common Vimeo URL, so you can pass a full URL instead of a bare video ID.

Import it to your project file

```dart
import 'package:vimeo_video_player/vimeo_video_player.dart';
```

And use it like this:

```dart
final url = 'https://vimeo.com/1124216463/abcdef1234';

final videoId = VimeoVideoPlayerUtils.extractVideoId(url); // "1124216463"
final hash = VimeoVideoPlayerUtils.extractHash(url); // "abcdef1234"

// Or get both at once:
final result = VimeoVideoPlayerUtils.parse(url);

VimeoVideoPlayer(
  videoId: result.id ?? '',
  privacyHash: result.hash,
);
```

### Methods of VimeoVideoPlayerUtils
------------

| Method                                              | Return                     | Description                                                                          |
|-----------------------------------------------------|----------------------------|--------------------------------------------------------------------------------------|
| String? extractVideoId(String url)                  | String?                    | Extracts the numeric vimeo video ID from a Vimeo URL, returns null if none is found  |
| String? extractHash(String url)                     | String?                    | Extracts the privacy hash (the `h` value) from an unlisted Vimeo URL, returns null if none is found |
| ({String? id, String? hash}) parse(String url)      | ({String? id, String? hash}) | Returns both the video ID and the privacy hash in a single call                      |

### Supported URL formats
------------

| URL                                                  | Extracted ID | Hash       |
|------------------------------------------------------|--------------|------------|
| https://vimeo.com/123456789                          | 123456789    | null       |
| https://vimeo.com/123456789/abcdef1234               | 123456789    | abcdef1234 |
| https://vimeo.com/123456789?h=abcdef1234             | 123456789    | abcdef1234 |
| https://player.vimeo.com/video/123456789             | 123456789    | null       |
| https://vimeo.com/channels/staffpicks/123456789      | 123456789    | null       |
| https://vimeo.com/album/123456/video/789012          | 789012       | null       |
| 123456789                                            | 123456789    | null       |

## Dependencies

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
