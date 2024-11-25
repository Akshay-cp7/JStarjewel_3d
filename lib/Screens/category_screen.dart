import 'package:flutter/material.dart';

import 'package:flutter_application_1/Screens/BanglesCatogreyScreen.dart';

import 'package:flutter_application_1/Screens/ChainCategoryScrren.dart';

import 'package:flutter_application_1/Screens/ManglustraCatogeryScreen.dart';
import 'package:flutter_application_1/Screens/RingCategoryScreen.dart';



class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDD0),
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildAnimatedCategoryItem(
            context,
            title: 'Ring',
            imagePath: 'assets/Rings/Image1.jpg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RingCategoryScreen()),
            ),
          ),
          _buildAnimatedCategoryItem(
            context,
            title: 'Mangalsutra',
            imagePath: 'assets/Manglustra/Image4.jpg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>Manglustracatogeryscreen()),
            ),
          ),
          _buildAnimatedCategoryItem(
            context,
            title: 'Chain',
            imagePath: 'assets/Chains/chain1.jpg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chaincategoryscrren()),
            ),
          ),
          _buildAnimatedCategoryItem(
            context,
            title: 'Bangles',
            imagePath: 'assets/Bangles/Bangles1.jpg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Banglescatogreyscreen()),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for each category item with refined left-slide animation
  Widget _buildAnimatedCategoryItem(
    BuildContext context, {
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TweenAnimationBuilder(
        tween: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)),
        duration: Duration(milliseconds: 800), // Longer duration for smoother animation
        curve: Curves.easeInOut, // Smooth curve for a gradual start and end
        builder: (context, Offset offset, child) {
          return Transform.translate(
            offset: offset * MediaQuery.of(context).size.width,
            child: child,
          );
        },
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadowColor: Colors.grey.withOpacity(0.4),
            child: Column(
              children: [
                Hero(
                  tag: title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      imagePath,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.blueGrey.shade600,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
