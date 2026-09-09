import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../supply_track/supply_track_screen.dart';

class BatchDetailsScreen extends StatelessWidget {
  final String batchId;
  final String honeyType;
  final String quantity;
  final String apiary;
  final String harvestDate;
  final String hiveGroup;
  final List<String> selectedHives;
  final String labStatus;
  final String verificationStatus;
  final String supplyChainStatus;

  const BatchDetailsScreen({
    super.key,
    required this.batchId,
    required this.honeyType,
    required this.quantity,
    required this.apiary,
    required this.harvestDate,
    required this.hiveGroup,
    required this.selectedHives,
    required this.labStatus,
    required this.verificationStatus,
    required this.supplyChainStatus,
  });

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.honeyGold,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 115,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.secondaryBrown,
              ),
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

  Widget _statusCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openSupplyTrack(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SupplyTrackScreen(
          batchId: batchId,
          honeyType: honeyType,
          quantity: quantity,
          apiary: apiary,
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
          'Batch Details',
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
                            Icons.inventory_2_outlined,
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
                                'Batch',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.secondaryBrown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                batchId,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _infoRow(
                      Icons.water_drop_outlined,
                      'Honey Type',
                      honeyType,
                    ),
                    _infoRow(
                      Icons.scale_outlined,
                      'Quantity',
                      quantity,
                    ),
                    _infoRow(
                      Icons.location_on_outlined,
                      'Apiary',
                      apiary,
                    ),
                    _infoRow(
                      Icons.calendar_today_outlined,
                      'Harvest Date',
                      harvestDate,
                    ),
                    _infoRow(
                      Icons.grid_view_outlined,
                      'Hive Group',
                      hiveGroup,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Participating Hives',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),
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
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedHives.map(
                    (hiveId) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.lightHoney,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          hiveId,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verification & Release',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 12),
              _statusCard(
                'Laboratory Test',
                labStatus,
                Icons.science_outlined,
                AppTheme.verifiedGreen,
              ),
              _statusCard(
                'Verification',
                verificationStatus,
                Icons.verified_outlined,
                AppTheme.verifiedGreen,
              ),
              _statusCard(
                'Supply Chain',
                supplyChainStatus,
                Icons.local_shipping_outlined,
                AppTheme.verifiedGreen,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openSupplyTrack(context),
                  icon: const Icon(
                    Icons.local_shipping_outlined,
                  ),
                  label: const Text(
                    'View Supply & Track',
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                      Icons.info_outline,
                      color: AppTheme.honeyGold,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This batch record can later be connected '
                        'to the backend, laboratory report, '
                        'blockchain record, and consumer QR page.',
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
                  'Hive2Home • Batch Traceability',
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