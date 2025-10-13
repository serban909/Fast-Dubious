import 'package:flutter/material.dart';

import 'widgets/moustache_logo.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.selectedIndex,
    required this.onSectionSelected,
    required this.pages,
  });

  final int selectedIndex;
  final ValueChanged<int> onSectionSelected;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    final navItems = _navItems;
    final isCompact = MediaQuery.of(context).size.width < 720;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2B2D31), Color(0xFF313338), Color(0xFF1E1F22)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (!isCompact)
                _Sidebar(
                  selectedIndex: selectedIndex,
                  onTap: onSectionSelected,
                  items: navItems,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: pages[selectedIndex],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isCompact
          ? _BottomNavBar(
              selectedIndex: selectedIndex,
              onTap: onSectionSelected,
              items: navItems,
            )
          : null,
    );
  }

  List<_NavItem> get _navItems => const [
        _NavItem(icon: Icons.people_alt_rounded, label: 'Clients'),
        _NavItem(icon: Icons.description_rounded, label: 'Policies'),
        _NavItem(icon: Icons.tune_rounded, label: 'Settings'),
      ];
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      margin: const EdgeInsets.fromLTRB(20, 12, 12, 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F22),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 40,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const MoustacheLogo(size: 56),
          const SizedBox(height: 28),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isActive = index == selectedIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: InkWell(
                    onTap: () => onTap(index),
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF5865F2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            size: 26,
                            color: isActive ? Colors.white : const Color(0xFFB5BAC1),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.label,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: isActive ? Colors.white : const Color(0xFFB5BAC1),
                                  letterSpacing: 0.2,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF5865F2),
              child: IconButton(
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F22),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int index = 0; index < items.length; index++)
                _BottomNavItem(
                  item: items[index],
                  isActive: index == selectedIndex,
                  onTap: () => onTap(index),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF5865F2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: isActive ? Colors.white : const Color(0xFFB5BAC1),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}