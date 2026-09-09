import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/data/app_data.dart';
import '../batch/batch_creation_screen.dart';
import '../production_history/production_history_screen.dart';

class ProductionScreen extends StatefulWidget {
  final String apiaryName;
  final List<Map<String, dynamic>> groups;

  const ProductionScreen({
    super.key,
    required this.apiaryName,
    required this.groups,
  });

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();

  final List<String> honeyTypes = [
    'Wildflower Honey',
    'Eucalyptus Honey',
    'Mustard Honey',
    'Mango Honey',
    'Acacia Honey',
    'Other',
  ];

  String _selectedHoneyType = 'Wildflower Honey';
  String _selectedGroup = '';
  DateTime _harvestDate = DateTime.now();
  final Set<String> _selectedHives = {};

  @override
  void initState() {
    super.initState();

    if (widget.groups.isNotEmpty) {
      _selectedGroup = widget.groups.first['name'] as String;
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _createHiveGroups() {
    int hiveNumber = 1;
    final List<Map<String, dynamic>> result = [];

    for (final group in widget.groups) {
      final String groupName = group['name'] as String;
      final String type = group['type'] as String;
      final int count = group['count'] as int;

      final List<String> hiveIds = [];

      for (int i = 0; i < count; i++) {
        hiveIds.add(
          'HIVE-${hiveNumber.toString().padLeft(3, '0')}',
        );
        hiveNumber++;
      }

      result.add({
        'name': groupName,
        'type': type,
        'hives': hiveIds,
      });
    }

    return result;
  }

  List<String> _hivesForSelectedGroup() {
    final groups = _createHiveGroups();

    for (final group in groups) {
      if (group['name'] == _selectedGroup) {
        return List<String>.from(group['hives']);
      }
    }

    return [];
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

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  Future<void> _selectHarvestDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _harvestDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _harvestDate = picked;
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
            'Select at least one hive that contributed to this harvest.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final String quantity = _quantityController.text.trim();
    final String notes = _notesController.text.trim();

    AppData.currentProduction = '$quantity kg';
    AppData.latestBatchHoneyType = _selectedHoneyType;
    AppData.latestBatchQuantity = '$quantity kg';
    AppData.latestBatchHarvestDate = _formatDate(_harvestDate);
    AppData.latestBatchStatus = 'Production Recorded';

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BatchCreationScreen(
          apiaryName: widget.apiaryName,
          hiveGroup: _selectedGroup,
          selectedHives: List<String>.from(_selectedHives),
          honeyType: _selectedHoneyType,
          harvestDate: _formatDate(_harvestDate),
          quantity: quantity,
          notes: notes,
          groups: widget.groups,
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

  Widget _hiveCard(String hiveId) {
    final bool isSelected = _selectedHives.contains(hiveId);

    return GestureDetector(
      onTap: () {
        _toggleHive(hiveId);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.honeyGold
                : AppTheme.cardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.lightHoney,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.hexagon_outlined,
                color: AppTheme.honeyGold,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                hiveId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkBrown,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppTheme.honeyGold
                  : AppTheme.secondaryBrown,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _apiaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.cardBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.lightHoney,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppTheme.honeyGold,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Apiary',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.apiaryName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
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

  @override
  Widget build(BuildContext context) {
    final hiveGroups = _createHiveGroups();
    final selectedGroupHives = _hivesForSelectedGroup();

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
        child: Form(
          key: _formKey,
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
                            Icons.water_drop_outlined,
                            color: AppTheme.honeyGold,
                            size: 30,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Record Honey Production',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.darkBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Select the hives that contributed to this '
                        'harvest and record the quantity produced.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                _sectionTitle('Apiary'),
                _apiaryCard(),
                const SizedBox(height: 26),
                _sectionTitle('Hive Group'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGroup.isEmpty
                      ? null
                      : _selectedGroup,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.cardWhite,
                    prefixIcon: const Icon(
                      Icons.grid_view_outlined,
                      color: AppTheme.honeyGold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                  ),
                  items: hiveGroups.map((group) {
                    final String name = group['name'] as String;
                    final List<String> hives =
                        List<String>.from(group['hives']);

                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(
                        '$name • ${hives.length} hives',
                      ),
                    );
                  }).toList(),
                  onChanged: _changeGroup,
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Hives',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBrown,
                      ),
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
                const SizedBox(height: 8),
                const Text(
                  'Choose the individual hives that contributed '
                  'to this harvest.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: AppTheme.secondaryBrown,
                  ),
                ),
                const SizedBox(height: 14),
                ...selectedGroupHives.map(
                  (hiveId) => _hiveCard(hiveId),
                ),
                const SizedBox(height: 18),
                _sectionTitle('Harvest Details'),
                DropdownButtonFormField<String>(
                  initialValue: _selectedHoneyType,
                  decoration: InputDecoration(
                    labelText: 'Honey Type',
                    filled: true,
                    fillColor: AppTheme.cardWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                  ),
                  items: honeyTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _selectedHoneyType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _selectHarvestDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: AppTheme.honeyGold,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Harvest Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      AppTheme.secondaryBrown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatDate(_harvestDate),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.darkBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppTheme.secondaryBrown,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Quantity Produced',
                    hintText: 'Enter quantity in kg',
                    suffixText: 'kg',
                    filled: true,
                    fillColor: AppTheme.cardWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';

                    if (text.isEmpty) {
                      return 'Enter the quantity produced.';
                    }

                    final number = double.tryParse(text);

                    if (number == null || number <= 0) {
                      return 'Enter a valid quantity.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Production Notes',
                    hintText:
                        'Add any useful notes about this harvest',
                    filled: true,
                    fillColor: AppTheme.cardWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.cardBorder,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                _sectionTitle('Batch-Ready Summary'),
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
                  child: Column(
                    children: [
                      _summaryRow(
                        'Apiary',
                        widget.apiaryName,
                      ),
                      _summaryRow(
                        'Hive Group',
                        _selectedGroup,
                      ),
                      _summaryRow(
                        'Participating Hives',
                        '${_selectedHives.length}',
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
                            ? '-'
                            : '${_quantityController.text.trim()} kg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saveProductionRecord,
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                    label: const Text(
                      'Continue to Batch Creation',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _openProductionHistory,
                    icon: const Icon(
                      Icons.history,
                    ),
                    label: const Text(
                      'View Production History',
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Center(
                  child: Text(
                    'Hive2Home • Production Management',
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

  Widget _summaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
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
}