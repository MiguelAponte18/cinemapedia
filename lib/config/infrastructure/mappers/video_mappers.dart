import 'package:cinemapedia/config/domain/entities/video.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/video_moviedb.dart';

class VideoMappers {
  static Video videoFromEntity(Result result) => Video(
    id: result.id,
     youtubeKey: result.key,
      name: result.name,
       publishedAt: result.publishedAt,
       );
}