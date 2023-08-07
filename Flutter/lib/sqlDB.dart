import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> initializeDatabase() async {
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;

  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  // Create the 'tokens' table if it doesn't exist
  await database.execute(
      '''
    CREATE TABLE IF NOT EXISTS tokens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      token TEXT
    )
  ''');
  await database.execute(
      '''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      userID INTEGER
    )
  ''');

  return database;
}

Future<void> insertToken(String token) async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  await database.insert('tokens', {'token': token});
  await database.close();
}

Future<void> insertUser(String username, int id) async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  await database.insert('users', {'username': username, "userID": id});
  await database.close();
}

Future<dynamic> retrieveUser() async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  List<Map<String, dynamic>> result = await database.query('users');
  if (result.isNotEmpty) {
    return result.first;
  }

  await database.close();
  return null;
}

Future<void> updateUser(String newUserName) async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  await database.update(
    'users',
    {'username': newUserName},
    where: 'id = ?',
    whereArgs: [1],
  );
  await database.close();
}

Future<dynamic> retrieveToken() async {
  String databasePath = await getDatabasesPath();
  String path = join(databasePath, 'myapp.db');
  Database database = await databaseFactory.openDatabase(path);

  List<Map<String, dynamic>> result = await database.query('tokens');
  if (result.isNotEmpty) {
    return result.first['token'];
  }

  await database.close();
  return null;
}

Future<void> deleteAllRows() async {
  final Database database = await openDatabase('myapp.db');

  await database.transaction((txn) async {
    await txn.delete('tokens');
    await txn.delete('users');
  });
  await database.close();
}
