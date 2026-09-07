import 'package:flutter/material.dart';

class MonitoringScreen extends StatelessWidget {
  final String location;
  final String hiveType;
  final String hiveCount;

  const MonitoringScreen({
    super.key,
    required this.location,
    required this.hiveType,
    required this.hiveCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Hive Monitoring')),
      body: Column(
        children: [
          const LinearProgressIndicator(value: 1.0),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.monitor_heart_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Learn to monitor your hive',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Regular monitoring helps you understand your colony and identify problems early.',
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Your Hive Setup',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: theme.colorScheme.primary,
                          ),
                          title: const Text('Location'),
                          subtitle: Text(location),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(
                            Icons.hive_outlined,
                            color: theme.colorScheme.primary,
                          ),
                          title: const Text('Hive Type'),
                          subtitle: Text(hiveType),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Icon(
                            Icons.grid_view_outlined,
                            color: theme.colorScheme.primary,
                          ),
                          title: const Text('Number of Hives'),
                          subtitle: Text(hiveCount),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'What to monitor',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const _MonitoringItem(
                    icon: Icons.groups_outlined,
                    title: 'Bee Activity',
                    description:
                        'Observe the number and activity of bees around the hive.',
                  ),

                  const _MonitoringItem(
                    icon: Icons.grid_3x3_outlined,
                    title: 'Brood Condition',
                    description:
                        'Check brood patterns and look for signs of healthy development.',
                  ),

                  const _MonitoringItem(
                    icon: Icons.restaurant_outlined,
                    title: 'Food Stores',
                    description:
                        'Check whether the colony has enough honey and pollen.',
                  ),

                  const _MonitoringItem(
                    icon: Icons.bug_report_outlined,
                    title: 'Pests & Diseases',
                    description:
                        'Look for mites, pests or unusual signs inside the hive.',
                  ),

                  const _MonitoringItem(
                    icon: Icons.home_work_outlined,
                    title: 'Hive Condition',
                    description:
                        'Check the hive structure and make sure it is protected from weather.',
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
                          Icons.tips_and_updates_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Start with regular visual inspections. As you gain experience, you can use sensors and other monitoring tools.',
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your beekeeper setup is complete!'),
                          ),
                        );
                      },
                      child: const Text('Finish Setup'),
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

class _MonitoringItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _MonitoringItem({
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
        leading: Icon(icon, size: 30, color: theme.colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),
      ),
    );
  }
}
