import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';

class DomeContainerPainter extends CustomPainter {
  final double domeWidth;
  final BoxShadow? shadow; // Optional shadow using BoxShadow
  final double topVerticalRadius; // Single vertical radius for top corners

  DomeContainerPainter({
    required this.domeWidth,
    this.shadow, // Optional shadow
    this.topVerticalRadius = 25, // Required parameter for top corner radius
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the shadow if provided
    if (shadow != null) {
      final Paint shadowPaint = Paint()
        ..color = shadow?.color ?? Colors.transparent
        ..maskFilter = shadow != null
            ? MaskFilter.blur(BlurStyle.normal, shadow!.blurRadius)
            : null;
      // Initialize the shadow path
      Path shadowPath = Path();

      // Draw the container shape with dome and rounded corners
      shadowPath.reset();
      shadowPath.moveTo(0, (domeWidth * 0.42) + topVerticalRadius);

      // Top left corner
      shadowPath.quadraticBezierTo(
        0,
        (domeWidth * 0.42),
        topVerticalRadius,
        (domeWidth * 0.42),
      );
      shadowPath.lineTo((size.width - domeWidth) / 2, domeWidth * 0.42);

      // The dome
      shadowPath.arcToPoint(
        Offset((size.width + domeWidth) / 2, domeWidth * 0.42),
        radius: Radius.circular(domeWidth * 0.58),
        clockwise: true,
      );

      // Top right corner
      shadowPath.lineTo(size.width - topVerticalRadius, (domeWidth * 0.42));
      shadowPath.quadraticBezierTo(
        size.width,
        (domeWidth * 0.42),
        size.width,
        (domeWidth * 0.42) + topVerticalRadius,
      );

      // Draw the right vertical line
      shadowPath.lineTo(size.width, size.height); // Bottom right corner
      shadowPath.lineTo(0, size.height); // Bottom left corner
      shadowPath.close();

      // Draw the shadow
      canvas.drawPath(shadowPath, shadowPaint);
    }

    final Paint paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Draw the container shape with dome and rounded corners
    path.reset();
    path.moveTo(0, (domeWidth * 0.42) + topVerticalRadius);

    // Top left corner
    path.quadraticBezierTo(
      0,
      (domeWidth * 0.42),
      topVerticalRadius,
      (domeWidth * 0.42),
    );
    path.lineTo((size.width - domeWidth) / 2, domeWidth * 0.42);

    // The dome
    path.arcToPoint(
      Offset((size.width + domeWidth) / 2, domeWidth * 0.42),
      radius: Radius.circular(domeWidth * 0.58),
      clockwise: true,
    );

    // Top right corner
    path.lineTo(size.width - topVerticalRadius, (domeWidth * 0.42));
    path.quadraticBezierTo(
      size.width,
      (domeWidth * 0.42),
      size.width,
      (domeWidth * 0.42) + topVerticalRadius,
    );

    // Draw the right vertical line
    path.lineTo(size.width, size.height); // Bottom right corner
    path.lineTo(0, size.height); // Bottom left corner
    path.close();

    // Draw the container
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
