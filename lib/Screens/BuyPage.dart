import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_application_1/Screens/OrderPlacedScrren.dart';
import 'package:flutter_application_1/model/order_model.dart';
import 'package:flutter_application_1/databas/order_database_helper.dart';

class BuyPage extends StatelessWidget {
  final String contactInfo;
  final String phoneNumber;
  final String address;
  final double itemPrice;
  final double makingCharges;
  final double tax;
  final double totalAmount;
  final String imagePath;
  final String category;
  final List<Map<String, dynamic>> products;
  final VoidCallback onOrderPlaced; // Callback to notify MyOrdersScreen

  const BuyPage({
    super.key,
    required this.contactInfo,
    required this.phoneNumber,
    required this.address,
    required this.itemPrice,
    required this.makingCharges,
    required this.tax,
    required this.totalAmount,
    required this.imagePath,
    required this.category,
    required this.products,
    required this.onOrderPlaced, // Accept the callback
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order'),
        backgroundColor: const Color(0xFFFFFDD0),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFFFFDD0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...products.map((product) {
              return Row(
                children: [
                  Image.asset(
                    imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact: $contactInfo",
                            style: const TextStyle(fontSize: 14)),
                        Text("Phone: $phoneNumber",
                            style: const TextStyle(fontSize: 14)),
                        Text("Address: $address",
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              );
            }),
            const Spacer(),
            const SizedBox(height: 16),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Price Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPriceRow("Item Price", "₹${itemPrice.toStringAsFixed(2)}"),
            _buildPriceRow(
                "Making Charges", "₹${makingCharges.toStringAsFixed(2)}"),
            _buildPriceRow("Tax", "₹${tax.toStringAsFixed(2)}"),
            const Divider(color: Colors.grey),
            _buildPriceRow(
              "Total Amount",
              "₹${totalAmount.toStringAsFixed(2)}",
              isBold: true,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Save order details to SQLite
                  final order = Order(
                    id: 0, // SQLite will auto-increment this
                    imagePath: imagePath,
                    title:
                        "Product Title", // Replace with actual product title if available
                    price: totalAmount,
                    category: category, // Specify the category dynamically
                    orderTime: DateTime.now(),
                  );

                  final dbHelper = OrderDatabaseHelper();
                  await dbHelper.insertOrder(order);
                  print("Order placed successfully: ${order.toMap()}");

                  // Notify MyOrdersScreen to reload orders
                  onOrderPlaced();

                  // Navigate to OrderPlacedScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPlacedScreen(
                        contactInfo: contactInfo,
                        phoneNumber: phoneNumber,
                        address: address,
                        itemPrice: itemPrice,
                        makingCharges: makingCharges,
                        tax: tax,
                        totalAmount: totalAmount,
                        imagePath: imagePath,
                        onOrderPlaced: () {},
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Place Your Order",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
