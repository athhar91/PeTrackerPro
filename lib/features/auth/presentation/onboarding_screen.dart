import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  String selectedGender = 'Male';
  int selectedWeight = 35;
  int selectedHeight = 35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TELL US ABOUT',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'YOURSELF',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFB2FF59),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slideX(begin: -0.1),

            const SizedBox(height: 40),

            // Gender Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenderButton('Male', LucideIcons.user),
                const SizedBox(width: 24),
                _buildGenderButton(
                  'Female',
                  LucideIcons.user,
                ), // Using user icon as placeholder for female if needed
              ],
            ).animate().fadeIn(delay: 200.ms).scale(),

            const SizedBox(height: 40),

            // Values Pickers
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildValuePickerSection(
                    title: 'WHAT IS YOUR WEIGHT',
                    value: selectedWeight,
                    onChanged: (val) => setState(() => selectedWeight = val),
                  ),
                  const Divider(
                    color: Color(0xFFB2FF59),
                    height: 40,
                    thickness: 1,
                  ),
                  _buildValuePickerSection(
                    title:
                        'WHAT IS YOUR HEIGHT', // Image shows weight twice, but height makes more sense
                    value: selectedHeight,
                    onChanged: (val) => setState(() => selectedHeight = val),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms),

            // Footer
            ClipPath(
              clipper: OnboardingFooterClipper(),
              child: Container(
                height: 120,
                color: const Color(0xFFB2FF59),
                child: Center(
                  child: GestureDetector(
                    onTap: () => context.go('/'),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFFB2FF59),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ).animate().slideY(
              begin: 1,
              duration: 600.ms,
              curve: Curves.easeOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButton(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFB2FF59) : Colors.white24,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? const Color(0xFFB2FF59).withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? const Color(0xFFB2FF59) : Colors.white24,
            ),
            const SizedBox(height: 8),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? const Color(0xFFB2FF59) : Colors.white24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuePickerSection({
    required String title,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB2FF59),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        NumericalPicker(initialValue: value, onChanged: onChanged),
      ],
    );
  }
}

class NumericalPicker extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const NumericalPicker({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<NumericalPicker> createState() => _NumericalPickerState();
}

class _NumericalPickerState extends State<NumericalPicker> {
  late PageController _controller;
  late double _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialValue.toDouble();
    _controller = PageController(
      initialPage: widget.initialValue,
      viewportFraction: 0.2,
    );
    _controller.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_controller.hasClients) {
      setState(() {
        _currentPage = _controller.page!;
      });
    }
  }

  @override
  void didUpdateWidget(NumericalPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      if (_controller.hasClients &&
          _controller.page?.round() != widget.initialValue) {
        _controller.animateToPage(
          widget.initialValue,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ScrollConfiguration(
        behavior: const CustomScrollBehavior(),
        child: PageView.builder(
          controller: _controller,
          onPageChanged: widget.onChanged,
          physics: const BouncingScrollPhysics(),
          itemCount: 100,
          itemBuilder: (context, index) {
            // Calculate distance from center [0.0 to 1.0+]
            double distance = (index - _currentPage).abs();

            // Real-time animation values
            double scale = (1.3 - (distance * 0.4)).clamp(0.7, 1.3);
            double opacity = (1.0 - (distance * 0.6)).clamp(0.1, 1.0);
            bool isSelected = distance < 0.5;

            return Center(
              child: GestureDetector(
                onTap: () {
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Text(
                      '$index',
                      style: GoogleFonts.outfit(
                        fontSize: 48,
                        letterSpacing: -2,
                        fontWeight: isSelected
                            ? FontWeight.w900
                            : FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFFB2FF59)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class OnboardingFooterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
