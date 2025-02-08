

import 'package:cinemapedia/config/domain/entities/video.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


final FutureProviderFamily<List<Video>,int> videosFromMovieProvider= FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getVideosById(movieId);
},);




class VideosFromMovie extends ConsumerWidget {
  const VideosFromMovie({super.key, required this.movieId});
final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosFromMovie = ref.watch(videosFromMovieProvider(movieId));
    return videosFromMovie.when(
      data: (videos)=> _VideoList(videos: videos),
      error: (_, __) => const Center(child: Text('No se encontraron videos'),) ,
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2,),),
      );
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList({ required this.videos});
  final List<Video> videos;
  @override
  Widget build(BuildContext context) {
    if(videos.isEmpty) return const SizedBox();
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Videos',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        _YoutubeVideoPlayer(name:videos.first.name, youtubeKey: videos.first.youtubeKey, ),

      ],
    );
  }
}
class _YoutubeVideoPlayer extends StatefulWidget {
  const _YoutubeVideoPlayer({required this.name, required this.youtubeKey});
  final String name;
  final String youtubeKey;

  @override
  State<_YoutubeVideoPlayer> createState() => __YoutubeVideoPlayerState();
}

class __YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      
      ),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          YoutubePlayer(controller: _controller)
        ],
      ),
      );
  }
}