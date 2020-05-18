import 'package:flutter/material.dart';
import 'package:followyourstuff/models/Element.dart' as ElementModel;
import 'package:followyourstuff/models/Thing.dart';
import 'package:followyourstuff/services/db.dart';

class NewElementForm extends StatefulWidget {

  Thing thing;

  NewElementForm(Thing thing) {
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
      ElementModel.Element model = new ElementModel.Element(id: null, name:elementName, createdAt: now.toIso8601String(), thingId: widget.thing.id);
      await DB.insert(model);
      print(_formKey.currentState);
      Navigator.pop(context);
    }
  }
}