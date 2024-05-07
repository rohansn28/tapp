import 'package:flutter/material.dart';
import 'package:tapp/utils/web.dart';

class NotificationMark extends StatelessWidget {
  const NotificationMark({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newNotifications(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
