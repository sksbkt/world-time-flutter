import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:world_time/utilities/Event.dart';
import 'package:path/path.dart';
// import 'package:world_time/utilities/Note.dart';

class EventsDatabase {
  static final EventsDatabase instance = EventsDatabase._init();
  static Database? _database;
  EventsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('appointments');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''CREATE TABLE $tableEvents(
    ${EventFields.id} $idType,
    ${EventFields.title} $textType,
    ${EventFields.description} $textType,
    ${EventFields.isAllDay} $boolType,
    ${EventFields.backgroundColor} $textType,
    ${EventFields.from} $textType,
    ${EventFields.to} $textType
    )
    ''');
    print('dbcreated');
    // await db.execute('''CREATE TABLE $tableNotes(
    // ${NoteFields.id}$idType,
    // ${NoteFields.isImportant}$boolType,
    // ${NoteFields.number}$intType,
    // ${NoteFields.title}$textType,
    // ${NoteFields.description}$textType,
    // ${NoteFields.time}$textType,
    //
    // )''');
  }

  Future<Event> create(Event event) async {
    final db = await instance.database;

    /// inserting specific columns values
    // final json = note.toJson();
    //
    // final columns =
    //     '${NoteFields.title},${NoteFields.description},{$NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]},${json[NoteFields.description]},${json[NoteFields.time]}';
    //
    // final id = await db
    //     .rawInsert('INSERT INTO $tableNotes ($columns) VALUES($values)');

    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id: id);
  }

  Future<Event> readEvent(int id) async {
    final db = await instance.database;
    final map = await db.query(tableEvents,
        columns: EventFields.values, where: '${EventFields.id}= ?',

        ///we put values like this in whereArgs instead of the where so we prevent the SQL injections, for more values just put more '?' marks and add the paramater to whereArgs array
        whereArgs: [id]);
    if (map.isNotEmpty)
      return Event.fromJson(map.first);
    else
      throw Exception('ID $id not found');
  }

  Future<Event> readEventWithData(DateTime time) async {
    final db = await instance.database;
    final map = await db.query(tableEvents,
        columns: EventFields.values, where: '${EventFields.id}= ?',

        ///we put values like this in whereArgs instead of the where so we prevent the SQL injections, for more values just put more '?' marks and add the paramater to whereArgs array
        whereArgs: [time.toIso8601String()]);
    if (map.isNotEmpty)
      return Event.fromJson(map.first);
    else
      throw Exception('ID $time not found');
  }

  Future<List<Event>> readAllEvent() async {
    final db = await instance.database;
    final orderByStr = '${EventFields.from} ASC';

    ///if we want to make our custom query via direct query input we can do this
    // final result =
    //     await db.rawQuery('SELECT FROM $tableNotes ORDER BY $orderByStr');

    final result = await db.query(tableEvents, orderBy: orderByStr);
    var res = result.map((e) => Event.fromJson(e)).toList();
    // res.forEach((element) {
    //   print(element.id);
    // });
    return res;
  }

  Future<int> update(Event event) async {
    print(event.toJson());
    final db = await instance.database;
    return await db.update(tableEvents, event.toJson(),
        where: '${EventFields.id} = ?', whereArgs: [event.id]);
  }

  Future<int> delete(int? id) async {
    if (id == null) throw ('id is null');
    final db = await instance.database;
    return await db
        .delete(tableEvents, where: '${EventFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
