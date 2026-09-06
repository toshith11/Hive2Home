import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'profile_creation_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  final TextEditingController _otpController =
      TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  static const String demoOtp = '123456';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  if (_otpController.text.trim() == demoOtp) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ProfileCreationScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Incorrect OTP. Use 123456 for this demo.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

  void _resendOtp() {
    _otpController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo OTP resent successfully.'),
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
          'Verify Phone',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            32,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: AppTheme.lightHoney,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.verified_user_outlined,
                        size: 42,
                        color: AppTheme.honeyGold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Verify your phone number',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter the 6-digit verification code '
                  'sent to your phone number.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.lightHoney,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.cardBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        color: AppTheme.secondaryBrown,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '+91 ${widget.phoneNumber}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.darkBrown,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            color: AppTheme.honeyGold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                    color: AppTheme.darkBrown,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '••••••',
                    hintStyle: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 8,
                      color: AppTheme.secondaryBrown,
                    ),
                    filled: true,
                    fillColor: AppTheme.cardWhite,
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 17,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppTheme.honeyGold,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final otp = value?.trim() ?? '';

                    if (otp.isEmpty) {
                      return 'Please enter the OTP';
                    }

                    if (otp.length != 6) {
                      return 'OTP must contain 6 digits';
                    }

                    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
                      return 'OTP should contain only digits';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: _resendOtp,
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: AppTheme.honeyGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.cardBorder,
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppTheme.secondaryBrown,
                        size: 21,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Prototype mode: use OTP 123456 '
                          'to verify this demo account.',
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
                    'Hive2Home • Secure Beekeeper Access',
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
      ),
    );
  }
}