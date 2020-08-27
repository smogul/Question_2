import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/Contacts.dart';

class DbConnection{
  Database database;

  //initialize the database
  Future initDB() async{
    if(database != null){
      return database;
    }

    //now we create the database
    String dbPath = await getDatabasesPath();
    String sqlTableQuery = "CREATE TABLE Contacts(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, contactNumber TEXT)";
    database = await openDatabase(
      join(dbPath,'contact.db'),
      onCreate: (db,version){
        return db.execute((sqlTableQuery));
      }, version: 1
    );
    return database;
  }

  //the insert function
  Future<Contacts> insertContacts(Contacts contacts) async {
    final Database db =  database;

    await db.insert(
      'contacts',
      contacts.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Get list of Contacts
  Future<List<Contacts>> getAllContacts() async {
    final Database db =  database;

    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return Contacts(
        id: maps[i]['id'],
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
        email: maps[i]['email'],
        contactNumber: maps[i]['contactNumber'],
      );
    });
  }

  //update function
  Future<void> updateContacts(Contacts contacts) async {
    final db =  database;

    await db.update(
      'contacts',
      contacts.toMap(),
      where: "id = ?",
      whereArgs: [contacts.id],
    );
  }

  //delete function
  Future<void> deleteContacts(int id) async {
    final db =  database;

    await db.delete(
      'contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}