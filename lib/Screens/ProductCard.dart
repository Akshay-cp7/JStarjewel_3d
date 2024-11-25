import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/favorites_manager.dart';

class ProductCard extends StatefulWidget {
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

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isItemFavorite = false;

  @override
  void initState() {
    super.initState();
    final item = {
      'imagePath': widget.imagePath,
      'price': "₹23145",
      'category': widget.title,
    };
    isItemFavorite = isFavorite(item);
  }

  void toggleFavorite() {
    final item = {
      'imagePath': widget.imagePath,
      'price': "₹23145",
      'category': widget.title,
    };

    setState(() {
      if (isItemFavorite) {
        removeFavorite(item);
      } else {
        addFavorite(item);
      }
      isItemFavorite = !isItemFavorite;
    });
  }

  void _showPriceBottomSheet(BuildContext context) {
    double netWeight = widget.totalWeight - widget.stoneWeight;
    double itemPrice = widget.goldRate * netWeight;
    double makingCharges = netWeight * 103;
    double tax = (makingCharges + itemPrice) * 0.03;
    double totalAmount = itemPrice + makingCharges + tax;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price Breakdown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text("Gold Rate: ₹${widget.goldRate.toStringAsFixed(2)}"),
              Text("Net Weight: ${netWeight.toStringAsFixed(2)}g"),
              Text("Item Price: ₹${itemPrice.toStringAsFixed(2)}"),
              Text("Making Charges: ₹${makingCharges.toStringAsFixed(2)}"),
              Text("Tax (3%): ₹${tax.toStringAsFixed(2)}"),
              SizedBox(height: 8),
              Text(
                "Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Close', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
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
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CustomPriceButton(
                  label: 'Price',
                  onPressed: () => _showPriceBottomSheet(context),
                ),
                _GradientButton(label: 'Try-On', onPressed: () {}),
              ],
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                isItemFavorite ? Icons.favorite : Icons.favorite_border,
                color: isItemFavorite ? Colors.red : Colors.grey,
                size: 30,
              ),
              onPressed: toggleFavorite,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _CustomPriceButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _CustomPriceButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
