import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BatchCreationScreen extends StatelessWidget {
  final String apiaryName;
  final String hiveGroup;
  final List<String> selectedHives;
  final String honeyType;
  final String harvestDate;
  final String quantity;
  final String notes;

  const BatchCreationScreen({
    super.key,
    required this.apiaryName,
    required this.hiveGroup,
    required this.selectedHives,
    required this.honeyType,
    required this.harvestDate,
    required this.quantity,
    required this.notes,
  });

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

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.darkBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hiveChip(String hiveId) {
    return Container(
      margin: const EdgeInsets.only(
        right: 8,
        bottom: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.lightHoney,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
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
  }

  void _createBatch(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Batch created successfully. Ready for lab verification.',
        ),
        behavior: SnackBarBehavior.floating,
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
          'Create Batch',
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.honeyGold,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Create Honey Batch',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.darkBrown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Review the production details before creating '
                      'a traceable honey batch.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _sectionTitle('Batch Information'),
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
                    _detailRow(
                      'Batch ID',
                      'H2H-2026-001',
                    ),
                    _detailRow(
                      'Apiary',
                      apiaryName,
                    ),
                    _detailRow(
                      'Hive Group',
                      hiveGroup,
                    ),
                    _detailRow(
                      'Honey Type',
                      honeyType,
                    ),
                    _detailRow(
                      'Harvest Date',
                      harvestDate,
                    ),
                    _detailRow(
                      'Quantity',
                      '$quantity kg',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              _sectionTitle('Source Hives'),
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
                  children: selectedHives
                      .map(
                        (hiveId) => _hiveChip(hiveId),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 26),
              _sectionTitle('Production Notes'),
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
                child: Text(
                  notes.isEmpty
                      ? 'No production notes added.'
                      : notes,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              _sectionTitle('Verification Status'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.lightHoney,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.pending_actions_outlined,
                      color: AppTheme.honeyGold,
                      size: 25,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Pending Laboratory Verification\n'
                        'The batch must pass the required laboratory '
                        'quality checks before it can be released '
                        'as verified honey.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timeline_outlined,
                          color: AppTheme.honeyGold,
                          size: 23,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Next Steps',
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
                      '1. Create production batch\n'
                      '2. Upload laboratory report\n'
                      '3. Analyze quality parameters\n'
                      '4. Approve or reject the batch\n'
                      '5. Generate QR after successful verification',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.7,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _createBatch(context);
                  },
                  icon: const Icon(
                    Icons.check_circle_outline,
                  ),
                  label: const Text(
                    'Create Honey Batch',
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Center(
                child: Text(
                  'Hive2Home • Batch Management',
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