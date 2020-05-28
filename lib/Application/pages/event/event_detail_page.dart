import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:followyourstuff/Domain/Aggregate/EventAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/injection.dart';

class EventPage extends StatefulWidget {

  EventAggregate eventAggregate;

  EventPage(this.eventAggregate);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  EventRepository eventRepository = getIt<EventRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FYS - Event')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.eventAggregate.elementName),
          Text(widget.eventAggregate.propertyName),
          Text(widget.eventAggregate.description),
          Text(widget.eventAggregate.createdAt),
          FlatButton(
            child: Text(
                'Delete',
                style: TextStyle(color: Colors.indigo[500])
            ),
            onPressed: () async {
              await this.eventRepository.deleteEvent(widget.eventAggregate.id);
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}