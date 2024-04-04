import 'package:flutter/material.dart';

class CommonMinCoinBar extends StatelessWidget {
  final String text1, text2;
  const CommonMinCoinBar({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.8,
      color: Colors.white,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          '$text1 \n $text2',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
