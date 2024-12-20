
import 'package:flutter/material.dart';

import '../../../config/constants/environment.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(Environment.theMovieDbKey)
      ),
    );
  }
}