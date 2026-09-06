import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class IotHiveDetailsScreen extends StatelessWidget {
  final String hiveId;
  final String deviceId;

  const IotHiveDetailsScreen({
    super.key,
    required this.hiveId,
    required this.deviceId,
  });

  Widget _sensorCard(
    String title,
    String value,
    String unit,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.honeyGold,
                size: 22,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppTheme.darkBrown,
            ),
          ),
          if (unit.isNotEmpty)
            Text(
              unit,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryBrown,
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppTheme.darkBrown,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: AppTheme.warmCream,
        foregroundColor: AppTheme.darkBrown,
        elevation: 0,
        title: Text(
          hiveId,
          style: const TextStyle(
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
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppTheme.lightHoney,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.sensors,
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
                              Text(
                                hiveId,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                deviceId,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.secondaryBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
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
                                size: 9,
                                color: AppTheme.verifiedGreen,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Connected',
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
                    const SizedBox(height: 18),
                    const Text(
                      'Last updated  •  Today, 10:42 AM',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _sectionTitle('Live Sensor Data'),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
                children: [
                  _sensorCard(
                    'Temperature',
                    '36.8',
                    '°C',
                    Icons.thermostat_outlined,
                  ),
                  _sensorCard(
                    'Humidity',
                    '78',
                    '%',
                    Icons.water_drop_outlined,
                  ),
                  _sensorCard(
                    'Hive Weight',
                    '41.2',
                    'kg',
                    Icons.monitor_weight_outlined,
                  ),
                  _sensorCard(
                    'Bee Activity',
                    'Low',
                    '',
                    Icons.graphic_eq,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _sectionTitle('Hive Health'),
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
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Hive Health Score',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                        const Text(
                          '72 / 100',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.honeyGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.72,
                        minHeight: 10,
                        backgroundColor: AppTheme.lightHoney,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          AppTheme.honeyGold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Moderate Risk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _sectionTitle('AI Analysis'),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: AppTheme.honeyGold,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Smart Insight',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'The hive is showing an unusual temperature '
                      'variation along with reduced bee activity '
                      'compared with its recent pattern.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _sectionTitle('Detected Abnormalities'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.cardWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: const Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 23,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Unusual temperature variation detected.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 23,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Bee activity is lower than the recent pattern.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _sectionTitle('Recommended Action'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.lightHoney,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.task_alt,
                          color: AppTheme.honeyGold,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Physical Inspection Recommended',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Inspect the hive physically and check colony '
                      'strength, food availability, and visible '
                      'abnormalities. Review the hive again after '
                      'inspection.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'AI insights are decision-support recommendations. '
                'They do not replace physical hive inspection or '
                'professional diagnosis.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: AppTheme.secondaryBrown,
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Hive2Home • Smart Hive Monitoring',
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