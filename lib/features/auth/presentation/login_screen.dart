import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pe_track/features/auth/presentation/auth_providers.dart';
import 'package:pe_track/core/api/api_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    print('LoginScreen: Login attempt started for ${_usernameController.text}');
    setState(() => _isLoading = true);

    try {
      final success = await ref
          .read(authProvider.notifier)
          .login(_usernameController.text, _passwordController.text);

      setState(() => _isLoading = false);

      if (success) {
        print('LoginScreen: Login successful');
        if (mounted) context.go('/');
      } else {
        print('LoginScreen: Login returned false (no exception)');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login failed. Please check your credentials.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    } catch (e) {
      print('LoginScreen: Login exception: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        String message = 'An unexpected error occurred.';
        if (e.toString().contains('CONNECTION_ERROR')) {
          message = 'Connection Error: Cannot reach server.';
        } else if (e.toString().contains('TIMEOUT_ERROR')) {
          message =
              'Connection Timeout. If testing on a physical device, ensure the server IP (192.168.100.166) is reachable from your network.';
        } else if (e.toString().contains('INVALID_CREDENTIALS')) {
          message = 'Invalid username or password.';
        } else if (e.toString().contains('SERVER_ERROR')) {
          message = 'Server Error. Please try again later.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Details',
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text('Error Details'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Target: ${ApiService.baseUrl}/login'),
                            const SizedBox(height: 8),
                            Text('Error: $e'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1554224155-6726b3ff858f?q=80&w=2072&auto=format&fit=crop', // Finance background
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Angled Header
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: 180,
                    color: const Color(0xFFB2FF59), // Lime green
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'LOGIN TO YOUR',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'PETRACK',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF2962FF), // Vibrant blue
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideY(
                    begin: -1,
                    duration: 600.ms,
                    curve: Curves.easeOut,
                  ),
                ),

                const Spacer(),

                // Form Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      _buildTextField(
                        icon: LucideIcons.user,
                        label: 'User Name',
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        icon: LucideIcons.lock,
                        label: 'Password',
                        isPassword: true,
                        controller: _passwordController,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

                const SizedBox(height: 60),

                // Login Button
                Center(
                  child: GestureDetector(
                    onTap: _isLoading ? null : _handleLogin,
                    child: Container(
                      width: 140,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFB2FF59),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLoading ? 'Loading...' : 'Login',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (!_isLoading)
                            Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Color(0xFFB2FF59),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          if (_isLoading)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFFB2FF59),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms).scale(),

                const SizedBox(height: 24),

                // Create Account
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Color(0xFFB2FF59),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // DEV BYPASS
                Center(
                  child: TextButton(
                    onPressed: () {
                      ref
                          .read(authProvider.notifier)
                          .login('user', 'user123'); // Set state to logged in
                      context.go('/');
                    },
                    child: const Text(
                      '[DEV] Bypass Login',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFFB2FF59), size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  isDense: true,
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        const Divider(color: Color(0xFFB2FF59), height: 1),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
