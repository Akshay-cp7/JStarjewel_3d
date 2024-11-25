import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final double totalAmount = 18000.0; // Example total amount, can be dynamic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/JStar_logo.png', // Add your JStar logo here
              height: 40,
            ),
            SizedBox(width: 8),
            Text(
              'Order Confirmation',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Delivery Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              trailing: TextButton(
                onPressed: () {
                  // Navigate to the Add Address screen
                },
                child: Text('Add Address', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
            ),
            Divider(),
            Text("Expected Delivery: 15th Apr", style: TextStyle(fontSize: 16, color: Colors.grey)),
            Divider(),

            // Amount Payable Section
            ListTile(
              title: Text("Amount Payable", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text("₹ 1,179", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue)),
            ),
            Divider(),

            // Payment Methods Section
            Text("Payment Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ExpansionTile(
              title: Text("Credit/Debit Card", style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListTile(
                  title: Text("Add Card", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  onTap: () {
                    // Navigate to Add Card screen
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text("UPI", style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListTile(
                  title: Text("Add UPI", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  onTap: () {
                    // Navigate to UPI screen
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Net Banking", style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListTile(
                  title: Text("Add Bank", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  onTap: () {
                    // Navigate to Net Banking screen
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text("Wallet", style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListTile(
                  title: Text("Add Wallet", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  onTap: () {
                    // Navigate to Wallet screen
                  },
                ),
              ],
            ),
            ListTile(
              title: Text("Cash On Delivery", style: TextStyle(fontSize: 16)),
              trailing: Checkbox(value: false, onChanged: (bool? value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
