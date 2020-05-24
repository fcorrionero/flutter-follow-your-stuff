import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/pages/event/event_detail_page.dart';
import 'package:followyourstuff/Application/pages/event/new_event_page.dart';
import 'package:followyourstuff/Domain/Aggregate/ElementAggregate.dart';
import 'package:followyourstuff/Domain/Aggregate/EventAggregate.dart';
import 'package:followyourstuff/Domain/Aggregate/PropertyAggregate.dart';
import 'package:followyourstuff/Domain/Aggregate/ThingAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/PropertyRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteEventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqlitePropertyRepository.dart';
import 'package:intl/intl.dart';

class ElementPage extends StatefulWidget {
  ThingAggregate thing;
  ElementAggregate element;

  ElementPage({Key key, @required this.thing, @required this.element})
      : super(key: key);

  @override
  _ElementPageState createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  List<EventAggregate> events = [];
  List<PropertyAggregate> eventTypes = [];

  EventRepository repository = SqliteEventRepository();
  PropertyRepository propertyRepository = SqlitePropertyRepository();

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
    this.events =
        await this.repository.findEventsByElementId(widget.element.id);
    this.eventTypes = await this
        .propertyRepository
        .getAllPropertiesByThingId(widget.thing.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FYS - ' + widget.thing.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitleSection(widget.element, context),
          buildEventTypeMenu(context),
          buildBodySection(context),
        ],
      ),
    );
  }

  Widget buildTitleSection(ElementAggregate element, BuildContext context) {
    DateTime createdAt = DateTime.parse(widget.element.createdAt);
    String createdAtFormatted =
        new DateFormat.yMMMMd().add_jm().format(createdAt);
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Text(createdAtFormatted,
                  style: TextStyle(color: Colors.grey[500])),
            ],
          )),
          DropdownButton(
            value: 'Options',
            style: TextStyle(color: Colors.indigo),
            onChanged: (newValue) {
              switch (newValue) {
                case 'Add Event':
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewEventForm(widget.element, widget.thing)))
                      .then((value) => {
                            setState(() {
                              this.refresh();
                            })
                          });
                  break;
                default:
                  print(newValue);
              }
            },
            items: <String>['Options', 'Add Event', 'Event Types']
                .map<DropdownMenuItem<String>>((String value) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventPage(this.events[index]))).then((value) => {
                      setState(() {
                        this.refresh();
                      })
                    });
              },
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(this.events[index].propertyName,
                          style: TextStyle(color: Colors.blue)),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(this.events[index].createdAt,
                            style: TextStyle(color: Colors.grey)),
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
              )),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: this.events.length),
    );
  }

  Widget buildEventTypeMenu(BuildContext contex) {
    return Container(
      height: 20,
      child: ListView.builder(
        // This next line does the trick.
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            child: Text(this.eventTypes[index].name),
            onPressed: () => {},
          );
        },
        itemCount: this.eventTypes.length,
      ),
    );
  }
}
