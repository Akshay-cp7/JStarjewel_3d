import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_1/model/order_model.dart';

class OrderDatabaseHelper {
  static final OrderDatabaseHelper _instance = OrderDatabaseHelper._internal();
  static Database? _database;

  factory OrderDatabaseHelper() {
    return _instance;
  }

  OrderDatabaseHelper._internal();

  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'orders.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE orders('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'imagePath TEXT, '
          'title TEXT, '
          'price REAL, '
          'category TEXT, '
          'orderTime TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert an order into the database
  Future<void> insertOrder(Order order) async {
    final db = await database;
    try {
      final id = await db.insert(
        'orders',
        order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore, // Avoid overwriting orders
      );
      print("Order inserted with ID: $id, Data: ${order.toMap()}"); // Debugging log
    } catch (e) {
      print("Failed to insert order: $e");
    }
  }

  // Insert multiple orders into the database
  Future<void> insertMultipleOrders(List<Order> orders) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        for (var order in orders) {
          await txn.insert(
            'orders',
            order.toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      });
      print("All orders inserted successfully.");
    } catch (e) {
      print("Failed to insert multiple orders: $e");
    }
  }

  // Retrieve all orders from the database
  Future<List<Order>> getAllOrders() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('orders');
      print("Fetched ${maps.length} orders from the database."); // Debugging log
      maps.forEach((map) => print(map)); // Print each order
      return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
    } catch (e) {
      print("Failed to fetch orders: $e");
      return [];
    }
  }

  // Retrieve orders based on category (optional, for filtering)
  Future<List<Order>> getOrdersByCategory(String category) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'orders',
        where: 'category = ?',
        whereArgs: [category],
      );
      print("Fetched ${maps.length} orders for category $category."); // Debugging log
      return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
    } catch (e) {
      print("Failed to fetch orders by category: $e");
      return [];
    }
  }

  // Delete all orders (for debugging or reset purposes)
  Future<void> deleteAllOrders() async {
    final db = await database;
    try {
      final count = await db.delete('orders');
      print("Deleted $count orders from the database."); // Debugging log
    } catch (e) {
      print("Failed to delete all orders: $e");
    }
  }

  // Delete a specific order by ID
  Future<void> deleteOrderById(int id) async {
    final db = await database;
    try {
      final count = await db.delete(
        'orders',
        where: 'id = ?',
        whereArgs: [id],
      );
      print("Deleted $count order(s) with ID $id."); // Debugging log
    } catch (e) {
      print("Failed to delete order with ID $id: $e");
    }
  }
}

