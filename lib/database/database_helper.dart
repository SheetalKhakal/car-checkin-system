import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'car_check.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carNumber TEXT NOT NULL UNIQUE,
            checkInTime TEXT NOT NULL,
            checkOutTime TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> checkInCar(String carNumber, DateTime checkInTime) async {
    final db = await database;

    final existingCar = await db.query(
      'cars',
      where: 'carNumber = ? AND checkOutTime IS NULL',
      whereArgs: [carNumber],
    );

    if (existingCar.isNotEmpty) {
      throw Exception('Car is already checked in');
    }
    final formattedCheckInTime =
        DateFormat('dd-MM-yyyy HH:mm').format(checkInTime);

    return await db.insert('cars', {
      'carNumber': carNumber,
      'checkInTime': formattedCheckInTime,
      //'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': null,
    });
  }

  Future<List<Map<String, dynamic>>> getUncheckedOutCars() async {
    final db = await database;
    return await db.query(
      'cars',
      where: 'checkOutTime IS NULL',
      orderBy: 'checkInTime ASC',
    );
  }

  Future<int> checkOutCar(String carNumber, DateTime checkOutTime) async {
    final db = await database;
    final formattedCheckOutTime =
        DateFormat('dd-MM-yyyy HH:mm').format(checkOutTime);
    return await db.update(
      'cars',
      {'checkOutTime': formattedCheckOutTime},
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );
  }

  Future<List<Map<String, dynamic>>> getUncheckedOutCarsSorted(
      {bool ascending = true}) async {
    final db = await database;

    final order = ascending ? 'ASC' : 'DESC';
    return await db.query(
      'cars',
      where: 'checkOutTime IS NULL',
      orderBy: 'checkInTime $order',
    );
  }
}
