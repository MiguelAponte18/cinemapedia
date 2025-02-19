import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {

  const CustomGradient({super.key, required this.begin, required this.end, required this.stops, required this.colors});

final AlignmentGeometry begin;
final AlignmentGeometry end;
final List<double> stops;
final List<Color> colors;


  @override
  Widget build(BuildContext context) {
    return  SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(            
                  gradient: LinearGradient(
                   
                    begin:begin,
                    end:end,
                    stops: stops,//donde comienza y termina en la pantalla
                    colors: colors
                    )
                )
                ),
            );

  }
}