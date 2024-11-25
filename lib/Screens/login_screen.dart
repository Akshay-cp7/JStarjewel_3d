import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/otp_verification_screen.dart' ;
import 'package:flutter_application_1/Screens/home_screen.dart' ;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFFFFFDD0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Unfocus keyboard on outside tap
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Adjust for keyboard
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jewellery",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.blueAccent),
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Login Or Signup",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "+91 Mobile Number",
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      text: "By Continuing, I agree to the ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Terms of Use",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        TextSpan(
                          text: " & ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final phoneNumber = '+91' + _phoneNumberController.text.trim();

                        if (phoneNumber.length != 13 || !_phoneNumberController.text.trim().isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please enter a valid 10-digit phone number.")),
                          );
                          return;
                        }

                        try {
                          final userDoc = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(phoneNumber)
                              .get();

                          if (userDoc.exists) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          } else {
                            Navigator.pop(context);
                            Future.delayed(Duration(milliseconds: 200), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerificationScreen(phoneNumber: phoneNumber),
                                ),
                              );
                            });
                          }
                        } catch (e) {
                          print('Error checking user: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error occurred, please try again.")),
                          );
                        }
                      },
                      child: Text("CONTINUE"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when the keyboard appears
      backgroundColor: Color(0xFFFFFDD0),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus keyboard on outside tap
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                    CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
                  ),
                  child: FadeTransition(
                    opacity: _controller,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/Logo/Jstar1.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _controller,
                  child: Text(
                    'Welcome to JStar',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    elevation: 8,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
