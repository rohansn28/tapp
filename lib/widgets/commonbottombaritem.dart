import 'package:flutter/material.dart';

class CommonBottomBarItem extends StatelessWidget {
  final double size;
  final String img;
  final String text;
  const CommonBottomBarItem({
    super.key,
    required this.text,
    required this.size,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.fill),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            // SizedBox(
            //   width: 5,
            // ),
            Container(
              width: 15,
              height: 15,
              // color: Colors.black,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: const Center(
                child: Text(
                  '(AD)',
                  style: TextStyle(fontSize: 3, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
