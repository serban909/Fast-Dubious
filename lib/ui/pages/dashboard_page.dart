import 'package:flutter/material.dart';

import '../sample_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/primary_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.clients});

  final List<Client> clients;

  int get _vehicleCount => clients.fold<int>(
        0,
        (count, client) => count + client.vehicles.length,
      );

  int get _renewalsDueCount {
    final cutoff = DateTime.now().add(const Duration(days: 30));
    return clients
        .where((client) => client.lastPolicyIssued.isBefore(cutoff))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 980;
        final theme = Theme.of(context);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
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
                            'Clients',
                            style: theme.textTheme.headlineLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Track policy-ready profiles, vehicles, and PDF exports.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                                  color: const Color(0xFFB5BAC1),
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (isWide)
                      PrimaryButton(
                        label: 'Add Client',
                        icon: Icons.add_rounded,
                        onPressed: () {},
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: [
                    _StatCard(
                      title: 'Active Clients',
                      value: '${clients.length}',
                      trendLabel: '+3 this week',
                      icon: Icons.verified_user_rounded,
                      accent: const Color(0xFF5865F2),
                    ),
                    _StatCard(
                      title: 'Insured Vehicles',
                      value: '$_vehicleCount',
                      trendLabel: '+2 pending imports',
                      icon: Icons.directions_car_rounded,
                      accent: const Color(0xFF2ECC71),
                    ),
                    _StatCard(
                      title: 'Renewals Due',
                      value: '$_renewalsDueCount',
                      trendLabel: 'within 30 days',
                      icon: Icons.alarm_rounded,
                      accent: const Color(0xFFFF9800),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _SearchField(
                              hint: 'Search by name, SSN, or plate…',
                              icon: Icons.search_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (!isWide)
                            FilledButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Client'),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF5865F2),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              ),
                            ),
                          if (isWide)
                            _FilterButton(
                              label: 'Filter',
                              icon: Icons.tune_rounded,
                              onPressed: () {},
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _FilterChip(
                              label: 'All providers',
                              icon: Icons.shield_rounded,
                              active: true,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _FilterChip(
                              label: 'Expiring soon',
                              icon: Icons.hourglass_bottom_rounded,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _FilterChip(
                              label: 'PDF ready',
                              icon: Icons.picture_as_pdf_rounded,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ListView.separated(
                  itemCount: clients.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => _ClientCard(client: clients[index]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.trendLabel,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String value;
  final String trendLabel;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      margin: const EdgeInsets.only(right: 0),
      padding: const EdgeInsets.all(22),
      background: const Color(0xFF2B2D31),
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: accent, size: 22),
                ),
                const Spacer(),
                Text(
                  trendLabel,
                  style: textTheme.labelMedium?.copyWith(
                    color: const Color(0xFFB5BAC1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              value,
              style: textTheme.displaySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: const Color(0xFFB5BAC1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard({required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = client.name.isNotEmpty ? client.name[0].toUpperCase() : '?';

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 720;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFF5865F2),
                    child: Text(
                      initials,
                      style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: (isCompact
                                  ? theme.textTheme.titleMedium
                                  : theme.textTheme.titleLarge)
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.badge_rounded, color: const Color(0xFFB5BAC1), size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                client.ssn,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFB5BAC1),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: isCompact ? Alignment.centerLeft : Alignment.centerRight,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
                  children: [
                    FilledButton.tonalIcon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
                      label: const Text('Edit'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3F4147),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.picture_as_pdf_rounded),
                      label: const Text('Generate PDF'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF5865F2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 18,
                runSpacing: 16,
                children: [
                  _DetailPill(
                    icon: Icons.mail_outline_rounded,
                    label: client.email,
                  ),
                  _DetailPill(
                    icon: Icons.call_rounded,
                    label: client.phone,
                  ),
                  _DetailPill(
                    icon: Icons.location_on_rounded,
                    label: client.address,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GlassCard(
                background: const Color(0xFF1E1F22).withOpacity(0.7),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Vehicles',
                          style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          '${client.vehicles.length} linked',
                          style: theme.textTheme.labelLarge?.copyWith(
                                color: const Color(0xFFB5BAC1),
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    for (final vehicle in client.vehicles)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFF5865F2).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.time_to_leave_rounded, color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${vehicle.year} ${vehicle.make} ${vehicle.model}',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'VIN ${vehicle.vin} | Plate ${vehicle.plate}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                          color: const Color(0xFFB5BAC1),
                                          letterSpacing: 0.2,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_horiz_rounded, color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DetailPill extends StatelessWidget {
  const _DetailPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F22).withOpacity(0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF3F4147)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFFB5BAC1)),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFB5BAC1),
                ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, required this.icon});

  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFFB5BAC1)),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF72767D)),
        filled: true,
        fillColor: const Color(0xFF1E1F22).withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF3F4147)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF3F4147)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF5865F2)),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF3F4147),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    this.active = false,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF5865F2) : const Color(0xFF1E1F22);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(active ? 1 : 0.7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF3F4147)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: active ? Colors.white : const Color(0xFFB5BAC1)),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: active ? Colors.white : const Color(0xFFB5BAC1),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}