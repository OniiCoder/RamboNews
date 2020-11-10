import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Rambo',
            children: <TextSpan> [
              TextSpan(
                text: 'News'
              ),
            ],
          ),
        ),
      ),
    );
  }
}
