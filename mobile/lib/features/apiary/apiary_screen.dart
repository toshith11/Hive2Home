import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../hive_group/hive_group_setup_screen.dart';

class ApiaryScreen extends StatefulWidget {
  const ApiaryScreen({super.key});

  @override
  State<ApiaryScreen> createState() => _ApiaryScreenState();
}

class _ApiaryScreenState extends State<ApiaryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _apiaryNameController =
      TextEditingController();
  final TextEditingController _locationController =
      TextEditingController();
  final TextEditingController _hiveCountController =
      TextEditingController();
  final TextEditingController _flowersController =
      TextEditingController();

  String _honeyType = 'Wildflower Honey';
  String _productionSeason = 'June - August';

  @override
  void dispose() {
    _apiaryNameController.dispose();
    _locationController.dispose();
    _hiveCountController.dispose();
    _flowersController.dispose();
    super.dispose();
  }

void _saveApiary() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  final int hiveCount =
      int.parse(_hiveCountController.text.trim());

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => HiveGroupSetupScreen(
        apiaryName: _apiaryNameController.text.trim(),
        totalHives: hiveCount,
      ),
    ),
  );
}

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppTheme.secondaryBrown,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(
        icon,
        color: AppTheme.secondaryBrown,
      ),
      filled: true,
      fillColor: AppTheme.cardWhite,
      contentPadding: const EdgeInsets.symmetric(
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
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppTheme.darkBrown,
      ),
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.secondaryBrown,
          ),
          style: const TextStyle(
            color: AppTheme.darkBrown,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
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
          'Add Apiary',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: AppTheme.lightHoney,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 44,
                        color: AppTheme.honeyGold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Set up your apiary',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.darkBrown,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add the basic details about your apiary. '
                  'You can update these details later.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 30),
                _sectionTitle('Apiary Name'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _apiaryNameController,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: AppTheme.darkBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Example: Bengaluru Farm',
                    icon: Icons.hive_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the apiary name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _sectionTitle('Location'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _locationController,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(
                    color: AppTheme.darkBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Example: Bengaluru, Karnataka',
                    icon: Icons.location_on_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the apiary location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _sectionTitle('Number of Hives'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _hiveCountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: AppTheme.darkBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(
                    hintText: 'Example: 25',
                    icon: Icons.grid_view_rounded,
                  ),
                  validator: (value) {
                    final hiveCount = int.tryParse(
                      value?.trim() ?? '',
                    );

                    if (hiveCount == null || hiveCount <= 0) {
                      return 'Enter a valid number of hives';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _sectionTitle('Honey Type'),
                const SizedBox(height: 9),
                _dropdownField(
                  value: _honeyType,
                  items: const [
                    'Wildflower Honey',
                    'Eucalyptus Honey',
                    'Sunflower Honey',
                    'Mustard Honey',
                    'Mango Blossom Honey',
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _honeyType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                _sectionTitle('Production Season'),
                const SizedBox(height: 9),
                _dropdownField(
                  value: _productionSeason,
                  items: const [
                    'January - March',
                    'April - May',
                    'June - August',
                    'September - October',
                    'November - December',
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _productionSeason = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                _sectionTitle('Flowers Available'),
                const SizedBox(height: 9),
                TextFormField(
                  controller: _flowersController,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 3,
                  style: const TextStyle(
                    color: AppTheme.darkBrown,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _inputDecoration(
                    hintText:
                        'Example: Sunflower, Eucalyptus, Mango, Mustard',
                    icon: Icons.local_florist_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter available flowers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveApiary,
                    child: const Text(
                      'Add Apiary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
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
                        color: AppTheme.secondaryBrown,
                        size: 21,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Hive IDs will be generated automatically '
                          'from the number of hives you enter.',
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
                    'Hive2Home • Smart Beekeeping',
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