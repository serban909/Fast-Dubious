import 'package:flutter/material.dart';

import '../sample_data.dart';
import '../widgets/glass_card.dart';

class PolicyComposerPage extends StatefulWidget {
  const PolicyComposerPage({super.key, required this.clients, required this.policies});

  final List<Client> clients;
  final List<PolicyTemplate> policies;

  @override
  State<PolicyComposerPage> createState() => _PolicyComposerPageState();
}

class _PolicyComposerPageState extends State<PolicyComposerPage> {
  late Client _selectedClient;
  Vehicle? _selectedVehicle;
  late PolicyTemplate _selectedTemplate;
  final DateTime _policyStart = DateTime.now();
  final TextEditingController _premiumController = TextEditingController(text: '€ 580 / year');
  final TextEditingController _deductibleController = TextEditingController(text: '€ 350');

  @override
  void initState() {
    super.initState();
    _selectedClient = widget.clients.first;
    _selectedVehicle = _selectedClient.vehicles.first;
    _selectedTemplate = widget.policies.first;
  }

  @override
  void dispose() {
    _premiumController.dispose();
    _deductibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1040;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Policy Composer',
                      style: theme.textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Select your client, pick an insurer template, and export a PDF in seconds.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFB5BAC1),
                          ),
                    ),
                  ],
                ),
              ),
              if (isWide)
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('Export PDF'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF5865F2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Flex(
            direction: isWide ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 13,
                child: GlassCard(
                  margin: EdgeInsets.only(right: isWide ? 24 : 0, bottom: isWide ? 0 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionHeader(title: 'Client & Vehicle'),
                      const SizedBox(height: 18),
                      _DiscordDropdown<Client>(
                        label: 'Client',
                        value: _selectedClient,
                        items: widget.clients,
                        displayString: (client) => client.name,
                        onChanged: (client) {
                          if (client == null) return;
                          setState(() {
                            _selectedClient = client;
                            _selectedVehicle = client.vehicles.first;
                          });
                        },
                      ),
                      const SizedBox(height: 18),
                      _DiscordDropdown<Vehicle>(
                        label: 'Vehicle',
                        value: _selectedVehicle,
                        items: _selectedClient.vehicles,
                        displayString: (vehicle) =>
                            '${vehicle.year} ${vehicle.make} ${vehicle.model} (${vehicle.plate})',
                        onChanged: (vehicle) => setState(() => _selectedVehicle = vehicle),
                      ),
                      const SizedBox(height: 24),
                      _SectionHeader(title: 'Policy Template'),
                      const SizedBox(height: 18),
                      _DiscordDropdown<PolicyTemplate>(
                        label: 'Insurer',
                        value: _selectedTemplate,
                        items: widget.policies,
                        displayString: (policy) => policy.provider,
                        onChanged: (policy) {
                          if (policy == null) return;
                          setState(() => _selectedTemplate = policy);
                        },
                        indicatorBuilder: (policy) => policy.accent,
                      ),
                      const SizedBox(height: 18),
                      _ReadOnlyField(
                        label: 'Start Date',
                        value: _formatDate(_policyStart),
                      ),
                      const SizedBox(height: 18),
                      _DiscordTextField(
                        label: 'Annual Premium',
                        controller: _premiumController,
                        prefixIcon: Icons.payments_rounded,
                      ),
                      const SizedBox(height: 18),
                      _DiscordTextField(
                        label: 'Deductible',
                        controller: _deductibleController,
                        prefixIcon: Icons.safety_check_rounded,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 11,
                child: GlassCard(
                  background: const Color(0xFF1E1F22).withOpacity(0.76),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _selectedTemplate.accent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.description_rounded,
                              color: _selectedTemplate.accent,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_selectedTemplate.provider} — ${_selectedTemplate.planName}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _selectedTemplate.coverageLevel,
                                style: theme.textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFFB5BAC1),
                                      letterSpacing: 0.2,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          FilledButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.preview_rounded),
                            label: const Text('Preview PDF'),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF3F4147),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Divider(color: Colors.white.withOpacity(0.08)),
                      const SizedBox(height: 18),
                      _PreviewLine(
                        label: 'Client',
                        value: _selectedClient.name,
                      ),
                      _PreviewLine(
                        label: 'SSN',
                        value: _selectedClient.ssn,
                      ),
                      _PreviewLine(
                        label: 'Vehicle',
                        value: _selectedVehicle == null
                            ? 'Select a vehicle'
                            : '${_selectedVehicle!.year} ${_selectedVehicle!.make} ${_selectedVehicle!.model}',
                      ),
                      _PreviewLine(
                        label: 'VIN',
                        value: _selectedVehicle?.vin ?? '--',
                      ),
                      _PreviewLine(
                        label: 'Coverage',
                        value: _selectedTemplate.coverageLevel,
                      ),
                      _PreviewLine(
                        label: 'Premium',
                        value: _premiumController.text,
                      ),
                      _PreviewLine(
                        label: 'Deductible',
                        value: _deductibleController.text,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Template notes',
                        style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _selectedTemplate.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFB5BAC1),
                              height: 1.4,
                            ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2D31),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFF3F4147)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.auto_fix_high_rounded, color: _selectedTemplate.accent),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'PDF will be auto-filled with the current day as the start date and the selected template formatting.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFB5BAC1),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (!isWide) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded),
              label: const Text('Export PDF'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF5865F2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
        const Spacer(),
        Container(
          height: 4,
          width: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF5865F2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}

class _DiscordDropdown<T> extends StatelessWidget {
  const _DiscordDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.displayString,
    required this.onChanged,
    this.indicatorBuilder,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) displayString;
  final ValueChanged<T?> onChanged;
  final Color? Function(T item)? indicatorBuilder;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFFB5BAC1),
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          dropdownColor: const Color(0xFF313338),
          icon: const Icon(Icons.expand_more_rounded, color: Colors.white70),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1E1F22).withOpacity(0.7),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF3F4147)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF3F4147)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF5865F2)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Row(
                    children: [
                      if (indicatorBuilder != null)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: indicatorBuilder!(item),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          displayString(item),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _DiscordTextField extends StatelessWidget {
  const _DiscordTextField({
    required this.label,
    required this.controller,
    this.prefixIcon,
  });

  final String label;
  final TextEditingController controller;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFFB5BAC1),
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: const Color(0xFFB5BAC1)),
            filled: true,
            fillColor: const Color(0xFF1E1F22).withOpacity(0.7),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF3F4147)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF3F4147)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Color(0xFF5865F2)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xFFB5BAC1),
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1F22).withOpacity(0.7),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF3F4147)),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 102,
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: const Color(0xFFB5BAC1),
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}