import 'package:news60/components/colors.dart';
// import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  VideoPlayerScreen({required this.url});
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet
    String? videoId = YoutubePlayer.convertUrlToId(widget.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
    progressIndicatorColor: AppColor.youtubeColor,
    progressColors: ProgressBarColors(
        playedColor: AppColor.youtubeColor,
        handleColor: AppColor.background,
    ),
    onReady: () {
        
    },
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),

    ],
      ),
    );
  }
}
