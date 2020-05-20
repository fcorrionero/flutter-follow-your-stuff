import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/DTO/ElementDTO.dart';
import 'package:followyourstuff/Domain/Aggregate/ThingAggregate.dart';
import 'package:followyourstuff/Domain/Repositoy/ElementRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteElementRepository.dart';

class NewElementForm extends StatefulWidget {

  ThingAggregate thing;

  NewElementForm(ThingAggregate thing) {
    this.thing = thing;
  }

  @override
  NewElementFormState createState() {
    return new NewElementFormState();
  }
}

class NewElementFormState extends State<NewElementForm> {
  final _formKey = GlobalKey<FormState>();

  final _elementNameController = TextEditingController();

  ElementRepository elementRepository = SqliteElementRepository();

  createState() {

  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar (
                title: Text('FYS - New Element for ' + widget.thing.name)
            ),
            body: Builder(
              builder: (context) =>
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _elementNameController,
                          decoration: const InputDecoration(
                            labelText: 'Element Name'
                          ),
                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            color: Colors.indigo,
                            onPressed: () => _processForm(context),
                            child: Text('Submit', style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
            )
        )
    );
  }

  _processForm(BuildContext context) async  {
    if(_formKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      String elementName = _elementNameController.text;
      DateTime now = new DateTime.now();

      ElementDTO elementDTO = ElementDTO(elementName,now.toIso8601String(),widget.thing.id);
      this.elementRepository.insertElement(elementDTO);

      Navigator.pop(context);
    }
  }
}