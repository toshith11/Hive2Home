import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SupplyTrackScreen extends StatelessWidget {
  final String batchId;
  final String honeyType;
  final String quantity;
  final String apiary;

  const SupplyTrackScreen({
    super.key,
    required this.batchId,
    required this.honeyType,
    required this.quantity,
    required this.apiary,
  });

  Widget _timelineItem(
    String title,
    String subtitle,
    IconData icon,
    bool completed,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 44,
          child: Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: completed
                      ? AppTheme.lightHoney
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: completed
                        ? AppTheme.honeyGold
                        : AppTheme.cardBorder,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 21,
                  color: completed
                      ? AppTheme.honeyGold
                      : AppTheme.secondaryBrown,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 55,
                  color: completed
                      ? AppTheme.honeyGold
                      : AppTheme.cardBorder,
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: completed
                        ? AppTheme.darkBrown
                        : AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                if (!isLast) const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
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
          'Supply & Track',
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.lightHoney,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.local_shipping_outlined,
                            color: AppTheme.honeyGold,
                            size: 27,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Supply Chain',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.secondaryBrown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                batchId,
                                style: const TextStyle(
                                  fontSize: 20,
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
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Traceability Journey',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  18,
                  20,
                  18,
                  18,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.cardWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: Column(
                  children: [
                    _timelineItem(
                      'Honey Harvested',
                      'Production recorded at the apiary.',
                      Icons.hive_outlined,
                      true,
                      false,
                    ),
                    _timelineItem(
                      'Laboratory Verified',
                      'Required quality checks passed.',
                      Icons.science_outlined,
                      true,
                      false,
                    ),
                    _timelineItem(
                      'Batch Released',
                      'Batch approved for the verified supply chain.',
                      Icons.verified_outlined,
                      true,
                      false,
                    ),
                    _timelineItem(
                      'Retailer',
                      'Supply relationship will be recorded here.',
                      Icons.storefront_outlined,
                      false,
                      false,
                    ),
                    _timelineItem(
                      'Consumer',
                      'Consumer can verify the product through QR.',
                      Icons.person_outline,
                      false,
                      true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verification Record',
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
                child: Column(
                  children: [
                    _infoRow(
                      Icons.verified_outlined,
                      'Batch Status',
                      'Verified & Released',
                    ),
                    _infoRow(
                      Icons.link_outlined,
                      'Blockchain',
                      'Traceability record created',
                    ),
                    _infoRow(
                      Icons.qr_code_2_outlined,
                      'QR Status',
                      'Ready for product verification',
                    ),
                  ],
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
                        'Supply-chain events will be connected to '
                        'the backend and blockchain later. This '
                        'prototype view represents the expected '
                        'traceability journey.',
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
                  'Hive2Home • Supply & Track',
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