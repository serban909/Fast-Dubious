import 'package:flutter/material.dart';

class MoustacheLogo extends StatelessWidget {
  const MoustacheLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF5865F2),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: CustomPaint(
        size: Size(size * 0.7, size * 0.4),
        painter: _MoustachePainter(
          color: Colors.white,
          strokeWidth: size * 0.04,
        ),
      ),
    );
  }
}

class _MoustachePainter extends CustomPainter {
  _MoustachePainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final left = Path()
      ..moveTo(centerX, centerY)
      ..quadraticBezierTo(centerX - size.width * 0.2, centerY - size.height * 0.9, 0, centerY)
      ..quadraticBezierTo(size.width * 0.22, size.height * 1.15, centerX, size.height)
      ..close();

    final right = Path()
      ..moveTo(centerX, centerY)
      ..quadraticBezierTo(centerX + size.width * 0.2, centerY - size.height * 0.9, size.width, centerY)
      ..quadraticBezierTo(size.width * 0.78, size.height * 1.15, centerX, size.height)
      ..close();

    canvas.drawPath(left, paint);
    canvas.drawPath(right, paint);

    final accentPaint = Paint()
      ..color = color.withOpacity(0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final accentPath = Path()
      ..moveTo(centerX - size.width * 0.28, centerY * 1.05)
      ..quadraticBezierTo(centerX, centerY * 0.55, centerX + size.width * 0.28, centerY * 1.05);

    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}