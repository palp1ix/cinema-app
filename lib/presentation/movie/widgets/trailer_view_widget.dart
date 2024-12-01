import 'package:cinema/core/widgets/main_container.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerViewWidget extends StatefulWidget {
  const TrailerViewWidget({super.key, required this.trailerUrl});
  final String trailerUrl;

  @override
  State<TrailerViewWidget> createState() => _TrailerViewWidgetState();
}

class _TrailerViewWidgetState extends State<TrailerViewWidget>
    with WidgetsBindingObserver {
  late YoutubePlayerController _controller;

  Future<void> _initializeVideo() async {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.trailerUrl)!,
      flags: const YoutubePlayerFlags(
          autoPlay: false, mute: false, enableCaption: false),
    );
    _controller.play();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeVideo();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainContainer(
      title: 'Трейлер',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: theme.primaryColor,
          progressColors: ProgressBarColors(
            playedColor: theme.primaryColor,
            handleColor: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
