import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height,
      width: width,
      color: Colors.black.withOpacity(0.4),
      child: const Center(child: CircularProgressIndicator())
    );
  }
}