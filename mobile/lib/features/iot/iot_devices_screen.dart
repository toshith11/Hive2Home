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
      'temperature': '36.8°C',
      'humidity': '78%',
      'health': '72/100',
    },
    {
      'hiveId': 'HIVE-004',
      'deviceId': 'ESP32-004',
      'status': 'Connected',
      'lastUpdated': '10:41 AM',
      'temperature': '35.9°C',
      'humidity': '74%',
      'health': '84/100',
    },
    {
      'hiveId': 'HIVE-007',
      'deviceId': 'ESP32-007',
      'status': 'Connected',
      'lastUpdated': '10:40 AM',
      'temperature': '37.2°C',
      'humidity': '81%',
      'health': '68/100',
    },
    {
      'hiveId': 'HIVE-010',
      'deviceId': 'ESP32-010',
      'status': 'Offline',
      'lastUpdated': '9:58 AM',
      'temperature': '--',
      'humidity': '--',
      'health': '--',
    },
  ];

  int get connectedCount {
    return devices.where((device) => device['status'] == 'Connected').length;
  }

  int get offlineCount {
    return devices.where((device) => device['status'] == 'Offline').length;
  }

  Widget _summaryCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.cardBorder),
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
              child: Icon(
                icon,
                color: AppTheme.honeyGold,
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
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
      ),
    );
  }

  Widget _statusBadge(bool isConnected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isConnected
            ? AppTheme.verifiedGreen.withValues(alpha: 0.10)
            : Colors.grey.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: isConnected
                  ? AppTheme.verifiedGreen
                  : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isConnected ? 'Connected' : 'Offline',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isConnected
                  ? AppTheme.verifiedGreen
                  : AppTheme.secondaryBrown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceCard(
    BuildContext context,
    Map<String, dynamic> device,
  ) {
    final bool isConnected = device['status'] == 'Connected';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
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
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isConnected
                ? AppTheme.cardBorder
                : AppTheme.cardBorder.withValues(alpha: 0.75),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isConnected
                        ? AppTheme.lightHoney
                        : const Color(0xFFF4F1EB),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.sensors_outlined,
                    color: isConnected
                        ? AppTheme.honeyGold
                        : AppTheme.secondaryBrown,
                    size: 27,
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
                      const SizedBox(height: 4),
                      Text(
                        device['deviceId'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(isConnected),
                if (isConnected) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right,
                    color: AppTheme.secondaryBrown,
                    size: 22,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: AppTheme.warmCream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _miniReading(
                      Icons.thermostat_outlined,
                      'Temperature',
                      device['temperature'],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppTheme.cardBorder,
                  ),
                  Expanded(
                    child: _miniReading(
                      Icons.water_drop_outlined,
                      'Humidity',
                      device['humidity'],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: AppTheme.cardBorder,
                  ),
                  Expanded(
                    child: _miniReading(
                      Icons.favorite_outline,
                      'Health',
                      device['health'],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppTheme.secondaryBrown,
                ),
                const SizedBox(width: 5),
                Text(
                  'Last updated ${device['lastUpdated']}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const Spacer(),
                if (isConnected)
                  const Text(
                    'View monitoring',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.honeyGold,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniReading(
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppTheme.honeyGold,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBrown,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9,
            color: AppTheme.secondaryBrown,
          ),
        ),
      ],
    );
  }

  Widget _infoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppTheme.lightHoney,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppTheme.honeyGold,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Automatic Monitoring',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Connected devices continuously provide sensor readings for temperature, humidity, hive weight and bee activity.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _demoIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.science_outlined,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            'Demo Monitoring',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
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
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.darkBrown,
                  borderRadius: BorderRadius.circular(20),
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
                            color: AppTheme.honeyGold.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.sensors,
                            color: AppTheme.honeyGold,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Smart Hive Monitoring',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _demoIndicator(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Monitor connected hives and view sensor-based health insights in one place.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$connectedCount devices actively monitoring',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
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
                'Select a connected hive to view detailed sensor data and AI health insights.',
                style: TextStyle(
                  fontSize: 13,
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
              const SizedBox(height: 4),
              _infoCard(),
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