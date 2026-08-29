// Custom widget for the main gradient background
import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utsav_app/main.dart';
import 'package:utsav_app/widgets/utsav_id_input_field.dart';
import 'package:utsav_app/pages/event_selection.dart';

// Custom widget for the main gradient background
class _GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isLogin;

  const _GradientBackground({required this.child, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    // Different gradient centers for login vs signup
    final Alignment targetCenter =
        isLogin
            ? const Alignment(-2.25, -1) // top-left
            : const Alignment(0, -1.75); // top-center

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: targetCenter,
          radius: 1.5,
          colors: const [Color(0xFF484951), Color(0xFF10101B)],
        ),
      ),
      child: child,
    );
  }
}

// Custom widget for the primary blue gradient button (Auth Screen)
class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _GradientButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const Color brandOrange = Color.fromARGB(255, 207, 44, 19);
    // A slightly brighter, more yellowish-orange for the gradient highlight
    const Color brandOrangeLight = Color.fromARGB(255, 255, 101, 66);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [brandOrange, brandOrangeLight],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: brandOrange.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  // letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom widget for the primary solid blue button (Welcome Screen)
class _SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _SolidButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3A3F47), // Solid blue color
        borderRadius: BorderRadius.circular(12.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.blueAccent.withOpacity(0.3),
        //     blurRadius: 10,
        //     offset: const Offset(0, 5),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// SCREEN 1: WELCOME SCREEN
// -----------------------------------------------------------------
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF10101B),
      body: _GradientBackground(
        isLogin: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // --- Illustration Placeholder ---
                // Replace this with your 3D asset
                SizedBox(
                  height: 500,
                  child: Image.asset("assets/images/splash 4.png"),
                ),
                // --- End Illustration Placeholder ---
                const Spacer(flex: 1),
                const SizedBox(width: 12),
                Text(
                  "Utsav Events",
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Get ready to party",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                ),
                const Spacer(flex: 3),
                // Use the new solid button
                _GradientButton(
                  text: "Get started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                const AuthScreen(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 50),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// SCREEN 2: AUTH SCREEN (TOGGLEABLE)
// -----------------------------------------------------------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Toggles between Sign In (true) and Sign Up (false)
  bool _isLogin = true;

  TextEditingController emailController = new TextEditingController();

  void _toggleAuthMode() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF10101B),
      body: _GradientBackground(
        isLogin: _isLogin,
        child: SafeArea(
          child: LayoutBuilder(
            // Use LayoutBuilder to get constraints for filling the screen
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  // Constrain the child to be at least as tall as the viewport
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Back Button
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.chevronLeft,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          padding: EdgeInsets.all(0),
                        ),
                        const SizedBox(height: 10),
                        // Title: "Login" or "Create an account"
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            _isLogin ? "Login" : "Create an account",
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign:
                                _isLogin ? TextAlign.start : TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtitle
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            _isLogin ? "Sign in with" : "Sign up with",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                            textAlign:
                                _isLogin ? TextAlign.start : TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Social Buttons (Platform-aware)
                        if (!_isLogin) // Sign Up buttons (Google + Facebook)
                          Column(
                            children: [
                              if (!Platform.isIOS) // Apple
                                SizedBox(
                                  width: double.infinity,
                                  child: _SocialButton(
                                    text: "Sign up with Apple",
                                    icon: Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        0,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.apple,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if (!Platform.isAndroid) // Google (on Android)
                                SizedBox(
                                  width: double.infinity,
                                  child: _SocialButton(
                                    text: "Sign up with Google",
                                    icon: Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        0,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: _SocialButton(
                                  text: "Sign up with Facebook",
                                  icon: Padding(
                                    padding: EdgeInsetsGeometry.fromLTRB(
                                      0,
                                      0,
                                      20,
                                      0,
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),

                        if (_isLogin) // Login buttons (Platform-aware)
                          Column(
                            children: [
                              if (!Platform.isIOS) // Apple
                                SizedBox(
                                  width: double.infinity,
                                  child: _SocialButton(
                                    text: "Sign in with Apple",
                                    icon: Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        0,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.apple,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if (!Platform.isAndroid) // Google (on Android)
                                SizedBox(
                                  width: double.infinity,
                                  child: _SocialButton(
                                    text: "Sign in with Google",
                                    icon: Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        0,
                                        0,
                                        20,
                                        0,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                    onPressed: () {
                                      HapticFeedback.heavyImpact();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: _SocialButton(
                                  text: "Sign in with Facebook",
                                  icon: Padding(
                                    padding: EdgeInsetsGeometry.fromLTRB(
                                      0,
                                      0,
                                      20,
                                      0,
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 30),

                        // const SizedBox(height: 20),

                        // Email Field
                        _CustomTextField(
                          label: "Email",
                          icon: Icons.mail_outline,
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        _CustomTextField(
                          label: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 12),

                        // Forgot Password (Only for Login)
                        if (_isLogin)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // 1. Get the current email string
                                // Note: You'll need to make sure your _CustomTextField uses a controller you can access
                                String email = emailController.text.trim();

                                // 2. Define the regex
                                final emailRegex = RegExp(
                                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                );

                                // 3. Validate
                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please enter your email address",
                                      ),
                                    ),
                                  );
                                } else if (!emailRegex.hasMatch(email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please enter a valid email address",
                                      ),
                                    ),
                                  );
                                } else {
                                  // 4. Success! Show the dialog
                                  HapticFeedback.mediumImpact();
                                  _showForgotPasswordDialog(context, email);
                                }
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),

                        // Main Action Button: "Login" or "Register"
                        _GradientButton(
                          text: _isLogin ? "Login" : "Register",
                          onPressed: () {
                            // Handle login or registration logic
                            HapticFeedback.heavyImpact();
                           Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                _isLogin ? EventsSelectionPage() : LinkTicketsPage(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 50),
                      ),
                    );
                          },
                        ),
                        _isLogin
                            ? Column(
                              children: [
                                SizedBox(height: 15),
                                _SolidButton(
                                  text: "Continue as a Guest",
                                  onPressed: () {
                                    // Handle login or registration logic
                                    HapticFeedback.heavyImpact();
                                    _showGuestWarningDialog(context);
                                  },
                                ),
                              ],
                            )
                            : SizedBox.shrink(),
                        SizedBox(height: !_isLogin ? 10 : 0),

                        !_isLogin
                            ? Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "By creating an account, you agree to our ",
                                    ),
                                    TextSpan(
                                      text: "Terms of Service",
                                      style: GoogleFonts.poppins(
                                        color: Colors.blueAccent[200],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () async {
                                              try {
                                                final launched =
                                                    await launchUrl(
                                                      Uri.https("utsavsac.org"),
                                                      mode:
                                                          LaunchMode
                                                              .inAppBrowserView,
                                                    );
                                                if (!launched) {
                                                  await launchUrl(
                                                    Uri.https("utsavsac.org"),
                                                    mode:
                                                        LaunchMode
                                                            .platformDefault,
                                                  );
                                                }
                                              } catch (e) {
                                                debugPrint(
                                                  "Failed to launch ToS: $e",
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Could not open link: ToS",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                    ),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: GoogleFonts.poppins(
                                        color: Colors.blueAccent[200],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () async {
                                              try {
                                                final launched =
                                                    await launchUrl(
                                                      Uri.https("utsavsac.org"),
                                                      mode:
                                                          LaunchMode
                                                              .inAppBrowserView,
                                                    );
                                                if (!launched) {
                                                  await launchUrl(
                                                    Uri.https("utsavsac.org"),
                                                    mode:
                                                        LaunchMode
                                                            .platformDefault,
                                                  );
                                                }
                                              } catch (e) {
                                                debugPrint(
                                                  "Failed to launch ToS: $e",
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Could not open link: ToS",
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : SizedBox.shrink(),

                        const SizedBox(height: 15),

                        // Toggle Auth Mode Text
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.poppins(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      _isLogin
                                          ? "Don't have an account? "
                                          : "Already have an account? ",
                                ),
                                TextSpan(
                                  text: _isLogin ? "Sign up" : "Sign in",
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueAccent[200],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = _toggleAuthMode,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context, String email) {
    const Color brandOrange = Color.fromARGB(255, 229, 67, 22);

    showDialog(
      context: context,
      barrierDismissible: true, // Allow user to tap away since it's just info
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B26),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Header (Centered)
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: brandOrange.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        FontAwesomeIcons.key,
                        color: brandOrange,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Reset Password",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: "We have sent a password reset link to\n",
                      ),
                      TextSpan(
                        text: email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "\n\nPlease check your inbox and follow the instructions to reset your password.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Use your updated brand orange button
                _GradientButton(
                  text: "Got it",
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGuestWarningDialog(BuildContext context) {
    // A warm amber/gold color for warnings
    const Color warningColor = Color(0xFFFFB100);

    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B26),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Centered Lock Icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: warningColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.lock,
                          color: warningColor,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Feature Locked",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "To access tickets, buy meal passes, and link your membership, you'll need to sign in to an account.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Primary Action: Go to Login
                  _GradientButton(
                    text: "Sign In or Register",
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      // Pops the dialog and then pops the screen back to Auth
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),

                  // Secondary Action: Stay as guest
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  _isLogin ? MainPage() : LinkTicketsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Continue without an account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom widget for the text fields
class _CustomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const _CustomTextField({
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  late bool obscured = widget.isPassword;

  String? emailValidator(String? value) {
    if (widget.isPassword) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Basic email regex pattern (simple and sufficient for most cases)
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null; // Valid
  }

  @override
  Widget build(BuildContext context) {
    // Using TextFormField to get the label-as-title effect from the image
    return TextFormField(
      controller: widget.controller,
      obscureText: obscured,
      keyboardType:
          widget.isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
      validator: emailValidator,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.grey[400],
          fontWeight: FontWeight.w500,
        ),

        // The image shows an underline, not a filled box
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        // icon: Icon(icon),
        suffixIcon:
            widget.isPassword
                ? (obscured
                    ? GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          obscured = false;
                        });
                      },
                      child: Icon(FontAwesomeIcons.eye),
                    )
                    : GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          obscured = true;
                        });
                      },
                      child: Icon(FontAwesomeIcons.eyeSlash),
                    ))
                : null,
        suffixIconColor: Colors.grey[800],
      ),
    );
  }
}

// Custom widget for the social login buttons
class _SocialButton extends StatelessWidget {
  final String text;
  final Widget icon; // Changed to Widget to accept FaIcon
  final VoidCallback onPressed;

  const _SocialButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon, // Use the widget directly
      label: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3A3F47), // Dark grey from image
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0, // No shadow
      ),
    );
  }
}

// -----------------------------------------------------------------
// SCREEN 3: LINK TICKETS SCREEN
// -----------------------------------------------------------------
class LinkTicketsPage extends StatelessWidget {
  const LinkTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.all(32),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: _GradientBackground(
        isLogin: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Link your Utsav ID",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 1),
                const SizedBox(width: 12),
                UtsavIdInputField(),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _showUtsavIdInfo(context),
                  child: Text(
                    "Where do I find my Utsav ID?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.grey[400],
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                // Use the new solid button
                _GradientButton(
                  text: "Link Membership",
                  onPressed: () {
                    _showMembershipPendingDialog(context, "joydeepr@gmail.com");
                  },
                ),
                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUtsavIdInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF10101B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content height
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Finding your Utsav ID",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoSection(
                  context,
                  "What is an Utsav ID?",
                  "Utsav ID is a unique 6 digit number that identifies families or groups that bought memberships/tickets together.",
                  showContact: false,
                ),
                _buildInfoSection(
                  context,
                  "Members before May 1st, 2026",
                  "Check your inbox for an email sent to the address used during registration. Still can't find it?",
                  showContact: true,
                ),
                _buildInfoSection(
                  context,
                  "Members after May 1st, 2026",
                  "Your ID was included in the confirmation email sent after your purchase.",
                  showContact: false,
                ),
                _buildInfoSection(
                  context,
                  "Day Pass Holders",
                  "Your ID is printed directly on the pass provided to you.",
                  showContact: false,
                ),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),
                _contactLink(context, "None of these options worked?"),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    String body, {
    bool showContact = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 229, 67, 22),
            ),
          ),
          const SizedBox(height: 4),
          _contactLink(context, body, showContactOnlyAtEnd: !showContact),
        ],
      ),
    );
  }

  Widget _contactLink(
    BuildContext context,
    String text, {
    bool showContactOnlyAtEnd = false,
  }) {
    final baseStyle = GoogleFonts.poppins(
      fontSize: 13,
      color: Colors.grey[400],
    );
    final linkColor =
        Colors.blueAccent[200]!; // Matches your theme's primary blue

    // Define the tap behavior
    final recognizer =
        TapGestureRecognizer()
          ..onTap = () {
            HapticFeedback.lightImpact();
            // Add your email launch logic here
          };

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: text),
          if (showContactOnlyAtEnd)
            const TextSpan(text: " ")
          else
            const TextSpan(text: " "),

          // 1. THE ICON SPAN
          !showContactOnlyAtEnd
              ? WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    onTap: () => recognizer.onTap?.call(),
                    child: Icon(
                      FontAwesomeIcons.upRightFromSquare,
                      size:
                          baseStyle.fontSize != null
                              ? baseStyle.fontSize! * 0.8
                              : 11,
                      color: linkColor,
                    ),
                  ),
                ),
              )
              : const TextSpan(text: " "),

          // 2. THE TEXT SPAN
          !showContactOnlyAtEnd
              ? TextSpan(
                text: "Contact us",
                style: baseStyle.copyWith(
                  color: linkColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: recognizer,
              )
              : const TextSpan(text: " "),
        ],
      ),
    );
  }

  void _showMembershipPendingDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      barrierDismissible: false, // Force user to pick an option
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(
                0xFF1B1B26,
              ), // Slightly lighter than background
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Header
                Center(
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(55, 229, 67, 22),
                      shape: BoxShape.circle,
                    ),
                    // 1. Use Stack + Center to bypass traditional text-line-height alignment
                    child: Stack(
                      children: [
                        Center(
                          child: FaIcon(
                            FontAwesomeIcons.envelopeCircleCheck,
                            color: const Color.fromARGB(255, 229, 67, 22),
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Verification Required",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: "We've sent a confirmation link to\n",
                      ),
                      TextSpan(
                        text: _censorEmail(email),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "\n\nYou can explore the app now, but features like tickets and meals will be locked until you are approved by the membership holder.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Action Buttons
                _GradientButton(
                  text: "Continue",
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Try a different Utsav ID",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _censorEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final username = parts[0];
    final domain = parts[1];
    if (username.length <= 3) return "***@$domain";
    return "${username.substring(0, 3)}****@$domain";
  }
}
