import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utsav_app/util/design_constants.dart';

class GeneralFAQPage extends StatelessWidget {
  const GeneralFAQPage({super.key});

  Future<void> _contactSupport(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'utsavpr@gmail.com',
      query: Uri.encodeFull('subject=Ticket Support Request'),
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to open email client.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final faqs = [
  {
    "q": "How do I download my tickets?",
    "a":
        "Go to the Tickets page, tap 'Download Tickets', select which ones you want, and your PDF will automatically download or share.",
  },
  {
    "q": "Can I transfer my ticket to someone else?",
    "a":
        "Tickets are currently linked to your account and cannot be transferred digitally. However, you may contact support for special cases.",
  },
  {
    "q": "Do I need to print my ticket?",
    "a":
        "Digital tickets are accepted at entry. You can show the barcode on your phone. Printed copies are optional but recommended as backup.",
  },
  {
    "q": "What if I can’t find my ticket email?",
    "a":
        "Check your spam or promotions folder first. If it’s still missing, go to the Tickets section in the app — all tickets are stored there.",
  },
  {
    "q": "Can I use screenshots of my ticket?",
    "a":
        "Yes, as long as the barcode is clear and scannable. However, you may be asked to show proof of identification. Make sure your phone screen brightness is high enough at the entry gate.",
  },
  {
    "q": "What if my ticket barcode doesn’t scan?",
    "a":
        "Let a staff member know. They can verify your identity and ticket details manually.",
  },
  {
    "q": "Can I buy tickets directly through the app?",
    "a":
        "Yes, you can browse available events and purchase tickets securely through the Tickets page.",
  },
  {
    "q": "What payment methods are accepted?",
    "a":
        "We accept major credit cards, debit cards, and mobile payment options like Apple Pay and Google Pay.",
  },
  {
    "q": "Can I get a refund for my ticket?",
    "a":
        "Refund policies vary by event. Check the event details or contact support for refund requests.",
  },
  {
    "q": "How do I update my email or account information?",
    "a":
        "Go to your account settings within the app to update your email, password, and other personal details.",
  },
  {
    "q": "Is my payment information secure?",
    "a":
        "Absolutely. We use industry-standard encryption and secure payment gateways to protect your information.",
  },
  {
    "q": "Can I access tickets offline?",
    "a":
        "Yes, once downloaded, your tickets can be accessed without an internet connection.",
  },
  {
    "q": "Will I receive notifications about event updates?",
    "a":
        "Yes, enable notifications in the app to get real-time updates about your events, including schedule changes or important announcements.",
  },
  {
    "q": "Can I use the app for multiple events?",
    "a":
        "Yes, the app supports multiple tickets and events, all managed from your Tickets page.",
  },
  {
    "q": "What should I do if I lost my phone?",
    "a":
        "Immediately contact support to suspend your tickets. You can access your account and tickets from another device by logging in.",
  },
  {
    "q": "Can I share my event schedule with friends?",
    "a":
        "Yes, use the share feature on the Schedule page to send event details to friends via messaging or social media.",
  },
  {
    "q": "What if I have accessibility needs at the event?",
    "a":
        "Please contact the event organizer or support team ahead of time to arrange accommodations.",
  },
  {
    "q": "How do I reset my account password?",
    "a":
        "Use the 'Forgot Password' link on the login screen to reset your password via email.",
  },
  {
    "q": "Why isn’t my promo code working?",
    "a":
        "Promo codes may have restrictions or expiration dates. Double-check the terms and ensure the code is valid for the selected event.",
  },
  {
    "q": "Can I purchase tickets as a gift?",
    "a":
        "Yes, you can buy tickets and share the details with someone else, but the ticket will be linked to your account unless transferred via support.",
  },
  {
    "q": "How do I contact support?",
    "a":
        "You can reach support via the 'Help & Support' section in the app or email us at support@utsavapp.com.",
  },
];


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DesignConstants.backgroundColor,
        title: Text(
          "FAQS",
          style: GoogleFonts.getFont(
            'Roboto Condensed',
            fontWeight: FontWeight.w200,
            textStyle: TextStyle(color: DesignConstants.primaryTextColor),
          ),
        ),
        foregroundColor: DesignConstants.primaryTextColor,
      ),
      backgroundColor: DesignConstants.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...faqs.map(
            (faq) => _FAQItem(question: faq["q"]!, answer: faq["a"]!),
          ),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.headset,
                  color: DesignConstants.green,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  "Still need help?",
                  style: GoogleFonts.getFont(
                    'Roboto Condensed',
                    textStyle: TextStyle(
                      color: DesignConstants.primaryTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Contact our support team for assistance.",
                  style: GoogleFonts.getFont(
                    'Roboto Condensed',
                    textStyle: TextStyle(
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _contactSupport(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignConstants.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.envelope),
                  label: Text(
                    "CONTACT SUPPORT",
                    style: GoogleFonts.getFont('Roboto Condensed', textStyle: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DesignConstants.primaryCardColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: GoogleFonts.getFont(
                        'Roboto Condensed',
                        textStyle: TextStyle(
                          color: DesignConstants.primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _expanded ? 0.5 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: DesignConstants.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.answer,
                    style: GoogleFonts.getFont(
                      'Roboto Condensed',
                      textStyle: TextStyle(
                        color: DesignConstants.secondaryTextColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
                crossFadeState:
                    _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
