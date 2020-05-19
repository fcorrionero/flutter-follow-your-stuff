import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/pages/event/new_event_page.dart';
import 'package:followyourstuff/Domain/Aggregate/EventAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteEventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/models/Element.dart' as ElementModel;
import 'package:followyourstuff/Infrastructure/sqlite/models/Thing.dart';
import 'package:intl/intl.dart';


class ElementPage extends StatefulWidget {

  Thing thing;
  ElementModel.Element element;

  ElementPage({Key key, @required this.thing, @required this.element}) : super(key:key);

  @override
  _ElementPageState createState() => _ElementPageState();

}

class _ElementPageState extends State<ElementPage> {

  List<EventAggregate> events = [];

  EventRepository repository = SqliteEventRepository();

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
    this.events = await this.repository.findEventsByElementId(widget.element.id);
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
          buildTitleSection(widget.element, context),
          buildBodySection(context),
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
          DropdownButton(
            value: 'Options',
            style: TextStyle(color: Colors.indigo),
            onChanged: (newValue) {
              switch(newValue) {
                case 'Add Event':
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEventForm(widget.element, widget.thing))
                  );
                  break;
                default:
                  print(newValue);
              }
            },
            items: <String>['Options', 'Add Event','Event Types'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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

              },
              child: Container(

                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(this.events[index].propertyName, style: TextStyle(color: Colors.blue)),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(this.events[index].createdAt, style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(this.events[index].description),
                          )

                        ],
                      )
                    ],
                  )
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: this.events.length
      ),
    );
  }

}
