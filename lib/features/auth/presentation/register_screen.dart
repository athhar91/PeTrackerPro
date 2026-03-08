import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image (Gym backdrop)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?q=80&w=2071&auto=format&fit=crop', // Finance background
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Angled Section (Lime Green)
                ClipPath(
                  clipper: RegisterHeaderClipper(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 40,
                    ),
                    color: const Color(
                      0xFFB2FF59,
                    ).withOpacity(0.9), // Slightly transparent lime
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildRegisterField(
                          icon: LucideIcons.mail,
                          label: 'Email ID',
                        ),
                        const SizedBox(height: 16),
                        _buildRegisterField(
                          icon: LucideIcons.user,
                          label: 'User Name',
                        ),
                        const SizedBox(height: 16),
                        _buildRegisterField(
                          icon: LucideIcons.lock,
                          label: 'Password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        _buildRegisterField(
                          icon: LucideIcons.lock,
                          label: 'Confirm Password',
                          isPassword: true,
                        ),
                        const SizedBox(height: 32),

                        // Sign Up Button
                        GestureDetector(
                          onTap: () => context.go('/onboarding'),
                          child: Container(
                            width: 140,
                            height: 52,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xFFB2FF59), // Arrow in lime
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ).animate().slideY(
                  begin: -1,
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),

                const Spacer(),

                // Bottom Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREATE YOUR',
                        style: GoogleFonts.outfit(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'PETRACK',
                        style: GoogleFonts.outfit(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFB2FF59), // Lime green
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1),

                const SizedBox(height: 40),

                // Back to Login
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterField({
    required IconData icon,
    required String label,
    bool isPassword = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                obscureText: isPassword,
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
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
        const Divider(color: Colors.white, height: 1),
      ],
    );
  }
}

class RegisterHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75); // Left side is lower
    path.lineTo(
      size.width,
      size.height,
    ); // Right side is full height of container
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
