import 'package:flutter/material.dart';
import 'package:haven/theme.dart';

import './ui/app_shell.dart';
import './ui/pages/dashboard_page.dart';
import './ui/pages/login_page.dart';
import './ui/pages/policy_composer_page.dart';
import './ui/pages/settings_page.dart';
import './ui/pages/splash_page.dart';
import './ui/sample_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mustache Insurance',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSplashComplete = false;
  bool _isAuthenticated = false;
  int _selectedIndex = 0;

  void _handleSplashComplete() {
    setState(() => _isSplashComplete = true);
  }

  void _handleLogin() {
    setState(() => _isAuthenticated = true);
  }

  void _onSectionTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSplashComplete) {
      return SplashPage(onContinue: _handleSplashComplete);
    }

    if (!_isAuthenticated) {
      return LoginPage(onLogin: _handleLogin);
    }

    return AppShell(
      selectedIndex: _selectedIndex,
      onSectionSelected: _onSectionTapped,
      pages: [
        DashboardPage(clients: SampleData.clients),
        PolicyComposerPage(
          clients: SampleData.clients,
          policies: SampleData.policies,
        ),
        const SettingsPage(),
      ],
    );
  }
}
