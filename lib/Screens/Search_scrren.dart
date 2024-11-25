import 'package:flutter/material.dart';

import 'package:flutter_application_1/Screens/category_screen.dart';
import 'package:flutter_application_1/widgets/JstarLoader.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  void _startSearch() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CategoryScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            if (value.isNotEmpty) _startSearch();
          },
          decoration: InputDecoration(
            hintText: "Search Category",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
      ),
      body: _isLoading ? JstarLoader() : Center(child: Text("Start typing to search")),
    );
  }
}
