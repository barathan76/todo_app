import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task.dart';

class TodoDb {
  TodoDb._();
  static final TodoDb _instance = TodoDb._();

  factory TodoDb() => _instance;
  Database? _database;
  Future<Database> get db async {
    return _database = _database ?? await init();
  }

  Future<Database> init() async {
    return await openDatabase(
      join(await getDatabasesPath(), "todo.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE TASK(ID TEXT PRIMARY KEY,TITLE TEXT NOT NULL,DUEDATE TEXT NOT NULL,IMPORTANT INTEGER NOT NULL,ISCOMPLETED INTEGER NOT NULL,DESC TEXT NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task todo) async {
    Database database = await db;
    await database.insert(
      'TASK',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(Task todo) async {
    Database database = await db;
    await database.delete('TASK', where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> truncateTable() async {
    Database database = await db;
    await database.execute('Drop table TASK');
  }

  Future<void> updateTask(Task todo) async {
    Database database = await db;
    await database.update(
      'TASK',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Task>> get tasks async {
    Database database = await db;
    List<Map<String, Object?>> list = await database.query('TASK');
    return [for (final map in list) Task.fromMap(map)];
  }

  Future<void> deleteTable() async {
    Database database = await db;
    database.delete('TASK');
  }
}
