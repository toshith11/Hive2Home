import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundDecorations(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    _brandSection(),
                    const SizedBox(height: 48),
                    _welcomeSection(),
                    const SizedBox(height: 32),
                    _newBeekeeperCard(context),
                    const SizedBox(height: 18),
                    _existingBeekeeperCard(context),
                    const SizedBox(height: 30),
                    _divider(),
                    const SizedBox(height: 25),
                    _trustSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundDecorations() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -35,
            right: -35,
            child: Transform.rotate(
              angle: 0.15,
              child: Opacity(
                opacity: 0.10,
                child: _honeycombCluster(),
              ),
            ),
          ),
          Positioned(
            bottom: -35,
            left: -40,
            child: Transform.rotate(
              angle: -0.12,
              child: Opacity(
                opacity: 0.08,
                child: _honeycombCluster(),
              ),
            ),
          ),
          Positioned(
            top: 255,
            left: -18,
            child: _smallHexagon(),
          ),
          Positioned(
            top: 390,
            right: -12,
            child: _smallHexagon(),
          ),
        ],
      ),
    );
  }

  Widget _honeycombCluster() {
    return SizedBox(
      width: 170,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 25,
            child: _hexagon(58),
          ),
          Positioned(
            left: 52,
            top: 0,
            child: _hexagon(58),
          ),
          Positioned(
            left: 104,
            top: 25,
            child: _hexagon(58),
          ),
          Positioned(
            left: 27,
            top: 76,
            child: _hexagon(58),
          ),
          Positioned(
            left: 79,
            top: 76,
            child: _hexagon(58),
          ),
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
          color: AppTheme.honeyGold.withValues(alpha: 0.55),
        ),
      ),
    );
  }

  Widget _smallHexagon() {
    return ClipPath(
      clipper: HexagonClipper(),
      child: Container(
        width: 38,
        height: 43,
        color: AppTheme.honeyGold.withValues(alpha: 0.12),
      ),
    );
  }

  Widget _brandSection() {
    return Column(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: AppTheme.lightHoney,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.cardBorder,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.darkBrown.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.hexagon,
                  size: 53,
                  color: AppTheme.honeyGold.withValues(alpha: 0.22),
                ),
                const Icon(
                  Icons.eco,
                  size: 30,
                  color: AppTheme.honeyGold,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 17),
        const Text(
          'Hive2Home',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBrown,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 42,
          height: 3,
          decoration: BoxDecoration(
            color: AppTheme.honeyGold,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _welcomeSection() {
    return const Column(
      children: [
        Text(
          'Welcome, Beekeeper',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkBrown,
          ),
        ),
        SizedBox(height: 9),
        Text(
          'Let’s get your hive journey started.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.5,
            color: AppTheme.secondaryBrown,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _newBeekeeperCard(BuildContext context) {
    return _loginOptionCard(
      icon: Icons.add_circle_outline_rounded,
      title: 'I’m a New Beekeeper',
      subtitle: 'Create your account using your phone number',
      buttonText: 'Get Started',
      onTap: () {
        _showComingSoon(context, 'New Beekeeper');
      },
    );
  }

  Widget _existingBeekeeperCard(BuildContext context) {
    return _loginOptionCard(
      icon: Icons.person_outline_rounded,
      title: 'I’m an Existing User',
      subtitle: 'Login with your username and password',
      buttonText: 'Login',
      onTap: () {
        _showComingSoon(context, 'Existing User');
      },
    );
  }

  Widget _loginOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBrown.withValues(alpha: 0.045),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppTheme.honeyGold,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppTheme.secondaryBrown,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 13),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.honeyGold,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          buttonText,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppTheme.cardBorder,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'SECURE ACCESS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppTheme.secondaryBrown,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppTheme.cardBorder,
          ),
        ),
      ],
    );
  }

  Widget _trustSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.verified_user_outlined,
          size: 17,
          color: AppTheme.verifiedGreen.withValues(alpha: 0.85),
        ),
        const SizedBox(width: 7),
        const Text(
          'Your beekeeper account stays protected.',
          style: TextStyle(
            fontSize: 11.5,
            color: AppTheme.secondaryBrown,
          ),
        ),
      ],
    );
  }

  void _showComingSoon(
    BuildContext context,
    String type,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$type flow will be added next.',
        ),
        backgroundColor: AppTheme.darkBrown,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
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