import 'package:flutter/material.dart';

import 'location/location_screen.dart';

class NewBeekeeperScreen extends StatelessWidget {
  const NewBeekeeperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('New Beekeeper'), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Beekeeper icon
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hive_outlined,
                  size: 65,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Welcome to Beekeeping!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'You are about to begin your beekeeping journey. '
                'We will guide you step by step to help you get started '
                'with confidence.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),

              const SizedBox(height: 32),

              // What the user will learn
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your journey',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _JourneyItem(
                        icon: Icons.location_on_outlined,
                        text: 'Set your location',
                      ),

                      _JourneyItem(
                        icon: Icons.calendar_month_outlined,
                        text: 'Get seasonal guidance',
                      ),

                      _JourneyItem(
                        icon: Icons.local_florist_outlined,
                        text: 'Discover suitable flowers',
                      ),

                      _JourneyItem(
                        icon: Icons.health_and_safety_outlined,
                        text: 'Learn about bee health',
                      ),

                      _JourneyItem(
                        icon: Icons.hive_outlined,
                        text: 'Set up your hive',
                      ),

                      _JourneyItem(
                        icon: Icons.monitor_heart_outlined,
                        text: 'Learn how to monitor your hive',
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Get Started', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small reusable item used in the journey list.
class _JourneyItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _JourneyItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),

          const SizedBox(width: 12),

          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
