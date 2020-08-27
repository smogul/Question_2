import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/dbconn.dart';
import '../screens/editdatawidget.dart';
import '../models/Contacts.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.contacts);

  final Contacts contacts;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  DbConnection dbconn = DbConnection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
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
                            Text('First Name:',  style: Theme
                                .of(context)
                                .textTheme
                                .headline6),
                            Text(widget.contacts.firstName, style: Theme
                                .of(context)
                                .textTheme
                                .headline4)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Last Name:',  style: Theme
                                .of(context)
                                .textTheme
                                .headline6),
                            Text(widget.contacts.lastName, style: Theme
                                .of(context)
                                .textTheme
                                .headline4)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Email:',  style: Theme
                                .of(context)
                                .textTheme
                                .headline6),
                            Text(widget.contacts.email, style: Theme
                                .of(context)
                                .textTheme
                                .headline5)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Contact Number:',  style: Theme
                                .of(context)
                                .textTheme
                                .headline6),
                            Text(widget.contacts.contactNumber.toString(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 50, 0, 0),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(

                              splashColor: Colors.red,
                              onPressed: () {
                                _navigateToEditScreen(context, widget.contacts);
                              },
                              child: Text('Make Changes',
                                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                              color: Colors.green,
                            ),
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Remove',
                                  style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold)),
                              color: Colors.redAccent,

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
    );
  }

  _navigateToEditScreen(BuildContext context, Contacts contacts) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(contacts)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wait a minute!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please confirm if you really  want remove this contact.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yep'),
              onPressed: () {
                final initDB = dbconn.initDB();
                initDB.then((db) async {
                  await dbconn.deleteContacts(widget.contacts.id);
                });

                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('Nah'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}