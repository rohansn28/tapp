import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TaskViewScreen extends StatefulWidget {
  final String taskid;
  final String taskname;
  final String taskdesc;
  final String taskinst;
  final int taskcoin;
  final int taskfrequency;

  final String uid;
  const TaskViewScreen({
    super.key,
    required this.taskname,
    required this.taskdesc,
    required this.taskinst,
    required this.taskcoin,
    required this.taskfrequency,
    required this.taskid,
    required this.uid,
  });

  @override
  State<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  XFile? _image;
  final formkey = GlobalKey<FormState>();
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
    String taskid,
  ) async {
    const url = 'http://10.0.2.2:8000/api/submit-task';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['tname'] = tName;
    request.fields['tdesc'] = tDesc;
    request.fields['tinst'] = tInstruction;
    request.fields['user_id'] = userId;
    request.fields['taskid'] = taskid;

    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _image!.path,
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('task ${widget.taskid} completed', true);

        print(prefs.getBool('task ${widget.taskid} completed'));
      } else {
        print('Failed to submit task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(widget.taskid, style: TextStyle(color: Colors.white)),
              // SizedBox(height: 16),
              // Text(widget.taskname, style: TextStyle(color: Colors.white)),
              // SizedBox(height: 16),
              // Text(widget.taskdesc, style: TextStyle(color: Colors.white)),
              // SizedBox(height: 16),
              // Text(widget.taskinst, style: TextStyle(color: Colors.white)),
              // SizedBox(height: 16),
              // Text(widget.taskcoin.toString(),
              //     style: TextStyle(color: Colors.white)),
              // SizedBox(height: 16),
              // Text(widget.taskfrequency.toString(),
              //     style: TextStyle(color: Colors.white)),

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
                          widget.taskid.toString(),
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
                                      // setState(() {
                                      //   isTaskCompleted = true;
                                      // });
                                      Navigator.pop(context);
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const TaskScreen(),
                                      //   ),
                                      // );
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
      ),
    );
  }
}
