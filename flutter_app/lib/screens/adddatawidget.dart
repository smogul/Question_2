
import 'package:flutter/material.dart';
import 'package:flutter_app/database/dbconn.dart';
import '../models/Contacts.dart';
import '../components/validators.dart';

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  _AddDataWidgetState();

  DbConnection dbConnector = DbConnection();
  final _addFormKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final Validators validators = Validators();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  hintText: 'First Name here...',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please input first name name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'Last Name here...',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please input last name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Email here...',
                                ),
                                validator: (value) {
                                  bool emailValid = validators.validateEmail(value);
                                  if (value.isEmpty) {
                                    return 'Please input email';
                                  }
                                  else if(!emailValid){
                                    return 'Email is invalid';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _contactNumberController,
                                decoration: const InputDecoration(
                                  hintText: 'Contact Number here...',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  bool isContactValid = validators.validateContactNumber(value);
                                  if (value.isEmpty) {
                                    return 'Please input contact number';
                                  }
                                  else if(!isContactValid){
                                    return 'Contact invalid';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();
                                    final initDB = dbConnector.initDB();
                                    initDB.then((db) async {
                                      await dbConnector.insertContacts(Contacts(firstName: _firstNameController.text, lastName: _lastNameController.text, email: _emailController.text, contactNumber: _contactNumberController.text));
                                    });

                                    Navigator.pop(context) ;
                                  }
                                },
                                child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}

