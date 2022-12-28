import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.network(
              'https://assets8.lottiefiles.com/packages/lf20_tja8xM0Y9R.json'),
        ),
      ],
    );
  }
}
