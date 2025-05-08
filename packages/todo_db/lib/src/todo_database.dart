import 'package:path/path.dart';
import 'package:todo_db/todo_db.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase extends TodoDb {
  TodoDatabase._();
  static final TodoDatabase _instance = TodoDatabase._();

  factory TodoDatabase() => _instance;
  Database? _database;
  Future<Database> get _db async {
    return _database = _database ?? await _init();
  }

  Future<Database> _init() async {
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

  @override
  Future<void> initialize() async {
    await _init();
  }

  @override
  Future<void> insertTask(Map<String, dynamic> task) async {
    Database database = await _db;
    await database.insert(
      'TASK',
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> loadPendingTask() async {
    Database database = await _db;
    return await database.query(
      'TASK',
      where: 'ISCOMPLETED = ?',
      whereArgs: [0],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> loadCompletedTask() async {
    Database database = await _db;
    try {
      return await database.query(
        'TASK',
        where: 'ISCOMPLETED = ?',
        whereArgs: [1],
      );
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> deleteTask(Map<String, dynamic> task) async {
    Database database = await _db;
    await database.delete('TASK', where: 'id = ?', whereArgs: [task['ID']]);
  }

  Future<void> truncateTable() async {
    Database database = await _db;
    await database.execute('Drop table TASK');
  }

  @override
  Future<void> updateTask(Map<String, dynamic> task) async {
    Database database = await _db;
    final val = await database.update(
      'TASK',
      task,
      where: 'id = ?',
      whereArgs: [task['ID']],
    );
    print(val);
  }

  // Future<List<Task>> get tasks async {
  //   Database database = await db;
  //   List<Map<String, Object?>> list = await database.query('TASK');
  //   return [for (final map in list) Task.fromMap(map)];
  // }

  // Future<void> deleteTable() async {
  //   Database database = await db;
  //   database.delete('TASK');
  // }
}
