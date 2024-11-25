import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  final String contactInfo;
  final String phoneNumber;
  final String address;
  final double itemPrice;
  final double makingCharges;
  final double tax;
  final double totalAmount;
  final String imagePath;

  final VoidCallback onOrderPlaced;

  OrderPlacedScreen({
    required this.contactInfo,
    required this.phoneNumber,
    required this.address,
    required this.itemPrice,
    required this.makingCharges,
    required this.tax,
    required this.totalAmount,
    required this.imagePath,
    required this.onOrderPlaced,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFFDD0), // Cream background
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Color(0xFFFFFDD0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Order Summary
              Center(
                child: Text(
                  "Order Confirmation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Contact and Address Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Name: $contactInfo",
                            style: TextStyle(fontSize: 14)),
                        Text("Phone: $phoneNumber",
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 8),
                        Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(address, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey),

              // Section 2: Price Details
              SizedBox(height: 20),
              Text(
                "Price Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              _buildPriceRow("Item Price", "₹${itemPrice.toStringAsFixed(2)}"),
              _buildPriceRow(
                  "Making Charges", "₹${makingCharges.toStringAsFixed(2)}"),
              _buildPriceRow("Tax", "₹${tax.toStringAsFixed(2)}"),
              Divider(color: Colors.grey),
              _buildPriceRow(
                "Total Amount",
                "₹${totalAmount.toStringAsFixed(2)}",
                isBold: true,
              ),
              SizedBox(height: 30),

              // Section 3: Confirmation Message
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: Text(
                    "Your order is placed successfully! \n\nIt will be delivered in 8 days.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Back to Home Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to home screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
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
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
