import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:swing_share/presentation/video_player/flick_multi_manager.dart';
import 'package:swing_share/presentation/video_player/portrait_controls.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer({
    Key? key,
    required this.url,
    this.image,
    required this.flickMultiManager,
    required this.videoSize,
  }) : super(key: key);

  final String url;
  final String? image;
  final FlickMultiManager flickMultiManager;
  final int? videoSize;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.file(File(widget.url))
        ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager.play(flickManager);
        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          playerLoadingFallback: Positioned.fill(
            child: Stack(
              children: <Widget>[
                if (widget.image != null)
                  Positioned.fill(
                    child: Image.asset(
                      widget.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                const Positioned(
                  right: 10,
                  top: 10,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          controls: FeedPlayerPortraitControls(
            flickMultiManager: widget.flickMultiManager,
            flickManager: flickManager,
            videoSize: widget.videoSize,
          ),
        ),
        // flickVideoWithControlsFullscreen: FlickVideoWithControls(
        //   playerLoadingFallback: Center(
        //       child: Image.network(
        //     widget.image!,
        //     fit: BoxFit.fitWidth,
        //   )),
        //   controls: const FlickLandscapeControls(),
        //   iconThemeData: const IconThemeData(
        //     size: 40,
        //     color: Colors.white,
        //   ),
        //   textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        // ),
      ),
    );
  }
}
