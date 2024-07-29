import 'package:plumber/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Amith extends StatefulWidget {
  const Amith({super.key});

  @override
  State<Amith> createState() => _AmithState();
}

class _AmithState extends State<Amith> {
  late YoutubePlayerController _controller;
  final videoLink = 'https://youtu.be/6f4Dzt1ROtc';

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoLink);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0, right: 12, left: 12),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage('assets/Amith.jpg'))),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'අමිත් වීරසිංහ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "The Leader of the Mahasohon Balakaya,",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppTheme.colors.primary,
                  bottomActions: [
                    ProgressBar(
                      isExpanded: true,
                      colors: ProgressBarColors(
                          playedColor: AppTheme.colors.primary,
                          handleColor: AppTheme.colors.primary,
                          bufferedColor: Colors.grey[300]),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
