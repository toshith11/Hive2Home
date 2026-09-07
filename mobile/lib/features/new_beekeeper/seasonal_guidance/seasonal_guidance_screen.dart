import 'package:flutter/material.dart';

import '../flower_guidance/flower_guidance_screen.dart';

class SeasonalGuidanceScreen extends StatelessWidget {
  final String location;

  const SeasonalGuidanceScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Temporary season.
    // Later this can be calculated using the location and current date.
    const currentSeason = 'Monsoon';

    return Scaffold(
      appBar: AppBar(title: const Text('Seasonal Guidance'), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress
              LinearProgressIndicator(
                value: 2 / 6,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 28),

              Text(
                'Seasonal Guidance',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Here are some things to keep in mind '
                'during the current season.',
                style: theme.textTheme.bodyLarge,
              ),

              const SizedBox(height: 24),

              // Location
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Your Location'),
                  subtitle: Text(location),
                ),
              ),

              const SizedBox(height: 12),

              // Current season
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.cloud_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Current Season'),
                  subtitle: Text(currentSeason),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'What you should do',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  children: const [
                    _GuidanceItem(
                      icon: Icons.water_drop_outlined,
                      title: 'Protect the hive from excess moisture',
                      description:
                          'Make sure the hive has proper ventilation '
                          'and is protected from heavy rain.',
                    ),

                    _GuidanceItem(
                      icon: Icons.hive_outlined,
                      title: 'Check the hive regularly',
                      description:
                          'Observe bee activity and make sure the colony '
                          'is behaving normally.',
                    ),

                    _GuidanceItem(
                      icon: Icons.restaurant_outlined,
                      title: 'Check food availability',
                      description:
                          'Make sure the colony has enough food, '
                          'especially when natural forage is limited.',
                    ),

                    _GuidanceItem(
                      icon: Icons.shield_outlined,
                      title: 'Watch for pests and diseases',
                      description:
                          'Look for unusual bee behaviour or visible '
                          'signs of pests around the hive.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FlowerGuidanceScreen(location: location),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Continue', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable guidance item.
class _GuidanceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _GuidanceItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 26),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
