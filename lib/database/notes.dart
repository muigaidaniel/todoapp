import '/database/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Items {
  static final Items instance = Items._init();
  static Database? _database;
  Items._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $table(
    ${Fields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Fields.title} TEXT NOT NULL,
    ${Fields.content} TEXT NOT NULL,
    ${Fields.number} INTEGER NOT NULL,
    ${Fields.isDone} INTEGER NOT NULL,
    ${Fields.created} TEXT NOT NULL
    ) ''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;
    final id = await db.insert(table, item.toJson());
    return item.copy(id: id);
  }

  Future<Item> update(Item item) async {
    final db = await instance.database;
    final id = await db.update(
      table,
      item.toJson(),
      where: '${Fields.id} = ?',
      whereArgs: [item.id],
    );
    return item.copy(id: id);
  }

  Future<Item> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(table,
        columns: Fields.values, where: '${Fields.id}= ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Item>> readAll() async {
    final db = await instance.database;
    const orderBy = '${Fields.created} DESC';
    final result = await db.query(table, orderBy: orderBy);
    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '${Fields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
