import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'phone_number_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _openNewBeekeeperFlow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PhoneNumberScreen(),
      ),
    );
  }

  void _showExistingUserMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Existing user login will be connected next.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      body: SafeArea(
        child: Stack(
          children: [
            _backgroundDecorations(),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                children: [
                  _header(),
                  const SizedBox(height: 42),
                  _welcomeSection(),
                  const SizedBox(height: 34),
                  _newBeekeeperCard(context),
                  const SizedBox(height: 18),
                  _existingUserCard(context),
                  const SizedBox(height: 30),
                  _secureAccess(),
                  const SizedBox(height: 28),
                  _footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundDecorations() {
    return Stack(
      children: [
        Positioned(
          top: -45,
          left: -55,
          child: Opacity(
            opacity: 0.12,
            child: _honeycombCluster(),
          ),
        ),
        Positioned(
          top: 170,
          right: -65,
          child: Opacity(
            opacity: 0.09,
            child: Transform.rotate(
              angle: 0.15,
              child: _honeycombCluster(),
            ),
          ),
        ),
        Positioned(
          bottom: -35,
          left: -45,
          child: Opacity(
            opacity: 0.08,
            child: Transform.rotate(
              angle: -0.12,
              child: _honeycombCluster(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _honeycombCluster() {
    return SizedBox(
      width: 180,
      height: 160,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            top: 28,
            child: _hexagon(60),
          ),
          Positioned(
            left: 58,
            top: 0,
            child: _hexagon(60),
          ),
          Positioned(
            left: 112,
            top: 28,
            child: _hexagon(60),
          ),
          Positioned(
            left: 32,
            top: 80,
            child: _hexagon(60),
          ),
          Positioned(
            left: 86,
            top: 80,
            child: _hexagon(60),
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
        color: AppTheme.honeyGold,
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.lightHoney,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.cardBorder,
            ),
          ),
          child: const Center(
            child: Text(
              '🐝',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Hive2Home',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBrown,
          ),
        ),
      ],
    );
  }

  Widget _welcomeSection() {
    return Column(
      children: [
        const Text(
          'Welcome, Beekeeper',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBrown,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Choose how you want to continue',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: AppTheme.secondaryBrown,
          ),
        ),
      ],
    );
  }

  Widget _newBeekeeperCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _iconContainer(Icons.eco_outlined),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'I’m a New Beekeeper',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Create your beekeeper account using your phone number.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppTheme.secondaryBrown,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _openNewBeekeeperFlow(context),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _existingUserCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _iconContainer(Icons.person_outline),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'I’m an Existing User',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Login with your username and password to access your account.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppTheme.secondaryBrown,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showExistingUserMessage(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.darkBrown,
                  side: const BorderSide(
                    color: AppTheme.cardBorder,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconContainer(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.lightHoney,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: AppTheme.honeyGold,
        size: 25,
      ),
    );
  }

  Widget _secureAccess() {
    return Column(
      children: [
        Row(
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
        ),
        const SizedBox(height: 14),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 16,
              color: AppTheme.verifiedGreen,
            ),
            SizedBox(width: 7),
            Flexible(
              child: Text(
                'Your account and beekeeper data are protected.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryBrown,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _footer() {
    return const Text(
      'From a Healthy Hive to a Trusted Home.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: AppTheme.secondaryBrown,
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