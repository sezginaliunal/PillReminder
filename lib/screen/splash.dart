import 'package:flutter/material.dart';
import 'package:medication/screen/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        setState(() {});
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
      });
    _controller?.setLooping(true);
    _controller?.play();
  }

  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : Container(),
      ),
    );
  }
}
