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
    this.things = _results.map((item) => Thing.fromMap(item)).toList();
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
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThingPage(thing: this.things[index]) )
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  child: Center(
                    child: Text(
                        this.things[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                    )
                  )
                )
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: this.things.length),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewThingForm() ),
          ).then((value) {
            this.refresh();
          });
        },
        label: Text('New thing'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}