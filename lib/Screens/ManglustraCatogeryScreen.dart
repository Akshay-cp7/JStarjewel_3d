import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/AddressScreen.dart';
import 'package:flutter_application_1/widgets/JstarLoader.dart';
import 'enlarged_image_screen.dart';

class Manglustracatogeryscreen extends StatefulWidget {
  @override
  _ManglustracatogreyScrrenState createState() => _ManglustracatogreyScrrenState();
}

class _ManglustracatogreyScrrenState extends State<Manglustracatogeryscreen> {
  bool isLoading = true;

  // Define a constant gold rate for all items
  static const double goldRate = 8000.0; // Gold rate per gram

  // Sample data for rings with unique weights and stone weights
  final List<Map<String, dynamic>> rings = [
    
{

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'long ',

      'totalWeight': 5.145, // Total Weight in grams

      'stoneWeight': 0.500, // Stone Weight in grams

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 4.675,

      'stoneWeight': 0.450,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 4.250,

      'stoneWeight': 0.500,

    },

    {

      'imagePath':'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 5.750,

      'stoneWeight': 0.450,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 8.250,

      'stoneWeight': 0.350,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 5.250,

      'stoneWeight': 0.350,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 4.350,

      'stoneWeight': 0.550,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 9.250,

      'stoneWeight': 0.550,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 7.750,

      'stoneWeight': 0.550,

    },

    {

      'imagePath': 'assets/Manglustra/Image4.jpg',

      'title': 'Male Ring',

      'totalWeight': 6.250,

      'stoneWeight': 0.550,

    },





    // Add more rings as needed
  ];

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manglustra', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Color(0xFFFFFDD0),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      backgroundColor: Color(0xFFFFFDD0),
      body: isLoading
          ? JstarLoader()
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.65,
              ),
              itemCount: rings.length,
              itemBuilder: (context, index) {
                final ring = rings[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnlargedImageScreen(
                          imagePath: ring['imagePath'],
                          title: ring['title'],
                        ),
                      ),
                    );
                  },
                  child: ProductCard(
                    imagePath: ring['imagePath'],
                    title: ring['title'],
                    totalWeight: ring['totalWeight'],
                    stoneWeight: ring['stoneWeight'],
                    goldRate: goldRate,
                  ),
                );
              },
            ),
    );
  }
}

// ProductCard widget with Price breakdown functionality
class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double totalWeight;
  final double stoneWeight;
  final double goldRate;

  ProductCard({
    required this.imagePath,
    required this.title,
    required this.totalWeight,
    required this.stoneWeight,
    required this.goldRate,
  });

  // Function to calculate price details
  Map<String, double> calculatePriceDetails(double totalWeight, double stoneWeight, double goldRate) {
    double netWeight = totalWeight - stoneWeight;
    double itemPrice = goldRate * netWeight;
    double makingCharges = netWeight * 103;
    double tax = (makingCharges + itemPrice) * 0.03;
    double totalAmount = itemPrice + makingCharges + tax;

    return {
      'totalWeight': totalWeight,
      'stoneWeight': stoneWeight,
      'netWeight': netWeight,
      'goldRate': goldRate,
      'itemPrice': itemPrice,
      'makingCharges': makingCharges,
      'tax': tax,
      'totalAmount': totalAmount,
    };
  }

  // Function to show the price breakdown in a bottom sheet
  void _showPriceBreakdown(BuildContext context) {
    Map<String, double> priceDetails = calculatePriceDetails(totalWeight, stoneWeight, goldRate);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Price Breakdown",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              _buildPriceRow("Total Weight", "${priceDetails['totalWeight']!.toStringAsFixed(3)} gm"),
              _buildPriceRow("Stone Weight", "${priceDetails['stoneWeight']!.toStringAsFixed(3)} gm"),
              _buildPriceRow("Net Weight", "${priceDetails['netWeight']!.toStringAsFixed(3)} gm"),
              _buildPriceRow("Gold Rate", "₹${priceDetails['goldRate']!.toStringAsFixed(2)} per gm"),
              _buildPriceRow("Item Price", "₹${priceDetails['itemPrice']!.toStringAsFixed(2)}"),
              _buildPriceRow("Making Charges", "₹${priceDetails['makingCharges']!.toStringAsFixed(2)}"),
              _buildPriceRow("Tax", "₹${priceDetails['tax']!.toStringAsFixed(2)}"),
              Divider(),
              _buildPriceRow(
                "Total Amount",
                "₹${priceDetails['totalAmount']!.toStringAsFixed(2)}",
                isBold: true,
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal after clicking Buy
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddressScreen(
                        itemPrice: priceDetails['itemPrice']!,
                        makingCharges: priceDetails['makingCharges']!,
                        tax: priceDetails['tax']!,
                        totalAmount: priceDetails['totalAmount']!,
                        imagePath:   imagePath,
                        category: "Manglustra",

                      )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: Text("Buy"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method to build a row in the price breakdown
  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnlargedImageScreen(
                      imagePath: imagePath,
                      title: title,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GradientButton(
                  label: 'Try-On',
                  onPressed: () {
                    // Action for Virtual Try-On
                  },
                ),
                _GradientButton(
                  label: 'Price',
                  onPressed: () {
                    _showPriceBreakdown(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

// Custom gradient button widget
class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
