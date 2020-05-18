import 'package:flutter/material.dart';
import 'package:followyourstuff/models/Thing.dart';
import 'package:followyourstuff/models/Element.dart' as ElementModel;
import 'package:intl/intl.dart';
import 'package:followyourstuff/pages/event/new_event_page.dart';
import 'package:followyourstuff/services/db.dart';


class ElementPage extends StatefulWidget {

  Thing thing;
  ElementModel.Element element;

  ElementPage({Key key, @required this.thing, @required this.element}) : super(key:key);

  @override
  _ElementPageState createState() => _ElementPageState();

}

class _ElementPageState extends State<ElementPage> {

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
//    List<Map<String, dynamic>> _results = await DB.getDB().query(
//        Property.table,
//        where: 'elementId = ?',
//        whereArgs: [widget.element.id]
//    );
//    this.properties = _results.map((item) => Property.fromMap(item)).toList();

    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FYS - ' + widget.thing.name)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitleSection(widget.element, context)
        ],
      ),
    );
  }

  Widget buildTitleSection(ElementModel.Element element, BuildContext context) {
    DateTime createdAt = DateTime.parse(widget.element.createdAt);
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
                      widget.element.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Text(
                      createdAtFormatted,
                      style: TextStyle(color: Colors.grey[500])
                  ),
                ],
              )
          ),
          RaisedButton(
            color: Colors.indigo,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEventForm(widget.element, widget.thing))
              )
            },
            child: Text('Add Event', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


}

