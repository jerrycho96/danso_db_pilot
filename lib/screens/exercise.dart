import 'package:flutter/material.dart';

class ExerCiseScreen extends StatelessWidget {
  const ExerCiseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exercise'),
      ),
      body: Container(
        child: Center(
          child: Text('연습'),
        ),
      ),
    );
  }
}
