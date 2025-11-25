import 'package:flutter/material.dart';

import '../widgets/moustache_logo.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF232428), Color(0xFF1E1F22), Color(0xFF111214)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MoustacheLogo(size: 96),
                    const SizedBox(height: 24),
                    Text(
                      'Welcome back',
                      style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log in to orchestrate policies and automate invoices.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFB5BAC1),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF313338),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xFF3F4147)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 32,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: theme.textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFFB5BAC1),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _FrostedTextField(
                            controller: _emailController,
                            hint: 'team@mustache.app',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Password',
                            style: theme.textTheme.labelLarge?.copyWith(
                                  color: const Color(0xFFB5BAC1),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _FrostedTextField(
                            controller: _passwordController,
                            hint: '••••••••',
                            obscure: true,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Switch.adaptive(
                                value: _rememberMe,
                                onChanged: (value) => setState(() => _rememberMe = value),
                                activeColor: const Color(0xFF5865F2),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Remember me on this device',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFB5BAC1),
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          PrimaryButton(
                            label: 'Log In',
                            icon: Icons.shield_moon_rounded,
                            expanded: true,
                            onPressed: widget.onLogin,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Need access? Contact your system admin',
                        style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF5865F2),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FrostedTextField extends StatelessWidget {
  const _FrostedTextField({
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF72767D)),
        filled: true,
        fillColor: const Color(0xFF1E1F22).withOpacity(0.65),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}