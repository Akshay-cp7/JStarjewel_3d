import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/BuyPage.dart';


class AddressScreen extends StatefulWidget {
  final double itemPrice;
  final double makingCharges;
  final double tax;
  final double totalAmount;
  final String imagePath;
  final String category;

  AddressScreen({
    required this.itemPrice,
    required this.makingCharges,
    required this.tax,
    required this.totalAmount,
    required this.imagePath,
    required this.category,
  });

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String contactInfo = '';
  String phoneNumber = '';
  String address = '';
  String addressType = 'Home';

  void _saveAddress() {
    
      final List<Map<String, dynamic>> products = [
      {
        'imagePath': widget.imagePath,
        'category': widget.category,
        'totalAmount': widget.totalAmount,
      },
      // Add more products here dynamically if selected
    ];

    if (_formKey.currentState!.validate()) {
      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BuyPage(
      contactInfo: contactInfo,
      phoneNumber: phoneNumber,
      address: address,
      itemPrice: widget.itemPrice,
      makingCharges: widget.makingCharges,
      tax: widget.tax,
      totalAmount: widget.totalAmount,
      imagePath: widget.imagePath,
      category:widget.category,
      products: products,

      onOrderPlaced: () {
        // This is where the callback is passed and will be invoked once the order is placed
        setState(() {
          // Trigger a refresh in MyOrdersScreen or wherever it's needed
          
        });
      },
    ),
  ),
);

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        backgroundColor: Color(0xFFFFFDD0), // Light yellow background
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: Color(0xFFFFFDD0), // Same as AppBar color
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Contact Info",
                hintText: "Enter your full name",
                onChanged: (value) => contactInfo = value,
              ),
              _buildTextField(
                label: "Phone Number",
                hintText: "Enter your phone number",
                onChanged: (value) => phoneNumber = value,
              ),
              SizedBox(height: 16),
              Text(
                "Address Info",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _buildTextField(
                label: "Pincode",
                hintText: "Enter your pincode",
                onChanged: (value) => address = value,
              ),
              _buildTextField(
                label: "City",
                hintText: "Enter your city",
              ),
              _buildTextField(
                label: "State",
                hintText: "Enter your state",
              ),
              _buildTextField(
                label: "Locality/Area/Street",
                hintText: "Enter locality details",
              ),
              _buildTextField(
                label: "Flat no./Building Name",
                hintText: "Enter flat/building details",
              ),
              _buildTextField(
                label: "Landmark (optional)",
                hintText: "Enter nearby landmark",
              ),
              SizedBox(height: 16),
              Text(
                "Address Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildRadioOption("Home"),
                  _buildRadioOption("Office"),
                  _buildRadioOption("Other"),
                ],
              ),
              CheckboxListTile(
                title: Text("Make As Default Address"),
                value: false,
                onChanged: (value) {},
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.blueAccent,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Save Address",
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

  Widget _buildTextField({
    required String label,
    required String hintText,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white, // TextField background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: addressType,
          onChanged: (value) {
            setState(() {
              addressType = value!;
            });
          },
        ),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
