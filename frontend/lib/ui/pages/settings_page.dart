import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workspace Settings',
            style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your workspace identity, integrations, and policy automation preferences.',
            style: theme.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFB5BAC1),
                ),
          ),
          const SizedBox(height: 24),
          GlassCard(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Branding',
                  style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                _SettingTile(
                  icon: Icons.palette_rounded,
                  title: 'Discord-inspired theme',
                  subtitle: 'Dark surfaces with vivid accent highlights.',
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (_) {},
                    activeColor: const Color(0xFF5865F2),
                  ),
                ),
                _SettingTile(
                  icon: Icons.badge_rounded,
                  title: 'Mustache logo',
                  subtitle: 'Displayed across onboarding, navigation, and PDFs.',
                  trailing: FilledButton.tonal(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF3F4147),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Replace asset'),
                  ),
                ),
              ],
            ),
          ),
          GlassCard(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Automation',
                  style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                _SettingTile(
                  icon: Icons.picture_as_pdf_rounded,
                  title: 'Auto-fill policy PDFs',
                  subtitle: 'Prefill with current day start date, SSN, and selected template branding.',
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (_) {},
                    activeColor: const Color(0xFF5865F2),
                  ),
                ),
                _SettingTile(
                  icon: Icons.sync_rounded,
                  title: 'Sync to Firebase Realtime Database',
                  subtitle: 'Send updates to `/clients` and `/vehicles` when edits are approved.',
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (_) {},
                    activeColor: const Color(0xFF5865F2),
                  ),
                ),
                _SettingTile(
                  icon: Icons.policy_rounded,
                  title: 'Default insurer',
                  subtitle: 'Apply Groupama Catalyst Fleet template unless specified.',
                  trailing: FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: const Icon(Icons.shield_rounded),
                    label: const Text('Groupama'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF3F4147),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team',
                  style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                _TeamMemberTile(
                  name: 'Eva Jenkins',
                  role: 'Owner · eva@mustache.app',
                  online: true,
                ),
                _TeamMemberTile(
                  name: 'Daniel Pop',
                  role: 'Broker · daniel@mustache.app',
                ),
                _TeamMemberTile(
                  name: 'Sofia Mendes',
                  role: 'Underwriting · sofia@mustache.app',
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_alt_rounded),
                    label: const Text('Invite teammate'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF5865F2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3F4147),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white70),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFB5BAC1),
                      ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _TeamMemberTile extends StatelessWidget {
  const _TeamMemberTile({
    required this.name,
    required this.role,
    this.online = false,
  });

  final String name;
  final String role;
  final bool online;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF5865F2),
                child: Icon(Icons.person_outline_rounded, color: Colors.white),
              ),
              if (online)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC71),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF1E1F22), width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFB5BAC1),
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
    );
  }
}