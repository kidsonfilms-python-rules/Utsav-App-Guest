import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// A drop-in replacement for [Text] that supports inline Markdown:
/// **bold**, *italic*, ~~strikethrough~~, and [links](https://example.com).
/// Behaves visually and functionally identical to [Text].
class MarkdownText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextScaler? textScaler;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextWidthBasis? textWidthBasis;
  final StrutStyle? strutStyle;
  final Locale? locale;

  const MarkdownText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.textScaler,
    this.textDirection,
    this.softWrap,
    this.textWidthBasis,
    this.strutStyle,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final defaultText = DefaultTextStyle.of(context);
    final baseStyle = defaultText.style.merge(style);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: _parseMarkdownSpans(data, baseStyle, context),
      ),
      textAlign: textAlign ?? defaultText.textAlign ?? TextAlign.start,
      textDirection: textDirection,
      softWrap: softWrap ?? defaultText.softWrap,
      overflow: overflow ?? defaultText.overflow,
      maxLines: maxLines ?? defaultText.maxLines,
      textScaler: textScaler ?? MediaQuery.textScalerOf(context),
      textWidthBasis: textWidthBasis ?? defaultText.textWidthBasis,
    );
  }

  List<InlineSpan> _parseMarkdownSpans(
    String text,
    TextStyle baseStyle,
    BuildContext context,
  ) {
    final spans = <InlineSpan>[];

    final regex = RegExp(
      r'(\*\*|__)(.*?)\1|' // **bold**
      r'(\*|_)(.*?)\3|' // *italic*
      r'~~(.*?)~~|' // ~~strikethrough~~
      r'\[([^\]]+)\]\(([^)]+)\)', // [text](link)
      dotAll: true,
    );

    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: baseStyle,
        ));
      }

      final bold = match.group(2);
      final italic = match.group(4);
      final strike = match.group(5);
      final linkText = match.group(6);
      final linkUrl = match.group(7);

      if (bold != null) {
        spans.add(TextSpan(
          text: bold,
          style: baseStyle.copyWith(fontWeight: FontWeight.w900),
        ));
      } else if (italic != null) {
        spans.add(TextSpan(
          text: italic,
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (strike != null) {
        spans.add(TextSpan(
          text: strike,
          style: baseStyle.copyWith(
            decoration: TextDecoration.lineThrough,
            decorationColor: baseStyle.color,
          ),
        ));
      } else if (linkText != null && linkUrl != null) {
        final uri = Uri.tryParse(linkUrl.trim());

        final recognizer = TapGestureRecognizer()
          ..onTap = () async {
            if (uri != null && (uri.isScheme("https") || uri.isScheme("http"))) {
              try {
                final launched = await launchUrl(
                  uri,
                  mode: LaunchMode.inAppBrowserView,
                );
                if (!launched) {
                  await launchUrl(uri, mode: LaunchMode.platformDefault);
                }
              } catch (e) {
                debugPrint("Failed to launch $linkUrl: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Could not open link: $linkUrl")),
                );
              }
            } else {
              debugPrint("Invalid URL: $linkUrl");
            }
          };

        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              onTap: () => recognizer.onTap?.call(),
              child: Icon(
                FontAwesomeIcons.upRightFromSquare,
                size: baseStyle.fontSize != null
                    ? baseStyle.fontSize! * 0.7
                    : 13,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ));

        spans.add(TextSpan(
          text: linkText,
          style: baseStyle.copyWith(
            color: Theme.of(context).colorScheme.primary,
            // decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            decorationColor: Theme.of(context).colorScheme.primary,
          ),
          recognizer: recognizer,
        ));
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd), style: baseStyle));
    }

    return spans;
  }
}
