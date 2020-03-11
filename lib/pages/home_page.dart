import 'package:flutter/material.dart';
import 'package:followyourstuff/pages/thing_page.dart';
import 'package:followyourstuff/pages/new_thing_page.dart';
import 'package:followyourstuff/models/Thing.dart';
import 'package:followyourstuff/services/db.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Thing> things = [];

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {

    List<Map<String, dynamic>> _results = await DB.query(Thing.table);
    things = _results.map((item) => Thing.fromMap(item)).toList();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Follow Your Stuff'),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              for (var item in things)
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ThingPage(thing: item) )
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(item.name)
                          )
                        ],
                      ),
                    )
                )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewThingForm() ),
          ).then((value) {
            refresh();
          });
        },
        label: Text('New thing'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}