import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/medicine.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database?> initializeDb() async {
    String? dbPath = join(await getDatabasesPath(), "medication1.db");
    var medicationDb =
        await openDatabase(dbPath, version: 1, onCreate: dbCreate);
    return medicationDb;
  }
  Future<void> dbCreate(Database db, int version) async {
    await db.execute(
        'Create table medicines(id integer primary key ,name text ,dosage text,dosageType text, hour text, date text,image text)');
  }

  Future<List<Medicine>> getMedicines() async {
    Database? db = await this.db;
    var result = await db?.query("medicines");
    return List.generate(result!.length, (i) {
      return Medicine.fromObject(result[i]);
    });
  }

  Future<int?> insert(Medicine medicine) async {
    Database? db = await this.db;
    var result = await db!.insert("medicines", medicine.toMap());
    return result;
  }

  Future<int?> delete(int id) async {
    Database? db = await this.db;
    var result = await db!.rawDelete("delete from medicines where id = $id");
    return result;
  }

  Future<int?> update(Medicine medicine) async {
    Database? db = await this.db;
    var result = await db!.update(
      "medicines",
      medicine.toMap(),
      where: "id = ?",
      whereArgs: [medicine.id],
    );
    return result;
  }
}
