import 'package:flutter/material.dart';
import '../../core/data/app_data.dart';
import '../../core/theme/app_theme.dart';
import '../hive/hive_screen.dart';
import '../iot/iot_devices_screen.dart';
import '../production/production_screen.dart';
import '../production_history/production_history_screen.dart';
import '../supply_track/supply_track_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String get apiaryName =>
      AppData.apiaryName.isEmpty ? 'My Apiary' : AppData.apiaryName;

  String get location =>
      AppData.location.isEmpty ? 'Location not added' : AppData.location;

  String get honeyType =>
      AppData.honeyType.isEmpty ? 'Honey type not selected' : AppData.honeyType;

  int get totalHives => AppData.totalHives;

  String get production => AppData.currentProduction.isEmpty
      ? 'No production recorded'
      : AppData.currentProduction;

  List<Map<String, dynamic>> get groups => AppData.groups;

  Widget _statCard(
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.cardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.lightHoney,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: AppTheme.honeyGold,
                size: 21,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: AppTheme.darkBrown,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.secondaryBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.lightHoney,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.honeyGold,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {String? action}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBrown,
          ),
        ),
        const Spacer(),
        if (action != null)
          Text(
            action,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.honeyGold,
            ),
          ),
      ],
    );
  }

  Widget _apiaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkBrown,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBrown.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: const Icon(
                  Icons.hive_outlined,
                  color: AppTheme.honeyGold,
                  size: 27,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ACTIVE APIARY',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      apiaryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: AppTheme.verifiedGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppTheme.honeyGold,
                  size: 19,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 22,
                  color: Colors.white12,
                ),
                const SizedBox(width: 14),
                Text(
                  '$totalHives',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'hives',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.water_drop_outlined,
                color: AppTheme.honeyGold,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  honeyType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                production,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _healthCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const IotDevicesScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppTheme.cardWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 78,
                height: 78,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 78,
                      height: 78,
                      child: CircularProgressIndicator(
                        value: 0.72,
                        strokeWidth: 7,
                        backgroundColor: AppTheme.lightHoney,
                        color: AppTheme.honeyGold,
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '72',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        Text(
                          '/100',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppTheme.secondaryBrown,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hive Health',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: AppTheme.secondaryBrown,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Moderate',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.honeyGold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Sensor variation detected. Physical inspection is recommended.',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupOverview() {
    if (groups.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: AppTheme.cardBorder),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.grid_view_rounded,
              color: AppTheme.honeyGold,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'No hive groups have been configured yet.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.secondaryBrown,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppTheme.cardBorder),
      ),
      child: Column(
        children: List.generate(
          groups.length,
          (index) {
            final group = groups[index];
            final name = group['name']?.toString() ?? 'Group';
            final count = group['count']?.toString() ?? '0';
            final type = group['type']?.toString() ?? 'Hive';

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == groups.length - 1 ? 0 : 12,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.lightHoney,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.hive_outlined,
                      color: AppTheme.honeyGold,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.secondaryBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$count hives',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _recentBatch(
    String batchId,
    String honey,
    String quantity,
    String status,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _openProductionHistory,
          borderRadius: BorderRadius.circular(17),
          child: Ink(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.cardWhite,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: AppTheme.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppTheme.lightHoney,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: AppTheme.honeyGold,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        batchId,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        honey,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      quantity,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'Released'
                            ? AppTheme.lightHoney
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: status == 'Released'
                              ? AppTheme.verifiedGreen
                              : AppTheme.secondaryBrown,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openHives() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HiveScreen(
          apiaryName: apiaryName,
          totalHives: totalHives,
          groups: groups,
        ),
      ),
    );
  }

  void _openProduction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductionScreen(
          apiaryName: apiaryName,
          groups: groups,
        ),
      ),
    );
  }

  void _openProductionHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProductionHistoryScreen(),
      ),
    );
  }

  void _openSupplyTrack() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SupplyTrackScreen(
          batchId: AppData.latestBatchId.isEmpty
              ? 'No batch available'
              : AppData.latestBatchId,
          honeyType: AppData.latestBatchHoneyType.isEmpty
              ? honeyType
              : AppData.latestBatchHoneyType,
          quantity: AppData.latestBatchQuantity.isEmpty
              ? production
              : AppData.latestBatchQuantity,
          apiary: apiaryName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasBatch = AppData.latestBatchId.isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: AppTheme.warmCream,
        foregroundColor: AppTheme.darkBrown,
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Hive2Home',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good morning, Beekeeper',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Monitor your apiary and production from one place.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _apiaryCard(),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _statCard(
                        Icons.hive_outlined,
                        '$totalHives',
                        'Active Hives',
                      ),
                      const SizedBox(width: 12),
                      _statCard(
                        Icons.water_drop_outlined,
                        production,
                        'Production',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _statCard(
                        Icons.grid_view_rounded,
                        '${groups.length}',
                        'Hive Groups',
                      ),
                      const SizedBox(width: 12),
                      _statCard(
                        Icons.verified_outlined,
                        hasBatch ? '1' : '0',
                        'Released Batches',
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _sectionTitle('Hive Health', action: 'View insights'),
                  const SizedBox(height: 12),
                  _healthCard(),
                  const SizedBox(height: 28),
                  _sectionTitle('Quick Actions'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _quickAction(
                        Icons.hive_outlined,
                        'Hives',
                        _openHives,
                      ),
                      const SizedBox(width: 10),
                      _quickAction(
                        Icons.water_drop_outlined,
                        'Production',
                        _openProduction,
                      ),
                      const SizedBox(width: 10),
                      _quickAction(
                        Icons.history_outlined,
                        'History',
                        _openProductionHistory,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _quickAction(
                        Icons.local_shipping_outlined,
                        'Supply & Track',
                        _openSupplyTrack,
                      ),
                      const SizedBox(width: 10),
                      _quickAction(
                        Icons.description_outlined,
                        'Certificates',
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Certificates will appear here after verification.',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _quickAction(
                        Icons.notifications_none_outlined,
                        'Alerts',
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No active alerts.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _sectionTitle('Hive Groups'),
                  const SizedBox(height: 12),
                  _groupOverview(),
                  const SizedBox(height: 28),
                  _sectionTitle('Recent Batches', action: 'View all'),
                  const SizedBox(height: 12),
                  if (AppData.latestBatchId.isNotEmpty)
                    _recentBatch(
                      AppData.latestBatchId,
                      AppData.latestBatchHoneyType,
                      AppData.latestBatchQuantity,
                      AppData.latestBatchStatus.isEmpty
                          ? 'Verified'
                          : AppData.latestBatchStatus,
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.cardBorder),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: AppTheme.honeyGold,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your completed production batches will appear here.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.secondaryBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      'Hive2Home • From a Healthy Hive to a Trusted Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.secondaryBrown.withValues(
                          alpha: 0.75,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}