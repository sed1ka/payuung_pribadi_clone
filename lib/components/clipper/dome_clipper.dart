// Custom clipper for the dome shape
import 'package:flutter/material.dart';

class DomeClipper extends CustomClipper<Path> {
  final double domeWidth; // Width of the dome
  final double domeHeight; // Height of the dome

  DomeClipper({required this.domeWidth, required this.domeHeight});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top left of the rectangle
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    // Draw the dome shape
    path.lineTo(size.width, size.height - domeHeight);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - (domeHeight + domeWidth), // Peak of the dome
      0,
      size.height - domeHeight,
    );

    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}