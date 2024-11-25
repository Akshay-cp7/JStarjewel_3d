import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCIhC-LPTXsBNnP3Ki_7mLGQfPO6B8gYkc",
          appId: "1:246762799869:android:8500bc11286a3338a73494",
          messagingSenderId: "246762799869",
          projectId: "jstarjewl"));

  // Initialize Firebase
  try {
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(const MyJewelleryApp());
}

class MyJewelleryApp extends StatelessWidget {
  const MyJewelleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewellery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
