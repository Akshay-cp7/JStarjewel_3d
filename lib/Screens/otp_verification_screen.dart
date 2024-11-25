import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Screens/home_screen.dart' as HomeScreenFile; // Alias the existing HomeScreen

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _sendOTP();
  }

  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true; // Start showing the loading indicator
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreenFile.HomeScreen()), // Navigate to the existing HomeScreen
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false; // Stop showing the loading indicator
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false; // Stop showing the loading indicator
          });
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop showing the loading indicator in case of error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty || _verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator during verification
    });

    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenFile.HomeScreen()), // Navigate to the existing HomeScreen
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Stop showing the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom cream-colored background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFF9E6), // Light cream
                Color(0xFFFFF4D9), // Slightly darker cream
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Makes Scaffold transparent
          appBar: AppBar(
            title: const Text("Verify OTP"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter the OTP sent to ${widget.phoneNumber}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "6-digit OTP",
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _verifyOTP,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.amber.shade700, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ), // Text color
                    ),
                    child: const Text(
                      "VERIFY",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.6), // Dim background
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber), // Amber spinner
              ),
            ),
          ),
      ],
    );
  }
}
