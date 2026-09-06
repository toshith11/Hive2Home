import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'iot_hive_details_screen.dart';

class IotDevicesScreen extends StatelessWidget {
  const IotDevicesScreen({super.key});

  final List<Map<String, dynamic>> devices = const [
    {
      'hiveId': 'HIVE-001',
      'deviceId': 'ESP32-001',
      'status': 'Connected',
      'lastUpdated': '10:42 AM',
    },
    {
      'hiveId': 'HIVE-004',
      'deviceId': 'ESP32-004',
      'status': 'Connected',
      'lastUpdated': '10:41 AM',
    },
    {
      'hiveId': 'HIVE-007',
      'deviceId': 'ESP32-007',
      'status': 'Connected',
      'lastUpdated': '10:40 AM',
    },
    {
      'hiveId': 'HIVE-010',
      'deviceId': 'ESP32-010',
      'status': 'Offline',
      'lastUpdated': '9:58 AM',
    },
  ];

  int get connectedCount {
    return devices.where(
      (device) => device['status'] == 'Connected',
    ).length;
  }

  int get offlineCount {
    return devices.where(
      (device) => device['status'] == 'Offline',
    ).length;
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.cardBorder,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppTheme.honeyGold,
              size: 26,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppTheme.darkBrown,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deviceCard(
  BuildContext context,
  Map<String, dynamic> device,
) {
  final bool isConnected = device['status'] == 'Connected';

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: isConnected
        ? () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => IotHiveDetailsScreen(
                  hiveId: device['hiveId'],
                  deviceId: device['deviceId'],
                ),
              ),
            );
          }
        : null,
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
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
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.sensors_outlined,
              color: AppTheme.honeyGold,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device['hiveId'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  device['deviceId'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: isConnected
                            ? AppTheme.verifiedGreen
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      device['status'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isConnected
                            ? AppTheme.verifiedGreen
                            : AppTheme.secondaryBrown,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Updated ${device['lastUpdated']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isConnected)
            const Icon(
              Icons.chevron_right,
              color: AppTheme.secondaryBrown,
            ),
        ],
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
        title: const Text(
          'IoT Devices',
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.sensors,
                          color: AppTheme.honeyGold,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Smart Hive Monitoring',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Monitor hives that have an IoT device connected. '
                      'Sensor readings and hive health insights will '
                      'appear inside each hive.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _summaryCard(
                    'Connected',
                    '$connectedCount',
                    Icons.wifi,
                  ),
                  const SizedBox(width: 12),
                  _summaryCard(
                    'Offline',
                    '$offlineCount',
                    Icons.wifi_off,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Monitored Hives',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Select a hive to view its sensor data and health insights.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: AppTheme.secondaryBrown,
                ),
              ),
              const SizedBox(height: 18),
              ...devices.map(
                (device) => _deviceCard(
                  context,
                  device,
                ),
              ),
              const SizedBox(height: 14),
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
                      Icons.info_outline,
                      color: AppTheme.honeyGold,
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Sensor data will be received automatically '
                        'from the connected IoT device. The beekeeper '
                        'does not need to enter sensor readings manually.',
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
                  'Hive2Home • Smart Monitoring',
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