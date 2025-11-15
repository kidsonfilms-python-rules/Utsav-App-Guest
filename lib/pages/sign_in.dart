// Custom widget for the main gradient background
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/main.dart';

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent[400]!, Colors.lightBlueAccent[200]!],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
        color: Colors.blueAccent[400], // Solid blue color
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Wallet icon
                      Positioned(
                        top: 50,
                        child: Icon(
                          Icons.wallet_rounded,
                          size: 180,
                          color: Colors.grey[800],
                        ),
                      ),
                      // Money icons
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Icon(
                            Icons.monetization_on_rounded,
                            size: 80,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Icon(
                            Icons.sticky_note_2_rounded,
                            size: 70,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // --- End Illustration Placeholder ---
                const Spacer(flex: 1),
                const SizedBox(width: 12),
                Text(
                  "Utsav Events",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
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
                _SolidButton(
                  text: "Get started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
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
                                      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
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
                                      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
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
                                      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
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
                                      padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
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
                                    padding: EdgeInsetsGeometry.fromLTRB(0, 0, 20, 0),
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
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),

                        // Main Action Button: "Login" or "Register"
                        _GradientButton(
                          text: _isLogin ? "Login" : "Register",
                          onPressed: () {
                            // Handle login or registration logic
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

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
}

// Custom widget for the text fields
class _CustomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;

  const _CustomTextField({
    required this.label,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  late bool obscured = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    // Using TextFormField to get the label-as-title effect from the image
    return TextFormField(
      obscureText: obscured,
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
      body: _GradientBackground(
        isLogin: false,
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
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Wallet icon
                      Positioned(
                        top: 50,
                        child: Icon(
                          Icons.wallet_rounded,
                          size: 180,
                          color: Colors.grey[800],
                        ),
                      ),
                      // Money icons
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Icon(
                            Icons.monetization_on_rounded,
                            size: 80,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 30,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Icon(
                            Icons.sticky_note_2_rounded,
                            size: 70,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // --- End Illustration Placeholder ---
                const Spacer(flex: 1),
                const SizedBox(width: 12),
                Text(
                  "Utsav Events",
                  style: GoogleFonts.poppins(
                    fontSize: 32,
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
                _SolidButton(
                  text: "Get started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
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
