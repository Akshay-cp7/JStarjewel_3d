import 'package:flutter/material.dart';
import 'favorites_manager.dart'; // Import the favorites manager

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFFFDD0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: favoritesList.isEmpty
          ? Center(
              child: Text(
                "No Favorites Yet",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: favoritesList.length,
              itemBuilder: (context, index) {
                final item = favoritesList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item['imagePath']!,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          item['category']!, // Only show category, not the price
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
