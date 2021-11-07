import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:swing_share/config/config.dart';
import 'package:swing_share/presentation/common/widget/send_button.dart';
import 'package:swing_share/util/color.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimmerView extends StatefulWidget {
  const TrimmerView(this.file, {Key? key}) : super(key: key);
  final File file;

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    final value = await _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
    );

    setState(() {
      _progressVisibility = false;
      _value = value;
    });

    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColor.dark,
        appBar: AppBar(
          backgroundColor: AppColor.dark!.withOpacity(0.2),
          toolbarHeight: 44,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: SendButton(
                  label: '切り取る',
                  disabled: _progressVisibility,
                  onTap: () async {
                    if (_endValue - _startValue >
                        Config.postableSeconds * 1000) {
                      showOkAlertDialog(
                          context: context,
                          title: '${Config.postableSeconds}秒以内にしてください');
                      return;
                    }

                    final outputPath = await _saveVideo();
                    debugPrint('OUTPUT PATH: $outputPath');
                    Navigator.of(context).pop(outputPath);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (context) => Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Visibility(
                    visible: _progressVisibility,
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  Expanded(child: VideoViewer(trimmer: _trimmer)),
                  Center(
                    child: TrimEditor(
                      trimmer: _trimmer,
                      viewerHeight: 50.0,
                      viewerWidth: MediaQuery.of(context).size.width,
                      // maxVideoLength: const Duration(seconds: 10),
                      onChangeStart: (value) {
                        _startValue = value;
                      },
                      onChangeEnd: (value) {
                        _endValue = value;
                      },
                      onChangePlaybackState: (value) {
                        setState(() {
                          _isPlaying = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    child: _isPlaying
                        ? const Icon(
                            Icons.pause,
                            size: 40,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          ),
                    onPressed: () async {
                      bool playbackState = await _trimmer.videPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
