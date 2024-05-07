import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tapp/taskview.dart';

class commontask extends StatefulWidget {
  final String taskname;
  final String taskdesc;
  final String taskinst;
  final int taskcoin;
  final int taskfrequency;

  final String uid;
  final int index;
  const commontask({
    super.key,
    required this.index,
    required this.uid,
    required this.taskname,
    required this.taskdesc,
    required this.taskinst,
    required this.taskcoin,
    required this.taskfrequency,
  });

  @override
  State<commontask> createState() => _commontaskState();
}

class _commontaskState extends State<commontask> {
  bool isTaskCompleted = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return isTaskCompleted
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // height: 110,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // decoration: BoxDecoration(color: Colors.red),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.taskname),
                        SizedBox(
                          height: 16,
                        ),
                        ReadMoreText(
                          widget.taskdesc,
                          trimLength: 50,
                          textAlign: TextAlign.start,
                          isExpandable: false,
                          annotations: [
                            Annotation(
                              regExp: RegExp(
                                r'(?:(?:https?|ftp)://)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
                              ),
                              spanBuilder: ({
                                required String text,
                                TextStyle? textStyle,
                              }) {
                                return TextSpan(
                                  text: text,
                                  style:
                                      (textStyle ?? const TextStyle()).copyWith(
                                    decoration: TextDecoration.underline,
                                    color: Colors.green,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _showMessage(text),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(widget.taskinst),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Coins:${widget.taskcoin.toString()}",
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Task Frequency:${widget.taskfrequency.toString()}",
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        // decoration: BoxDecoration(color: Colors.green),
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset(
                          'assets/images/5676758.png',
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TaskViewScreen(
                              taskname: widget.taskname,
                              taskdesc: widget.taskdesc,
                              taskinst: widget.taskinst,
                              taskcoin: widget.taskcoin,
                              taskfrequency: widget.taskfrequency,
                              taskid: widget.index.toString(),
                              uid: widget.uid,
                            ),
                          ));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.green),
                          foregroundColor:
                              const MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        child: const Text('View'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
