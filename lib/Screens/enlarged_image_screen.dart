import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/favorites_manager.dart';

class EnlargedImageScreen extends StatefulWidget {
  final String imagePath;
  final String title;

  EnlargedImageScreen({required this.imagePath, required this.title});

  @override
  _EnlargedImageScreenState createState() => _EnlargedImageScreenState();
}

class _EnlargedImageScreenState extends State<EnlargedImageScreen> {
  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Check if the item is already a favorite
    isFavorite = favoritesList.contains(widget.imagePath);

    // Start a 2-second loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void toggleFavorite() {
    final item = {
      'imagePath': widget.imagePath,
      'price': "₹23145",  // You can modify this based on actual item details
      'category': widget.title
    };

    setState(() {
      if (isFavorite) {
        removeFavorite(item); // Remove from favorites
      } else {
        addFavorite(item); // Add to favorites
      }
      isFavorite = !isFavorite; // Toggle the favorite state
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // 2-second loader
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    widget.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 16),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                  onPressed: toggleFavorite,
                ),
                SizedBox(height: 16),
              ],
            ),
    );
  }
}
