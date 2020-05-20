import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/DTO/ThingDTO.dart';
import 'package:followyourstuff/Domain/Repositoy/ThingRepository.dart';
import 'package:followyourstuff/Infrastructure/sqlite/SqliteThingRepository.dart';

class NewThingForm extends StatefulWidget {
  @override
  NewThingFormState createState() {
    return NewThingFormState();
  }
}

class NewThingFormState extends State<NewThingForm> {
  final _formKey = GlobalKey<FormState>();

  ThingRepository thingRepository = SqliteThingRepository();

  final _thingNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar (
            title: Text('FYS - New Thing')
        ),
        body: Builder(
          builder: (context) =>
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _thingNameController,
                      decoration: const InputDecoration(
                          labelText: 'Thing name'
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
      String thingName = _thingNameController.text;
      DateTime now = new DateTime.now();

      ThingDTO thingDTO = ThingDTO(thingName, now.toIso8601String());
      await this.thingRepository.insertThing(thingDTO);

      Navigator.pop(context);
    }
  }

}