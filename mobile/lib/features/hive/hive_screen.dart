import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../iot/iot_devices_screen.dart';
import '../production/production_screen.dart';

class HiveScreen extends StatelessWidget {
  final String apiaryName;
  final int totalHives;
  final List<Map<String, dynamic>> groups;

  const HiveScreen({
    super.key,
    required this.apiaryName,
    required this.totalHives,
    required this.groups,
  });

  List<Map<String, dynamic>> _createHiveGroups() {
    int hiveNumber = 1;
    final List<Map<String, dynamic>> result = [];

    for (final group in groups) {
      final int count = group['count'] as int;
      final List<String> hiveIds = [];

      for (int i = 0; i < count; i++) {
        hiveIds.add(
          'HIVE-${hiveNumber.toString().padLeft(3, '0')}',
        );
        hiveNumber++;
      }

      result.add({
        'name': group['name'],
        'type': group['type'],
        'hives': hiveIds,
      });
    }

    return result;
  }

  Widget _hiveCard(String hiveId, String type) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.hive_outlined,
              color: AppTheme.honeyGold,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hiveId,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.circle,
                  size: 8,
                  color: AppTheme.verifiedGreen,
                ),
                SizedBox(width: 5),
                Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.verifiedGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupCard(
    String groupName,
    String type,
    List<String> hives,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(18),
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
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppTheme.lightHoney,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.grid_view_outlined,
                  color: AppTheme.honeyGold,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$type • ${hives.length} hives',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...hives.map(
            (hiveId) => _hiveCard(hiveId, type),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hiveGroups =
        _createHiveGroups();

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: AppTheme.warmCream,
        foregroundColor: AppTheme.darkBrown,
        elevation: 0,
        title: const Text(
          'Hive Management',
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
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppTheme.lightHoney,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.hive_outlined,
                        color: AppTheme.honeyGold,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Hives',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$apiaryName • $totalHives hives',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.secondaryBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              const Text(
                'Hive Groups',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),
              ...hiveGroups.map(
                (group) => _groupCard(
                  group['name'] as String,
                  group['type'] as String,
                  List<String>.from(group['hives']),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.lightHoney,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sensors_outlined,
                      color: AppTheme.honeyGold,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'IoT monitoring can provide temperature, '
                        'humidity, hive weight, and bee activity '
                        'data for connected hives.',
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
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const IotDevicesScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.sensors_outlined,
                  ),
                  label: const Text(
                    'Go to IoT Devices',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const ProductionScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.water_drop_outlined,
                  ),
                  label: const Text(
                    'Record Production',
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Hive2Home • Hive Management',
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
}