import 'package:flutter/material.dart';

import '../bee_health/bee_health_screen.dart';

class FlowerGuidanceScreen extends StatelessWidget {
  final String location;

  const FlowerGuidanceScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Flower Guidance')),

      body: Column(
        children: [
          const LinearProgressIndicator(value: 3 / 6),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_florist_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Find flowers for your bees',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'The right flowers provide nectar and pollen that help your bees stay healthy and productive.',
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  Text(
                    'Recommended plants',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const _FlowerCard(
                    icon: Icons.local_florist,
                    name: 'Sunflower',
                    benefit: 'Rich source of nectar and pollen.',
                  ),

                  const _FlowerCard(
                    icon: Icons.local_florist,
                    name: 'Mustard',
                    benefit: 'Provides good pollen during flowering season.',
                  ),

                  const _FlowerCard(
                    icon: Icons.local_florist,
                    name: 'Coconut',
                    benefit: 'Can provide nectar for bees in suitable regions.',
                  ),

                  const _FlowerCard(
                    icon: Icons.local_florist,
                    name: 'Mango',
                    benefit:
                        'Flowering trees can provide seasonal food sources.',
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
                          Icons.lightbulb_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Tip: Try to keep flowering plants available around your apiary throughout different seasons.',
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
                            builder: (_) => BeeHealthScreen(location: location),
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

class _FlowerCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String benefit;

  const _FlowerCard({
    required this.icon,
    required this.name,
    required this.benefit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(benefit),
      ),
    );
  }
}
