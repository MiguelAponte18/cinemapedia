import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  const MovieRating( { required this.voteAverage,super.key});
 final double voteAverage;
  @override
  Widget build(BuildContext context) {
        final textStyles = Theme.of(context).textTheme;

    return  SizedBox(
            width: 150,
            child: Row(
              children: [
                const Icon(Icons.star_half_outlined, color: Colors.amber),
                const SizedBox(width: 3,),
                Text(voteAverage.toStringAsFixed(1),style:textStyles.bodyMedium!.copyWith(color: Colors.amber) ),
                 
              ],
            ),
          );
  }
}