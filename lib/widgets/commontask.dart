import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tapp/task_screen.dart';

class commontask extends StatefulWidget {
  final String taskname;
  final String taskdesc;
  final String taskinst;

  final String uid;
  final int index;
  const commontask({
    super.key,
    required this.index,
    required this.uid,
    required this.taskname,
    required this.taskdesc,
    required this.taskinst,
  });

  @override
  State<commontask> createState() => _commontaskState();
}

class _commontaskState extends State<commontask> {
  bool isTaskCompleted = false;
  final formkey = GlobalKey<FormState>();
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> submitTask(
    String userId,
    String tName,
    String tDesc,
    String tInstruction,
  ) async {
    const url = 'http://10.0.2.2:8000/api/submit-task';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['tname'] = tName;
    request.fields['tdesc'] = tDesc;
    request.fields['tinst'] = tInstruction;
    request.fields['user_id'] = userId;

    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _image!.path,
        ),
      );
    }

    try {
      print(request.fields);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);

      if (response.statusCode == 200) {
        print('ye kaam kr rha h kya?');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('task ${widget.index} completed', true);
        print(response.body);
      } else {
        print('Failed to submit task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting task: $e');
    }
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          maxLines: null,
                          initialValue: widget.taskname, //taskData['taskName'],
                          decoration: InputDecoration(labelText: 'Task Name'),
                          readOnly: true,
                        ),
                        TextFormField(
                          initialValue: widget.taskdesc, //taskData['taskName'],
                          decoration:
                              InputDecoration(labelText: 'Task Description'),
                          maxLines: null,
                          readOnly: true,
                        ),
                        TextFormField(
                          initialValue: widget.taskinst, //taskData['taskName'],
                          decoration:
                              InputDecoration(labelText: 'Task Instruction'),
                          readOnly: true,
                          maxLines: null,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _image == null
                                ? Text('No image selected.')
                                : Image.file(File(_image!.path)),
                            ElevatedButton(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              child: Text('Pick Image from Gallery'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            submitTask(
                              widget.uid,
                              widget.taskname,
                              widget.taskdesc,
                              widget.taskinst,
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    textAlign: TextAlign.center,
                                    'Task Submitted',
                                  ),
                                  content: const Text(
                                      textAlign: TextAlign.center,
                                      'You can perform this task again in 24 hours.'),
                                  actions: <Widget>[
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isTaskCompleted = true;
                                          });
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TaskScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
