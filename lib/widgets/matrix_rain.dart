import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MatrixRain extends StatefulWidget {
  const MatrixRain({super.key});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain> {
  final int columns = 50; // densidade
  final Random random = Random();

  late List<double> drops;
  late List<String> chars;

  @override
  void initState() {
    super.initState();

    drops = List.generate(columns, (_) => random.nextDouble() * 800);

    chars = List.generate(
      columns,
      (_) => String.fromCharCode(0x30A0 + random.nextInt(96)),
    );

    Timer.periodic(const Duration(milliseconds: 90), (_) {
      setState(() {
        for (int i = 0; i < drops.length; i++) {
          drops[i] += 5; // velocidade da queda

          // reset quando sai da tela
          if (drops[i] > 800) {
            drops[i] = random.nextDouble() * -200;
          }

          // troca de letra lenta
          if (random.nextDouble() < 5) {
            chars[i] = String.fromCharCode(0x30A0 + random.nextInt(96));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MatrixPainter(drops, chars),
      size: Size.infinite,
    );
  }
}

// ================= PAINTER =================

class MatrixPainter extends CustomPainter {
  final List<double> drops;
  final List<String> chars;

  MatrixPainter(this.drops, this.chars);

  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    final columnWidth = size.width / drops.length;

    for (int i = 0; i < drops.length; i++) {
      double x = i * columnWidth;
      double y = drops[i];

      // quantidade de rastro
      for (int j = 0; j < 15; j++) {
        double trailY = y - (j * 18);

        if (trailY < 0) continue;

        // intensidade do fade
        double opacity = 1 - (j / 15);

        // cabeça branca
        Color color =
            j == 0
                ? Color.fromARGB((opacity * 255).toInt(), 0, 255, 70)
                : const Color.fromARGB(255, 30, 122, 2);

        textPainter.text = TextSpan(
          text: chars[i],
          style: TextStyle(color: color, fontSize: 16),
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(x, trailY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
