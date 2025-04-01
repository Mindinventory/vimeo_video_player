import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Used to notify that video is loaded or not
  bool isVideoLoading = true;

  /// Controller of the WebView
  late VimeoController controller;

  @override
  void initState() {
    super.initState();

    controller = VimeoController(onReady: () {
      setState(() {
        isVideoLoading = false;
      });
    }, onPlay: (_) {
      setState(() {});
    }, onPause: (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    VimeoVideoPlayer(
                      videoId: '12860646',
                      isAutoPlay: false,
                      controller: controller,
                    ),
                    if (isVideoLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                )),
            IconButton(
              onPressed: () async {
                if (controller.isPlaying) {
                  await controller.pause();
                } else {
                  await controller.play();
                }
              },
              icon: Icon(
                controller.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 30,
              ),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
