import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../hive/hive_screen.dart';

class HiveGroupSetupScreen extends StatefulWidget {
  final String apiaryName;
  final int totalHives;

  const HiveGroupSetupScreen({
    super.key,
    required this.apiaryName,
    required this.totalHives,
  });

  @override
  State<HiveGroupSetupScreen> createState() => _HiveGroupSetupScreenState();
}

class _HiveGroupSetupScreenState extends State<HiveGroupSetupScreen> {
  final List<Map<String, dynamic>> _groups = [];

  int get _assignedHives {
    int total = 0;
    for (final group in _groups) {
      total += group['count'] as int;
    }
    return total;
  }

  int get _remainingHives => widget.totalHives - _assignedHives;

  void _addGroup() {
    if (_remainingHives <= 0) {
      return;
    }

    final TextEditingController nameController =
        TextEditingController();
    final TextEditingController countController =
        TextEditingController();

    String hiveType = 'Langstroth';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Add Hive Group',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Group Name',
                        hintText: 'Example: Langstroth A',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: countController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of Hives',
                        hintText: 'Maximum $_remainingHives',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: hiveType,
                      decoration: const InputDecoration(
                        labelText: 'Hive Type',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Langstroth',
                          child: Text('Langstroth'),
                        ),
                        DropdownMenuItem(
                          value: 'Traditional',
                          child: Text('Traditional'),
                        ),
                        DropdownMenuItem(
                          value: 'Top Bar',
                          child: Text('Top Bar'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            hiveType = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final String name =
                        nameController.text.trim();
                    final int? count =
                        int.tryParse(countController.text.trim());

                    if (name.isEmpty || count == null || count <= 0) {
                      return;
                    }

                    if (count > _remainingHives) {
                      return;
                    }

                    setState(() {
                      _groups.add({
                        'name': name,
                        'count': count,
                        'type': hiveType,
                      });
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Add Group'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _continue() {
    if (_assignedHives != widget.totalHives) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please assign all ${widget.totalHives} hives before continuing.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HiveScreen(
          apiaryName: widget.apiaryName,
          totalHives: widget.totalHives,
          groups: _groups,
        ),
      ),
    );
  }

  Widget _groupCard(
    int index,
    Map<String, dynamic> group,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.hive_outlined,
                color: AppTheme.honeyGold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${group['count']} hives • ${group['type']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _groups.removeAt(index);
              });
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Text(
          'Hive Group Setup',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                    const Text(
                      'Organize Your Hives',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You have ${widget.totalHives} hives in ${widget.apiaryName}.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Create groups based on how you manage your hives. '
                      'You decide the group size and hive type.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _summaryCard(
                      'Total Hives',
                      '${widget.totalHives}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      'Assigned',
                      '$_assignedHives',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _summaryCard(
                      'Remaining',
                      '$_remainingHives',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Your Groups',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed:
                        _remainingHives > 0 ? _addGroup : null,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Group'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (_groups.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.lightHoney,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.cardBorder,
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.hive_outlined,
                        size: 40,
                        color: AppTheme.honeyGold,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No groups added yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Tap "Add Group" to organize your hives.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...List.generate(
                  _groups.length,
                  (index) => _groupCard(
                    index,
                    _groups[index],
                  ),
                ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _assignedHives == widget.totalHives
                          ? _continue
                          : null,
                  child: const Text(
                    'Continue to Hive Management',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppTheme.honeyGold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.secondaryBrown,
            ),
          ),
        ],
      ),
    );
  }
}