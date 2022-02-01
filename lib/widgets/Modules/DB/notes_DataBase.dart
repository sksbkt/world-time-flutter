import 'package:sqflite/sqflite.dart';
import 'package:world_time/utilities/Note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes');
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

    await db.execute('''CREATE TABLE $tableNotes(
    ${NoteFields.id}$idType,
    ${NoteFields.isImportant}$boolType,
    ${NoteFields.number}$intType,
    ${NoteFields.title}$textType,
    ${NoteFields.description}$textType,
    ${NoteFields.time}$textType,
    
    )''');
  }

  Future<Note> create(Note note) async {
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

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final map = await db.query(tableNotes,
        columns: NoteFields.values, where: '${NoteFields.id}= ?',

        ///we put values like this in whereArgs instead of the where so we prevent the SQL injections, for more values just put more '?' marks and add the paramater to whereArgs array
        whereArgs: [id]);
    if (map.isNotEmpty)
      return Note.fromJsom(map.first);
    else
      throw Exception('ID $id not found');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
