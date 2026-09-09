import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../core/theme/app_theme.dart';
import '../../core/data/app_data.dart';
import '../dashboard/dashboard_screen.dart';

class QrGenerationScreen extends StatefulWidget {
  final String batchId;
  final String honeyType;
  final String quantity;
  final String apiaryName;
  final String harvestDate;

  const QrGenerationScreen({
    super.key,
    required this.batchId,
    required this.honeyType,
    required this.quantity,
    required this.apiaryName,
    required this.harvestDate,
  });

  @override
  State<QrGenerationScreen> createState() => _QrGenerationScreenState();
}

class _QrGenerationScreenState extends State<QrGenerationScreen> {
  bool qrGenerated = false;
  bool batchReleased = false;

  String get qrData {
    return 'Hive2Home|Batch:${widget.batchId}|Honey:${widget.honeyType}|Quantity:${widget.quantity}|Apiary:${widget.apiaryName}|Harvest:${widget.harvestDate}|Status:Verified';
  }

  void _generateQr() {
    setState(() {
      qrGenerated = true;
      batchReleased = true;
    });

    AppData.latestBatchId = widget.batchId;
    AppData.latestBatchHoneyType = widget.honeyType;
    AppData.latestBatchQuantity = widget.quantity;
    AppData.latestBatchHarvestDate = widget.harvestDate;
    AppData.latestBatchStatus = 'Released';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'QR generated and ${widget.batchId} released for supply chain.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToDashboard() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const DashboardScreen(),
      ),
      (route) => false,
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        backgroundColor: AppTheme.warmCream,
        foregroundColor: AppTheme.darkBrown,
        elevation: 0,
        title: const Text(
          'QR Generation',
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
                      'Verified Batch',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _infoRow('Batch ID', widget.batchId),
                    _infoRow('Honey Type', widget.honeyType),
                    _infoRow('Quantity', widget.quantity),
                    _infoRow('Apiary', widget.apiaryName),
                    _infoRow('Harvest Date', widget.harvestDate),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppTheme.cardBorder,
                    ),
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 220,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.batchId,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: batchReleased
                      ? AppTheme.lightHoney
                      : AppTheme.cardWhite,
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
                          batchReleased
                              ? Icons.verified_outlined
                              : Icons.qr_code_2_outlined,
                          color: batchReleased
                              ? AppTheme.verifiedGreen
                              : AppTheme.honeyGold,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          batchReleased
                              ? 'Batch Released'
                              : 'Ready for Release',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: batchReleased
                                ? AppTheme.verifiedGreen
                                : AppTheme.darkBrown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      batchReleased
                          ? 'The verified batch is now released for the supply chain.'
                          : 'Generate the QR code to release this verified batch for the supply chain.',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (!qrGenerated)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _generateQr,
                    icon: const Icon(
                      Icons.qr_code_2_outlined,
                    ),
                    label: const Text(
                      'Generate QR Code',
                    ),
                  ),
                ),
              if (qrGenerated) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.cardBorder,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppTheme.verifiedGreen,
                        size: 25,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'QR generated successfully. Batch is released for supply chain.',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _goToDashboard,
                    icon: const Icon(
                      Icons.dashboard_outlined,
                    ),
                    label: const Text(
                      'Go to Dashboard',
                    ),
                  ),
                ),
              ],
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