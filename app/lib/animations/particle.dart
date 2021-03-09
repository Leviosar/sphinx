import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Particle {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;

  Particle() {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * Random().nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * Random().nextDouble(), -0.2);
    final duration = Duration(milliseconds: 2000 + Random().nextInt(6000));

    tween = MultiTrackTween([
      Track("x").add(
        duration, Tween(begin: startPosition.dx, end: endPosition.dx),
        curve: Curves.easeInOutSine
      ),
      Track("y").add(
        duration, Tween(begin: startPosition.dy, end: endPosition.dy),
        curve: Curves.easeIn
      ),
    ]);

    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + Random().nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<Particle> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    particles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position = Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  Particles(this.numberOfParticles);

  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<Particle> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(Particle());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      builder: (context, time) {
        _simulateParticles(time);
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}