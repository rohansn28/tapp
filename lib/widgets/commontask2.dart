import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapp/widgets/commonadmarkbottom.dart';

class CommonTask2 extends StatefulWidget {
  final String btnText;
  final String stayTime;
  final String winCoin;
  final String url;
  final int index;

  const CommonTask2({
    super.key,
    required this.btnText,
    required this.stayTime,
    required this.winCoin,
    required this.url,
    required this.index,
  });

  @override
  State<CommonTask2> createState() => _CommonTask2State();
}

class _CommonTask2State extends State<CommonTask2> {
  late SharedPreferences _prefs;
  late DateTime _lastCompletion;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();

    _lastCompletion = DateTime.fromMillisecondsSinceEpoch(_prefs.getInt(
            'lastCompletion ${widget.btnText + widget.index.toString()}') ??
        0);
  }

  bool _canPerformTask() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(_lastCompletion);

    return difference.inHours >= 24;
  }

  void _performTask() {
    if (_canPerformTask()) {
      Navigator.pushNamed(context, '/tracking', arguments: {
        "link": widget.url,
        "coin": widget.winCoin,
        "seconds": widget.stayTime,
        "type": "task",
        "id": widget.index.toString(),
        "taskname":
            'lastCompletion ${widget.btnText + widget.index.toString()}',
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Task Locked',
              textAlign: TextAlign.center,
            ),
            content: const Text(
                textAlign: TextAlign.center,
                'You can perform this task again in 24 hours.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    _performTask();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.green,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        widget.btnText.contains('BONUS')
                            ? widget.btnText
                            : widget.btnText,
                        // btnText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const AdMarkBottom(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.btnText.contains('BONUS')
                  ? 'Complete Bonus task in 2 minutes to win ${widget.winCoin} coins'
                  : "Play game for ${widget.stayTime} Seconds to win ${widget.winCoin} coins",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
