import 'package:flutter/material.dart';

import '../../../config/domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subTitle, this.loadNextPage,});
 final List<Movie> movies;
 final String? title;
 final String? subTitle;
 final VoidCallback? loadNextPage;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}