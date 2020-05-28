import 'package:flutter/material.dart';
import 'package:followyourstuff/Application/DTO/ThingDTO.dart';
import 'package:followyourstuff/Application/pages/theme/colors/light_colors.dart';
import 'package:followyourstuff/Application/pages/widgets/back_button.dart';
import 'package:followyourstuff/Application/pages/widgets/top_container.dart';
import 'package:followyourstuff/Domain/Repositoy/ThingRepository.dart';
import 'package:followyourstuff/injection.dart';

class NewThingForm extends StatefulWidget {
  @override
  NewThingFormState createState() {
    return NewThingFormState();
  }
}

class NewThingFormState extends State<NewThingForm> {
  final _formKey = GlobalKey<FormState>();

  ThingRepository thingRepository = getIt<ThingRepository>();

  final _thingNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var donwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new thing',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _thingNameController,
                            decoration: const InputDecoration(
                                labelText: 'Thing name',
                                labelStyle: TextStyle(color: Colors.black45),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: ButtonTheme(
                              minWidth: double.infinity,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () => _processForm(context),
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white, fontSize: 20)),
                                color: LightColors.kBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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