import 'package:flutter/material.dart';

class BubblyCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height * 0.2) // Starting point
      // Define the bubbly shape here
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.2, size.width, size.height * 0.2) // Example curve
      ..lineTo(size.width, size.height * 0.8)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.8, 0, size.height * 0.8)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BubblyCard extends StatelessWidget {

  const BubblyCard({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblyCardPainter(),
      child: Container(
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
