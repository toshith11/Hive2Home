import 'package:flutter/material.dart';

import '../hive_setup/hive_setup_screen.dart';

class BeeHealthScreen extends StatelessWidget {
  final String location;

  const BeeHealthScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Bee Health')),
      body: Column(
        children: [
          const LinearProgressIndicator(value: 4 / 6),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.health_and_safety_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Keep your bees healthy',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'As a new beekeeper, learning to identify common health problems early is very important.',
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  const _HealthCard(
                    icon: Icons.visibility_outlined,
                    title: 'Regular Inspection',
                    description:
                        'Inspect your hive regularly and observe the behaviour of your bees.',
                  ),

                  const _HealthCard(
                    icon: Icons.bug_report_outlined,
                    title: 'Watch for Pests',
                    description:
                        'Look for mites, insects and other pests that may affect the colony.',
                  ),

                  const _HealthCard(
                    icon: Icons.water_drop_outlined,
                    title: 'Provide Clean Water',
                    description:
                        'Make sure bees have access to a clean and reliable water source.',
                  ),

                  const _HealthCard(
                    icon: Icons.restaurant_outlined,
                    title: 'Check Food Supply',
                    description:
                        'Ensure the colony has enough nectar, pollen and stored food.',
                  ),

                  const _HealthCard(
                    icon: Icons.warning_amber_outlined,
                    title: 'Look for Warning Signs',
                    description:
                        'Unusual bee behaviour, dead bees or damaged brood may indicate a problem.',
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Tip: Never ignore unusual changes in your colony. Early observation can help prevent bigger problems.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HiveSetupScreen(location: location),
                          ),
                        );
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _HealthCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(icon, color: theme.colorScheme.primary, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),
      ),
    );
  }
}
