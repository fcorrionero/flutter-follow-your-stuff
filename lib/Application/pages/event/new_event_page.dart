import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/DTO/EventDTO.dart';
import 'package:followyourstuff/Application/DTO/PropertyDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ElementAggregate.dart';
import 'package:followyourstuff/Domain/Aggregate/PropertyAggregate.dart';
import 'package:followyourstuff/Domain/Aggregate/ThingAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Domain/Repositoy/PropertyRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteEventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqlitePropertyRepository.dart';
import 'package:intl/intl.dart';

class NewEventForm extends StatefulWidget {

  ElementAggregate element;
  ThingAggregate thing;

  NewEventForm(ElementAggregate element, ThingAggregate thing) {
    this.element = element;
    this.thing = thing;
  }

  @override
  NewEventFormState createState() {
    return new NewEventFormState();
  }
}

class NewEventFormState extends State<NewEventForm> {
  final _formKey = GlobalKey<FormState>();

  EventRepository repository = SqliteEventRepository();
  PropertyRepository propertyRepository = SqlitePropertyRepository();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<PropertyAggregate> properties = [];
  List<DropdownMenuItem<int>> propertiesList = [];

  int _selectedProperty = 0;

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
    this.properties = await this.propertyRepository.getAllPropertiesByThingId(widget.thing.id);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    this.loadPropertiesList();

    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar (
                title: Text('FYS - New Event')
            ),
            body: Builder(
              builder: (context) =>
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Spacer(),
                              FlatButton(
                                child: Text(
                                    'New event Type',
                                    style: TextStyle(color: Colors.indigo[500])
                                ),
                                onPressed: () => {
                                  _showPropertyFormAlert(context)
                                },
                              )
                            ],
                          ),
                          new DropdownButton(
                            value: _selectedProperty,
                            hint: new Text('Select Event Type'),
                            items: propertiesList,
                            onChanged: (int value) {
                              setState(() {
                                _selectedProperty = value;
                                print('SELECTED : ' + value.toString());
                              });
                            },
                            isExpanded: true,
                          ),
                          TextFormField(
                            maxLines: 2,
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                labelText: 'Description'
                            ),
                          ),
                          DateTimeField(
                            decoration: const InputDecoration(
                                labelText: 'Event date'
                            ),
                            format: DateFormat('dd-MM-yyyy HH:mm'),
                            controller: dateController,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              color: Colors.indigo,
                              onPressed: () => _processForm(context, _selectedProperty, descriptionController.text, dateController.text),
                              child: Text('Submit', style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            )
        )
    );
  }

  void loadPropertiesList() {
    this.propertiesList = [];
    this.propertiesList.add(new DropdownMenuItem(
      child: new Text('Select Event Type', style: TextStyle(color: Colors.grey)),
      value: 0,
    ));
    this.properties.forEach((property) => {
      this.propertiesList.add(new DropdownMenuItem(
        child: new Text(property.name),
        value: property.id,
      ))
    });
  }

  void _showPropertyFormAlert(BuildContext context) {

    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New event type'),
          content: SingleChildScrollView(
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Event Type Name'
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Save"),
              onPressed: () {
                this._insertProperty(_nameController.text,widget.thing.id);
                this.refresh();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  void _insertProperty(String name, int thingId) async {
    DateTime now = new DateTime.now();
    PropertyDTO propertyDTO = PropertyDTO(name, now.toIso8601String(), thingId);
    await this.propertyRepository.insertProperty(propertyDTO);
  }

  void _processForm(BuildContext context, int propertyId, String description, String dateTime) async  {
      EventDTO eventDTO = EventDTO(
        description, dateTime, propertyId,widget.element.id
      );

      this.repository.insertEvent(eventDTO);

      Navigator.pop(context);
  }
}