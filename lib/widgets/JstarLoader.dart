
import 'package:flutter/material.dart';

class JstarLoader extends StatefulWidget {
  @override
  _JstarLoaderState createState() => _JstarLoaderState();
}

class _JstarLoaderState extends State<JstarLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 1), vsync: this)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.1415926,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Color(0xFFFFFDD0), width: 2)),
              child: ClipOval(
                child: Image.asset('assets/Logo/Jstar1.jpg', fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }
}
