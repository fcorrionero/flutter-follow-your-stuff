import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/DTO/EventDTO.dart';
import 'package:followyourstuff/Domain/Repositoy/EventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteEventRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/models/Element.dart' as ElementModel;
import 'package:followyourstuff/Infrastructure/sqlite/models/Thing.dart';
import 'package:followyourstuff/Infrastructure/sqlite/models/Property.dart';
import 'package:followyourstuff/Infrastructure/sqlite/db.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewEventForm extends StatefulWidget {

  ElementModel.Element element;
  Thing thing;

  NewEventForm(ElementModel.Element element, Thing thing) {
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

  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Property> properties = [];
  List<DropdownMenuItem<int>> propertiesList = [];

  int _selectedProperty = 0;

  @override
  void initState() {
    this.refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.getDB().query(
        Property.table,
        where: 'thingId = ?',
        whereArgs: [widget.thing.id]
    );
    this.properties = _results.map((item) => Property.fromMap(item)).toList();

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

  void _insertProperty(String name, int elemntId) async {
    DateTime now = new DateTime.now();
    Property model = new Property(thingId: elemntId,name:name, createdAt: now.toIso8601String());
    await DB.insert(model);
  }

  void _processForm(BuildContext context, int propertyId, String description, String dateTime) async  {
      EventDTO eventDTO = EventDTO(
        description, dateTime, propertyId,widget.element.id
      );

      this.repository.insertEvent(eventDTO);

      Navigator.pop(context);
  }
}