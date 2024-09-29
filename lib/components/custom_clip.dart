import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';

class CustomClipPath extends StatelessWidget {
  final BoxShadow? boxShadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const CustomClipPath({
    super.key,
    this.boxShadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowPainter(
        clipper: clipper,
        boxShadow: boxShadow ??
            const BoxShadow(
              color: AppColors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -2,
            ),
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowPainter extends CustomPainter {
  final BoxShadow boxShadow;
  final CustomClipper<Path> clipper;

  _ClipShadowPainter({required this.boxShadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = boxShadow.toPaint();
    Path clipPath = clipper.getClip(size).shift(boxShadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
