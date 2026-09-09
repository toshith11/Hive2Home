import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../batch_details/batch_details_screen.dart';

class ProductionHistoryScreen extends StatelessWidget {
  const ProductionHistoryScreen({super.key});

  final List<Map<String, String>> productionHistory = const [
    {
      'batchId': 'H2H-2026-001',
      'honeyType': 'Wildflower Honey',
      'quantity': '150 kg',
      'apiary': 'Bengaluru Farm',
      'harvestDate': '03 Sep 2026',
      'labStatus': 'Passed',
      'batchStatus': 'Released',
      'hiveGroup': 'Group A',
    },
    {
      'batchId': 'H2H-2026-002',
      'honeyType': 'Eucalyptus Honey',
      'quantity': '95 kg',
      'apiary': 'Bengaluru Farm',
      'harvestDate': '18 Aug 2026',
      'labStatus': 'Passed',
      'batchStatus': 'Released',
      'hiveGroup': 'Group B',
    },
    {
      'batchId': 'H2H-2026-003',
      'honeyType': 'Mango Blossom Honey',
      'quantity': '120 kg',
      'apiary': 'Mysuru Apiary',
      'harvestDate': '27 Jul 2026',
      'labStatus': 'Pending',
      'batchStatus': 'Under Verification',
      'hiveGroup': 'Group A',
    },
  ];

  void _openBatchDetails(
    BuildContext context,
    Map<String, String> batch,
  ) {
    final bool passed = batch['labStatus'] == 'Passed';

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BatchDetailsScreen(
          batchId: batch['batchId']!,
          honeyType: batch['honeyType']!,
          quantity: batch['quantity']!,
          apiary: batch['apiary']!,
          harvestDate: batch['harvestDate']!,
          hiveGroup: batch['hiveGroup']!,
          selectedHives: const [
            'HIVE-001',
            'HIVE-002',
            'HIVE-003',
            'HIVE-004',
          ],
          labStatus: batch['labStatus']!,
          verificationStatus: passed
              ? 'Verified'
              : 'Pending Verification',
          supplyChainStatus: batch['batchStatus']!,
        ),
      ),
    );
  }

  Widget _historyCard(
    BuildContext context,
    Map<String, String> batch,
  ) {
    final bool released = batch['batchStatus'] == 'Released';

    return InkWell(
      onTap: () => _openBatchDetails(context, batch),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
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
                    Icons.inventory_2_outlined,
                    color: AppTheme.honeyGold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        batch['batchId']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        batch['honeyType']!,
                        style: const TextStyle(
                          fontSize: 13,
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
                    color: released
                        ? AppTheme.lightHoney
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    batch['batchStatus']!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: released
                          ? AppTheme.verifiedGreen
                          : AppTheme.secondaryBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _infoRow(
              Icons.scale_outlined,
              'Quantity',
              batch['quantity']!,
            ),
            _infoRow(
              Icons.location_on_outlined,
              'Apiary',
              batch['apiary']!,
            ),
            _infoRow(
              Icons.calendar_today_outlined,
              'Harvest Date',
              batch['harvestDate']!,
            ),
            const Divider(
              height: 24,
              color: AppTheme.cardBorder,
            ),
            Row(
              children: [
                Icon(
                  batch['labStatus'] == 'Passed'
                      ? Icons.verified_outlined
                      : Icons.pending_outlined,
                  size: 19,
                  color: batch['labStatus'] == 'Passed'
                      ? AppTheme.verifiedGreen
                      : AppTheme.honeyGold,
                ),
                const SizedBox(width: 8),
                Text(
                  'Lab: ${batch['labStatus']}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: batch['labStatus'] == 'Passed'
                        ? AppTheme.verifiedGreen
                        : AppTheme.secondaryBrown,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppTheme.secondaryBrown,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.secondaryBrown,
          ),
          const SizedBox(width: 10),
          Text(
            '$title: ',
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.secondaryBrown,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkBrown,
              ),
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
          'Production History',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Production',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'View your previous honey production batches and their verification status.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: AppTheme.secondaryBrown,
                ),
              ),
              const SizedBox(height: 24),
              ...productionHistory.map(
                (batch) => _historyCard(context, batch),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Hive2Home • Production History',
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