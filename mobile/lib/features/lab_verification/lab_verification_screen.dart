import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/data/app_data.dart';
import '../qr/qr_generation_screen.dart';

class LabVerificationScreen extends StatefulWidget {
  final String batchId;
  final String honeyType;
  final String quantity;
  final String apiaryName;
  final String harvestDate;

  const LabVerificationScreen({
    super.key,
    required this.batchId,
    required this.honeyType,
    required this.quantity,
    required this.apiaryName,
    required this.harvestDate,
  });

  @override
  State<LabVerificationScreen> createState() =>
      _LabVerificationScreenState();
}

class _LabVerificationScreenState
    extends State<LabVerificationScreen> {
  bool reportUploaded = false;
  bool verified = false;

  void _uploadReport() {
    setState(() {
      reportUploaded = true;
      verified = true;
    });

    AppData.latestBatchStatus = 'Verified';

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Laboratory report uploaded and verified successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToQrGeneration() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QrGenerationScreen(
          batchId: widget.batchId,
          honeyType: widget.honeyType,
          quantity: widget.quantity,
          apiaryName: widget.apiaryName,
          harvestDate: widget.harvestDate,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.warmCream,
      appBar: AppBar(
        title: const Text(
          'Laboratory Verification',
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
                'Batch Verification',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload the official laboratory report for this honey batch.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppTheme.secondaryBrown,
                ),
              ),
              const SizedBox(height: 24),
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
                      'Batch Information',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _infoRow(
                      'Batch ID',
                      widget.batchId,
                    ),
                    _infoRow(
                      'Honey Type',
                      widget.honeyType,
                    ),
                    _infoRow(
                      'Quantity',
                      widget.quantity,
                    ),
                    _infoRow(
                      'Apiary',
                      widget.apiaryName,
                    ),
                    _infoRow(
                      'Harvest Date',
                      widget.harvestDate,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
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
                child: Column(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppTheme.cardWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        reportUploaded
                            ? Icons.description
                            : Icons.description_outlined,
                        color: AppTheme.honeyGold,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      reportUploaded
                          ? 'Laboratory Report Uploaded'
                          : 'Laboratory Report',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reportUploaded
                          ? 'Lab report attached to ${widget.batchId}.'
                          : 'Upload the official report issued by the laboratory.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (reportUploaded)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.cardWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.cardBorder,
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.picture_as_pdf_outlined,
                              color: AppTheme.honeyGold,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'laboratory_report.pdf',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: AppTheme.verifiedGreen,
                            ),
                          ],
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _uploadReport,
                          icon: const Icon(
                            Icons.upload_file_outlined,
                          ),
                          label: const Text(
                            'Upload Laboratory Report',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verification Status',
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
                  color: verified
                      ? AppTheme.lightHoney
                      : AppTheme.cardWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.cardBorder,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      verified
                          ? Icons.verified_outlined
                          : Icons.pending_actions_outlined,
                      color: verified
                          ? AppTheme.verifiedGreen
                          : AppTheme.honeyGold,
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            verified
                                ? 'Verified'
                                : 'Pending Verification',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: verified
                                  ? AppTheme.verifiedGreen
                                  : AppTheme.darkBrown,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            verified
                                ? 'The laboratory report has been uploaded and the batch has passed verification.'
                                : 'The batch is waiting for laboratory report upload and verification.',
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.45,
                              color: AppTheme.secondaryBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (verified)
                Column(
                  children: [
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
                      child: const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.qr_code_2_outlined,
                            color: AppTheme.honeyGold,
                            size: 28,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ready for QR Generation',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.darkBrown,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'This verified batch can proceed to QR generation and traceability.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.45,
                                    color: AppTheme.secondaryBrown,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _goToQrGeneration,
                        icon: const Icon(
                          Icons.qr_code_2_outlined,
                        ),
                        label: const Text(
                          'Continue to QR Generation',
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 28),
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
                          Icons.fact_check_outlined,
                          color: AppTheme.honeyGold,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'What happens next?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      '1. Upload the official laboratory report\n'
                      '2. Analyze the quality parameters\n'
                      '3. Approve or reject the batch\n'
                      '4. Generate QR after successful verification',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.7,
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
}