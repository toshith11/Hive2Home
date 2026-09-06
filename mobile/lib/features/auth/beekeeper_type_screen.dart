import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../apiary/apiary_screen.dart';

class BeekeeperTypeScreen extends StatelessWidget {
  const BeekeeperTypeScreen({super.key});

  void _selectType(BuildContext context, bool isExisting) {
  if (isExisting) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ApiaryScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Beginner guidance journey will be connected next.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: AppTheme.warmCream,
        foregroundColor: AppTheme.darkBrown,
        elevation: 0,
        title: const Text(
          'Your Beekeeping Journey',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 88,
                  height: 88,
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
                      style: TextStyle(fontSize: 44),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Tell us about your beekeeping experience',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This helps us personalize your Hive2Home '
                'experience and show you the right tools and guidance.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: AppTheme.secondaryBrown,
                ),
              ),
              const SizedBox(height: 30),
              _journeyCard(
                context: context,
                icon: Icons.hive_outlined,
                title: "I'm already producing honey",
                description:
                    'Manage your apiaries, hives, production, '
                    'batches and quality verification.',
                buttonText: 'Continue as Existing Beekeeper',
                onTap: () => _selectType(context, true),
              ),
              const SizedBox(height: 18),
              _journeyCard(
                context: context,
                icon: Icons.eco_outlined,
                title: "I'm new to beekeeping",
                description:
                    'Learn about hive setup, seasonal flowers, '
                    'bee health, monitoring and honey production.',
                buttonText: 'Start Beginner Guidance',
                onTap: () => _selectType(context, false),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightHoney,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.auto_awesome_outlined,
                      color: AppTheme.honeyGold,
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You can change or update your beekeeper '
                        'details later from your profile.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Hive2Home • From a Healthy Hive to a Trusted Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _journeyCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppTheme.honeyGold,
              size: 29,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppTheme.darkBrown,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppTheme.secondaryBrown,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}