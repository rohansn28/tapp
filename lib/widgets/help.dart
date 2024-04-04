import 'package:flutter/material.dart';

class NeedHelpBox extends StatefulWidget {
  final String route;
  const NeedHelpBox({
    super.key,
    required this.route,
  });

  @override
  State<NeedHelpBox> createState() => _NeedHelpBoxState();
}

class _NeedHelpBoxState extends State<NeedHelpBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, widget.route);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Adjust the value as needed
          ),
          shadowColor: const Color.fromARGB(255, 7, 28, 255),
          elevation: 10.0,
          color: Colors.green,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height * 0.17,
            child: const Center(
                child: Text(
              'NEED HELP?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            )),
          ),
        ),
      ),
    );
  }
}
