import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../batch/batch_creation_screen.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _quantityController =
      TextEditingController();

  final TextEditingController _notesController =
      TextEditingController();

  final List<Map<String, dynamic>> _groups = [
    {
      'name': 'Langstroth A',
      'type': 'Langstroth',
      'hives': [
        'HIVE-001',
        'HIVE-002',
        'HIVE-003',
        'HIVE-004',
        'HIVE-005',
        'HIVE-006',
        'HIVE-007',
        'HIVE-008',
      ],
    },
    {
      'name': 'Traditional B',
      'type': 'Traditional',
      'hives': [
        'HIVE-009',
        'HIVE-010',
        'HIVE-011',
        'HIVE-012',
        'HIVE-013',
      ],
    },
    {
      'name': 'Top Bar C',
      'type': 'Top Bar',
      'hives': [
        'HIVE-014',
        'HIVE-015',
        'HIVE-016',
        'HIVE-017',
        'HIVE-018',
        'HIVE-019',
        'HIVE-020',
        'HIVE-021',
        'HIVE-022',
        'HIVE-023',
        'HIVE-024',
        'HIVE-025',
      ],
    },
  ];

  String _selectedGroup = 'Langstroth A';
  String _selectedHoneyType = 'Wildflower Honey';
  DateTime _harvestDate = DateTime.now();

  final Set<String> _selectedHives = {};

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  List<String> get _currentGroupHives {
    final Map<String, dynamic> group = _groups.firstWhere(
      (group) => group['name'] == _selectedGroup,
    );

    return List<String>.from(group['hives']);
  }

  void _changeGroup(String? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedGroup = value;
      _selectedHives.clear();
    });
  }

  void _toggleHive(String hiveId) {
    setState(() {
      if (_selectedHives.contains(hiveId)) {
        _selectedHives.remove(hiveId);
      } else {
        _selectedHives.add(hiveId);
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _harvestDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _harvestDate = selectedDate;
      });
    }
  }

  void _saveProductionRecord() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedHives.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Select at least one hive used for this harvest.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final String quantity = _quantityController.text.trim();
    final String notes = _notesController.text.trim();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BatchCreationScreen(
          apiaryName: 'Mangalore Farm',
          hiveGroup: _selectedGroup,
          selectedHives: List<String>.from(_selectedHives),
          honeyType: _selectedHoneyType,
          harvestDate: _formatDate(_harvestDate),
          quantity: quantity,
          notes: notes,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();

    return '$day/$month/$year';
  }

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

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppTheme.honeyGold,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hiveSelectionCard(String hiveId) {
    final bool isSelected = _selectedHives.contains(hiveId);

    return InkWell(
      onTap: () {
        _toggleHive(hiveId);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightHoney
              : AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppTheme.honeyGold
                : AppTheme.cardBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.honeyGold
                    : AppTheme.lightHoney,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.hive_outlined,
                color: isSelected
                    ? Colors.white
                    : AppTheme.honeyGold,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hiveId,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkBrown,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppTheme.verifiedGreen
                  : AppTheme.secondaryBrown,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
          'Production',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Form(
            key: _formKey,
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
                            Icons.water_drop_outlined,
                            color: AppTheme.honeyGold,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Record Honey Production',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Select the hives that contributed to this harvest '
                        'and record the quantity produced.',
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
                _sectionTitle('Apiary'),
                _summaryCard(
                  'Selected Apiary',
                  'Mangalore Farm',
                  Icons.location_on_outlined,
                ),
                const SizedBox(height: 26),
                _sectionTitle('Hive Group'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGroup,
                  decoration: const InputDecoration(
                    labelText: 'Select Hive Group',
                    prefixIcon: Icon(
                      Icons.grid_view_outlined,
                    ),
                  ),
                  items: _groups.map(
                    (group) {
                      return DropdownMenuItem<String>(
                        value: group['name'],
                        child: Text(
                          '${group['name']} • '
                          '${group['hives'].length} hives',
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: _changeGroup,
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _sectionTitle('Select Hives'),
                    ),
                    Text(
                      '${_selectedHives.length} selected',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.honeyGold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Choose the individual hives that contributed '
                  'to this harvest.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 14),
                ..._currentGroupHives.map(
                  (hiveId) => _hiveSelectionCard(hiveId),
                ),
                const SizedBox(height: 26),
                _sectionTitle('Harvest Details'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedHoneyType,
                  decoration: const InputDecoration(
                    labelText: 'Honey Type',
                    prefixIcon: Icon(
                      Icons.water_drop_outlined,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Wildflower Honey',
                      child: Text('Wildflower Honey'),
                    ),
                    DropdownMenuItem(
                      value: 'Eucalyptus Honey',
                      child: Text('Eucalyptus Honey'),
                    ),
                    DropdownMenuItem(
                      value: 'Mango Blossom Honey',
                      child: Text('Mango Blossom Honey'),
                    ),
                    DropdownMenuItem(
                      value: 'Mustard Honey',
                      child: Text('Mustard Honey'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedHoneyType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectDate,
                  borderRadius: BorderRadius.circular(12),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Harvest Date',
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                    child: Text(
                      _formatDate(_harvestDate),
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppTheme.darkBrown,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    labelText: 'Harvest Quantity',
                    hintText: 'Example: 150',
                    suffixText: 'kg',
                    prefixIcon: Icon(
                      Icons.scale_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter the harvest quantity';
                    }

                    final double? quantity =
                        double.tryParse(value.trim());

                    if (quantity == null || quantity <= 0) {
                      return 'Enter a valid quantity';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Production Notes',
                    hintText:
                        'Add any relevant notes about this harvest...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 55),
                      child: Icon(
                        Icons.notes_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _sectionTitle('Batch-Ready Summary'),
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
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.lightHoney,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: AppTheme.honeyGold,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'Production Ready for Batch',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _summaryRow(
                        'Apiary',
                        'Mangalore Farm',
                      ),
                      _summaryRow(
                        'Hive Group',
                        _selectedGroup,
                      ),
                      _summaryRow(
                        'Hives Selected',
                        _selectedHives.isEmpty
                            ? 'None selected'
                            : '${_selectedHives.length} hives',
                      ),
                      _summaryRow(
                        'Honey Type',
                        _selectedHoneyType,
                      ),
                      _summaryRow(
                        'Harvest Date',
                        _formatDate(_harvestDate),
                      ),
                      _summaryRow(
                        'Quantity',
                        _quantityController.text.trim().isEmpty
                            ? 'Not entered'
                            : '${_quantityController.text.trim()} kg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
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
                        size: 22,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This production record can be used to create '
                          'a traceable honey batch. The batch will later '
                          'require laboratory quality verification before '
                          'it can be released as verified honey.',
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
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProductionRecord,
                    icon: const Icon(
                      Icons.check_circle_outline,
                    ),
                    label: const Text(
                      'Save Production Record',
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Center(
                  child: Text(
                    'Hive2Home • Honey Production',
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