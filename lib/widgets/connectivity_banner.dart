import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/providers/connectivity_provider.dart';
import 'package:utsav_app/util/design_constants.dart';

class ConnectivityBanner extends ConsumerStatefulWidget {
  const ConnectivityBanner({super.key});

  @override
  ConsumerState<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends ConsumerState<ConnectivityBanner> {
  ConnectionStatus? _previousStatus;
  bool _isVisible = false;
  Timer? _hideTimer; // Track timer to prevent memory leaks

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(connectionProvider);

    return statusAsync.maybeWhen(
      data: (status) {
        // Handle Visibility Logic
        if (status == ConnectionStatus.online) {
          // Logic 1: Only show if we came from a 'bad' state
          if (_previousStatus == ConnectionStatus.offline ||
              _previousStatus == ConnectionStatus.lowSense) {
            _startTimer();
          } else {
            _isVisible = false;
          }
        } else if (status == ConnectionStatus.offline ||
            status == ConnectionStatus.lowSense) {
          _isVisible = true;
          _hideTimer
              ?.cancel(); // Cancel any pending 'hide' timer if we go offline again
        }

        _previousStatus = status;

        return GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            _showConnectionInfo(context, status);
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Container(
              // The height toggle drives the "push/pull" of the app content
              height:
                  (_isVisible && status != ConnectionStatus.initial) ? null : 0,
              width: double.infinity,
              color: _getBarColor(status),
              child: AnimatedOpacity(
                // Fades out slightly faster than the slide for a cleaner look
                duration: const Duration(milliseconds: 200),
                opacity: _isVisible ? 1.0 : 0.0,
                child: Material(
                  color: Colors.transparent,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (status != ConnectionStatus.online) ...[
                            Icon(
                              _getIcon(status),
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            _getMessage(status),
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  // Logic 1: Force disappearance after 1 second
  void _startTimer() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isVisible = false);
    });
  }

  Color _getBarColor(ConnectionStatus status) {
    if (status == ConnectionStatus.offline) return DesignConstants.red;
    if (status == ConnectionStatus.lowSense) return DesignConstants.orange;
    return DesignConstants.green;
  }

  IconData _getIcon(ConnectionStatus status) {
    return status == ConnectionStatus.offline
        ? Icons.signal_cellular_off
        : Icons.signal_cellular_alt_2_bar;
  }

  String _getMessage(ConnectionStatus status) {
    if (status == ConnectionStatus.offline) return "NO CONNECTION";
    if (status == ConnectionStatus.lowSense) return "LOW CONNECTIVITY";
    return "BACK ONLINE";
  }

  void _showConnectionInfo(BuildContext context, ConnectionStatus status) {
    final navContext = DesignConstants.navigatorKey.currentContext;
    if (navContext == null) return;

    showDialog(
      context: navContext,
      builder:
          (context) => Dialog(
            backgroundColor: DesignConstants.primaryCardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status Icon using FontAwesome
                  Icon(
                    status == ConnectionStatus.lowSense
                        ? FontAwesomeIcons.wifi
                        : Icons.cloud_off,
                    color:
                        status == ConnectionStatus.lowSense
                            ? DesignConstants.orange
                            : DesignConstants.red,
                    size: 44,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "OFFLINE MODE",
                    style: GoogleFonts.robotoCondensed(
                      color: DesignConstants.primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white10, thickness: 1),
                  const SizedBox(height: 20),

                  // Section 1: Tickets
                  _buildInfoSection(
                    icon: FontAwesomeIcons.ticket,
                    title: "TICKETS READY",
                    body:
                        "Your current tickets are stored locally and will work at the gate without internet.",
                  ),

                  const SizedBox(height: 24),

                  // Section 2: Updates
                  _buildInfoSection(
                    icon: FontAwesomeIcons.rotate,
                    title: "LIVE UPDATES PAUSED",
                    body:
                        "Schedule changes and announcements require a connection to refresh.",
                  ),

                  const SizedBox(height: 35),

                  // App Style Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: DesignConstants.secondaryTextColor.withOpacity(
                            0.5,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "UNDERSTOOD",
                        style: GoogleFonts.robotoCondensed(
                          color: DesignConstants.primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: DesignConstants.orange, size: 18),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.robotoCondensed(
                  color: DesignConstants.primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: GoogleFonts.robotoCondensed(
                  color: DesignConstants.secondaryTextColor,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
