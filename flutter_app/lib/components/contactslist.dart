import 'package:flutter/material.dart';
import 'package:flutter_app/models/Contacts.dart';
import '../screens/detailwidget.dart';
class ContactsList extends StatelessWidget{

  final List<Contacts> contacts;
  ContactsList({Key key, this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      ListView.builder(
          itemCount: contacts == null ? 0 : contacts.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailWidget(contacts[index])),
                      );
                    },
                    child: ListTile(
                      leading: contacts[index].firstName == 'firstName'? Icon(Icons.contacts): Icon(Icons.contact_phone),
                      title: Text(contacts[index].firstName + " "+contacts[index].lastName),
                      subtitle: Text(contacts[index].contactNumber.toString()),
                    ),
                  )
              );
          });

  }

}