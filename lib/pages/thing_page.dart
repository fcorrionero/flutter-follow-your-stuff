import 'package:flutter/material.dart';
import 'package:followyourstuff/models/Thing.dart';

class ThingPage extends StatelessWidget {

  final Thing thing;

  ThingPage({Key key, @required this.thing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
          title: Text('FYS - Thing')
      ),
      body: Center(
        child: Text(thing.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Text(''),
        icon: Icon(Icons.arrow_back),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}