import 'package:flutter/material.dart';
import 'package:followyourstuff/Infrastructure/sqlite/models/Thing.dart';
import 'package:followyourstuff/Infrastructure/sqlite/models/Element.dart' as element;
import 'package:followyourstuff/Application/pages/element/element_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:followyourstuff/Application/pages/element/new_element_page.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';

class ThingPage extends StatefulWidget {

  Thing thing;

  ThingPage({Key key, @required this.thing}) : super(key: key);

  @override
  _ThingPageState createState() => _ThingPageState();

}

class _ThingPageState extends State<ThingPage> {

  List<element.Element> elements = [];

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.getDB().query(
        element.Element.table,
        where: 'thingId = ?',
        whereArgs: [widget.thing.id]
    );
    this.elements = _results.map((item) => element.Element.fromMap(item)).toList();
    setState(() { });
  }

  Widget buildTitleSection(Thing thing, BuildContext context) {
    DateTime createdAt = DateTime.parse(widget.thing.createdAt);
    String createdAtFormatted = new DateFormat.yMMMMd().add_jm().format(createdAt);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      widget.thing.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Text(
                      createdAtFormatted,
                      style: TextStyle(color: Colors.grey[500])
                  )
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget buildBodySection(BuildContext context) {
    return Flexible(
      child: ListView.separated(
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ElementPage(thing: widget.thing, element: this.elements[index]) )
                );
              },
              child: Container(
                  height: 35,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.bookmark_border),
                      Text(this.elements[index].name)
                    ],
                  )
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: this.elements.length
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
          title: Text('FYS - ' + widget.thing.name)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitleSection(widget.thing, context),
          buildBodySection(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewElementForm(widget.thing) ),
          ).then((value) {
            this.refresh();
          });
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}