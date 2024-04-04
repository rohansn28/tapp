import 'package:flutter/material.dart';

class AdMarkBottom extends StatelessWidget {
  const AdMarkBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      right: 20,
      bottom: 2,
      child: Text(
        'AD',
        style: TextStyle(color: Colors.white, fontSize: 6.0),
      ),
    );
  }
}
