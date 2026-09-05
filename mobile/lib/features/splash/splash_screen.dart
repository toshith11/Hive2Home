import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const double beeSize = 115;
  static const double beeHorizontalMovement = 125;
  static const double beeVerticalMovement = 70;
  static const double beeExtraMovement = 25;
  static const double beeTilt = 0.12;
  static const int beeAnimationSeconds = 4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: beeAnimationSeconds),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, animation, _) => const LoginScreen(),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 700),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundDecorations(size),
            _honeyDrops(),
            _floatingParticles(),
            _flyingBee(size),
            _centerContent(),
            _bottomDecorations(size),
          ],
        ),
      ),
    );
  }

  Widget _backgroundDecorations(Size size) {
    return Stack(
      children: [
        Positioned(
          top: -25,
          left: -35,
          child: _largeHoneycombCluster(
            rotation: -0.12,
            scale: 0.9,
          ),
        ),
        Positioned(
          top: 85,
          right: -45,
          child: _largeHoneycombCluster(
            rotation: 0.10,
            scale: 0.75,
          ),
        ),
        Positioned(
          bottom: 150,
          left: -55,
          child: _largeHoneycombCluster(
            rotation: 0.08,
            scale: 0.65,
          ),
        ),
        Positioned(
          bottom: 70,
          right: -45,
          child: _largeHoneycombCluster(
            rotation: -0.08,
            scale: 0.85,
          ),
        ),
        Positioned(
          top: size.height * 0.25,
          left: size.width * 0.08,
          child: _smallHoneycomb(),
        ),
        Positioned(
          top: size.height * 0.42,
          right: size.width * 0.05,
          child: _smallHoneycomb(),
        ),
      ],
    );
  }

  Widget _largeHoneycombCluster({
    required double rotation,
    required double scale,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: 0.18,
          child: SizedBox(
            width: 190,
            height: 170,
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  top: 30,
                  child: _hexagon(65),
                ),
                Positioned(
                  left: 62,
                  top: 0,
                  child: _hexagon(65),
                ),
                Positioned(
                  left: 120,
                  top: 30,
                  child: _hexagon(65),
                ),
                Positioned(
                  left: 34,
                  top: 87,
                  child: _hexagon(65),
                ),
                Positioned(
                  left: 92,
                  top: 87,
                  child: _hexagon(65),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _smallHoneycomb() {
    return Opacity(
      opacity: 0.12,
      child: Row(
        children: [
          _hexagon(38),
          const SizedBox(width: 4),
          _hexagon(38),
          const SizedBox(width: 4),
          _hexagon(38),
        ],
      ),
    );
  }

  Widget _hexagon(double size) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        width: size,
        height: size * 1.12,
        decoration: BoxDecoration(
          color: AppTheme.honeyGold,
        ),
      ),
    );
  }

  Widget _honeyDrops() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 52,
          child: _honeyStream(
            width: 12,
            height: 85,
          ),
        ),
        Positioned(
          top: 0,
          left: 78,
          child: _honeyStream(
            width: 7,
            height: 48,
          ),
        ),
        Positioned(
          top: 0,
          right: 58,
          child: _honeyStream(
            width: 11,
            height: 72,
          ),
        ),
        Positioned(
          top: 42,
          left: 112,
          child: _honeyDrop(9),
        ),
        Positioned(
          top: 92,
          right: 105,
          child: _honeyDrop(7),
        ),
        Positioned(
          top: 125,
          left: 30,
          child: _honeyDrop(6),
        ),
      ],
    );
  }

  Widget _honeyStream({
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.honeyGold.withValues(alpha: 0.35),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width),
          bottomRight: Radius.circular(width),
        ),
      ),
    );
  }

  Widget _honeyDrop(double size) {
    return Container(
      width: size,
      height: size * 1.35,
      decoration: BoxDecoration(
        color: AppTheme.honeyGold.withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size),
          topRight: Radius.circular(size),
          bottomLeft: Radius.circular(size * 0.7),
          bottomRight: Radius.circular(size * 0.7),
        ),
      ),
    );
  }

  Widget _floatingParticles() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;

        return Stack(
          children: [
            _particle(
              left: 45,
              top: 220 + math.sin(t * math.pi * 2) * 18,
              size: 5,
            ),
            _particle(
              left: 85,
              top: 310 + math.cos(t * math.pi * 3) * 22,
              size: 3,
            ),
            _particle(
              right: 55,
              top: 270 + math.sin(t * math.pi * 4) * 15,
              size: 4,
            ),
            _particle(
              right: 95,
              top: 380 + math.cos(t * math.pi * 2) * 20,
              size: 5,
            ),
            _particle(
              left: 30,
              top: 470 + math.sin(t * math.pi * 3) * 17,
              size: 3,
            ),
            _particle(
              right: 35,
              top: 520 + math.sin(t * math.pi * 2) * 15,
              size: 4,
            ),
          ],
        );
      },
    );
  }

  Widget _particle({
    double? left,
    double? right,
    required double top,
    required double size,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppTheme.honeyGold.withValues(alpha: 0.55),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.honeyGold.withValues(alpha: 0.25),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _flyingBee(Size size) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;

        final x = size.width * 0.5 +
            math.sin(t * math.pi * 2) *
                beeHorizontalMovement +
            math.sin(t * math.pi * 6) *
                beeExtraMovement;

        final y = size.height * 0.25 +
            math.sin(t * math.pi * 4) *
                beeVerticalMovement +
            math.cos(t * math.pi * 2) *
                30;

        final rotation =
            math.sin(t * math.pi * 4) * beeTilt;

        final scale =
            0.92 + math.sin(t * math.pi * 6) * 0.07;

        return Positioned(
          left: x - beeSize / 2,
          top: y - beeSize / 2,
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(
              scale: scale,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: beeSize * 0.75,
                    height: beeSize * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/cute_bee.png',
                    width: beeSize,
                    height: beeSize,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _centerContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 130,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _animatedLogo(),
            const SizedBox(height: 14),
            _animatedTagline(),
            const SizedBox(height: 32),
            _honeycombLogo(),
            const SizedBox(height: 28),
            _loadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _animatedLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.72 + value * 0.28,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Text(
            'Hive2Home',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: AppTheme.darkBrown,
              letterSpacing: 0.3,
              shadows: [
                Shadow(
                  color: AppTheme.honeyGold.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 58,
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.honeyGold,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedTagline() {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: 1,
      ),
      duration: const Duration(milliseconds: 2200),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Text(
        'From a Healthy Hive to a Trusted Home.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w500,
          color: AppTheme.secondaryBrown,
          letterSpacing: 0.25,
        ),
      ),
    );
  }

  Widget _honeycombLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _miniHexagon(),
        const SizedBox(width: 5),
        _miniHexagon(),
        const SizedBox(width: 5),
        _miniHexagon(),
      ],
    );
  }

  Widget _miniHexagon() {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        width: 25,
        height: 29,
        color: AppTheme.honeyGold.withValues(alpha: 0.7),
        child: Center(
          child: Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppTheme.warmCream,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = Curves.easeInOut.transform(
          _controller.value,
        );

        final percentage = (progress * 100).round();

        return Column(
          children: [
            Container(
              width: 180,
              height: 7,
              decoration: BoxDecoration(
                color: AppTheme.lightHoney,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.cardBorder,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.honeyGold,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.honeyGold
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Preparing your hive... $percentage%',
              style: const TextStyle(
                fontSize: 11.5,
                color: AppTheme.secondaryBrown,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _bottomDecorations(Size size) {
    return Stack(
      children: [
        Positioned(
          left: -10,
          bottom: 8,
          child: _flowerDecoration(),
        ),
        Positioned(
          right: -8,
          bottom: 5,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: _flowerDecoration(),
          ),
        ),
        Positioned(
          left: size.width * 0.40,
          bottom: 12,
          child: _honeyJar(),
        ),
      ],
    );
  }

  Widget _flowerDecoration() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Positioned(
            left: 48,
            top: 35,
            child: Container(
              width: 7,
              height: 78,
              decoration: BoxDecoration(
                color: AppTheme.verifiedGreen.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 58,
            child: Transform.rotate(
              angle: -0.35,
              child: Container(
                width: 42,
                height: 19,
                decoration: BoxDecoration(
                  color: AppTheme.verifiedGreen
                      .withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            left: 65,
            top: 68,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 40,
                height: 18,
                decoration: BoxDecoration(
                  color: AppTheme.verifiedGreen
                      .withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            left: 33,
            top: 15,
            child: _flower(),
          ),
        ],
      ),
    );
  }

  Widget _flower() {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _petal(0, 0),
          _petal(25, 0),
          _petal(12, 25),
          _petal(12, -25),
          _petal(-13, 13),
          _petal(-13, -13),
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: AppTheme.honeyGold,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _petal(double x, double y) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Container(
        width: 21,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppTheme.cardBorder,
          ),
        ),
      ),
    );
  }

  Widget _honeyJar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 45,
          height: 12,
          decoration: BoxDecoration(
            color: AppTheme.darkBrown,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          width: 62,
          height: 60,
          decoration: BoxDecoration(
            color: AppTheme.honeyGold.withValues(alpha: 0.65),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              color: AppTheme.honeyGold,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.honeyGold.withValues(alpha: 0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '🍯',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.75, size.height);
    path.lineTo(size.width * 0.25, size.height);
    path.lineTo(0, size.height * 0.5);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(
    covariant CustomClipper<Path> oldClipper,
  ) {
    return false;
  }
}