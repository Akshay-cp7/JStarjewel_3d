import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArRing extends StatelessWidget {
  const ArRing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: const Center(
            child: ModelViewer(
          src: 'assets/glb/ring1.glb',
          ar: true,
        )));
  }
}
