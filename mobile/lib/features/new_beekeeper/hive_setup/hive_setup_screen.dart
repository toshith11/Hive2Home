import 'package:flutter/material.dart';

import '../../hive_group/hive_group_setup_screen.dart';

class HiveSetupScreen extends StatefulWidget {
  final String location;

  const HiveSetupScreen({super.key, required this.location});

  @override
  State<HiveSetupScreen> createState() => _HiveSetupScreenState();
}

class _HiveSetupScreenState extends State<HiveSetupScreen> {
  String? _selectedHiveType;

  final TextEditingController _hiveCountController = TextEditingController();

  final List<String> _hiveTypes = [
    'Langstroth Hive',
    'Top-Bar Hive',
    'Traditional Hive',
  ];

  void _continue() {
    final hiveCount = int.tryParse(_hiveCountController.text.trim());

    if (_selectedHiveType == null || hiveCount == null || hiveCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a hive type and enter a valid number of hives.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HiveGroupSetupScreen(
          apiaryName: widget.location,
          totalHives: hiveCount,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hiveCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Hive Setup')),
      body: Column(
        children: [
          const LinearProgressIndicator(value: 5 / 6),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.hive_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Set up your hive',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Choose the type and number of hives you plan to keep at your location.',
                    style: theme.textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Hive location',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.primary,
                      ),
                      title: const Text('Apiary Location'),
                      subtitle: Text(widget.location),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Select hive type',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    initialValue: _selectedHiveType,
                    decoration: const InputDecoration(
                      labelText: 'Hive Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.hive_outlined),
                    ),
                    items: _hiveTypes.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedHiveType = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Number of hives',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _hiveCountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter number of hives',
                      hintText: 'Example: 5',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.grid_view_outlined),
                    ),
                  ),

                  const SizedBox(height: 24),

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
                            'Tip: Start with a manageable number of hives so you can learn inspection and maintenance properly.',
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
                      onPressed: _continue,
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
