import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/BanglesCatogreyScreen.dart';
import 'package:flutter_application_1/Screens/ChainCategoryScrren.dart';
import 'package:flutter_application_1/Screens/ManglustraCatogeryScreen.dart';
import 'package:flutter_application_1/Screens/RingCategoryScreen.dart';
import 'package:flutter_application_1/model/order_model.dart';
import 'package:flutter_application_1/databas/order_database_helper.dart';
import 'package:intl/intl.dart'; // For date formatting

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  // Declare _orderList properly
  late Future<List<Order>> _orderList;

  @override
  void initState() {
    super.initState();
    _loadOrders(); // Load orders when the screen initializes
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadOrders(); // Refresh orders when returning to this screen
  }

  // Method to load orders from the database
  void _loadOrders() {
    setState(() {
      _orderList = OrderDatabaseHelper().getAllOrders();
    });

    // Debugging logs to verify the fetched orders
    _orderList.then((orders) {
      print("Fetched orders: ${orders.length}");
      orders.forEach((order) => print(order.toMap()));
    }).catchError((error) {
      print("Error fetching orders: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        backgroundColor: Color(0xFFFFFDD0),
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: Color(0xFFFFFDD0),
      body: FutureBuilder<List<Order>>(
        future: _orderList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to load orders. Please try again."),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No orders placed yet."),
            );
          } else {
            final orders = snapshot.data!;
            print("Rendering ${orders.length} orders"); // Debugging log
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  leading: Image.asset(
                    order.imagePath,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(order.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price: ₹${order.price.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Ordered on: ${DateFormat('dd MMM yyyy, hh:mm a').format(order.orderTime)}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Text("Waiting Time: 8 days"),
                  onTap: () {
                    _navigateToCategoryScreen(context, order.category);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  // Navigate to the appropriate category screen based on the order's category
  void _navigateToCategoryScreen(BuildContext context, String category) {
    if (category == "Ring") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RingCategoryScreen(),
        ),
      );
    } else if (category == "Bangles") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Banglescatogreyscreen(),
        ),
      );
    } else if (category == "Mangalsutra") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Manglustracatogeryscreen(),
        ),
      );
    } else if (category == "Chains") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Chaincategoryscrren(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No category screen available for $category")),
      );
    }
  }
}

