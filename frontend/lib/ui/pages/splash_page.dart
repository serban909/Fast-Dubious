import 'package:flutter/material.dart';

import '../widgets/moustache_logo.dart';
import '../widgets/primary_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232428), Color(0xFF1E1F22), Color(0xFF111214)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MoustacheLogo(size: 132),
                const SizedBox(height: 42),
                Text(
                  'Mustache Insurance',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Policy automation layer for fast-moving broker teams.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFB5BAC1),
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                PrimaryButton(
                  label: 'Continue',
                  onPressed: onContinue,
                  icon: Icons.login_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}