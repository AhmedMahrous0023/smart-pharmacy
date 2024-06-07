import 'package:sqflite/sqflite.dart';
import 'package:smart_pharmacy/Models/medicine_model.dart';

class CartHelper {
  // Database name and table name
  static const String _databaseName = "cart.db";
  static const String _tableName = "cart_items";

  // Database opening method
  Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$_databaseName';
    return await openDatabase(path, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price DOUBLE NOT NULL,
          image TEXT,
          couponDiscount DOUBLE NOT NULL,
          shipping DOUBLE NOT NULL,
          haveDiscount INTEGER NOT NULL,
          quantity DOUBLE NOT NULL
        )
      ''');
    }, version: 1);
  }

  // Saving Cart Items
  Future<void> insertCartItem(MedicineModel medicineModel) async {
    final db = await _getDatabase();
    await db.insert(_tableName, medicineModel.toMap());

  }

  // Loading Cart Items **(Improved with null safety and error handling)**
 Future<List<MedicineModel>> getCartItems() async {
  final db = await _getDatabase();
  try {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
   
    if (maps == null) {
      return []; // Return an empty list if query result is null
    }
    return List.generate(maps.length, (i) => MedicineModel.fromMap(maps[i]));
  } catch (error) {
    // Handle potential errors during query or mapping
    print('Error getting cart items: $error');
    return []; // Return an empty list in case of errors (optional, adjust as needed)
  }
}

  // Updating Cart Items
  Future<void> updateCartItemQuantity(int id, int newQuantity) async {
    final db = await _getDatabase();
    await db.update(
      _tableName,
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Removing Cart Items
  Future<void> deleteCartItem(int id) async {
    final db = await _getDatabase();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}