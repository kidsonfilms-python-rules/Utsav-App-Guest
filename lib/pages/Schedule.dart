import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utsav_app/util/design_constants.dart';
import 'package:utsav_app/widgets/day_divider.dart';
import 'package:utsav_app/widgets/schedule_card.dart';

class SchedulePage extends StatefulWidget {
  final Function(int, {String? markerId}) navigateToPage;
  const SchedulePage({required this.navigateToPage, super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _nowEventKeys = [];

  bool _showJumpToNow = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _scrollController.addListener(_updateNowVisibility);

    // Initial check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateNowVisibility();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final events = [
    {
      "day": "FRIDAY 8/12",
      "dayIndex": 1,
      "title": "Check-in",
      "time": "8:00 AM",
      "location": "Classroom",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "FRIDAY 8/12",
      "dayIndex": 1,
      "title": "Dinner",
      "time": "8:00 PM",
      "location": "Cafeteria",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "FRIDAY 8/12",
      "dayIndex": 1,
      "title": "Natok #1",
      "time": "9:00 PM",
      "location": "Stage",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "SATURDAY 8/13",
      "dayIndex": 2,
      "title": "Check-in",
      "time": "8:00 AM",
      "location": "Classroom",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "SATURDAY 8/13",
      "dayIndex": 2,
      "title": "Dinner",
      "time": "8:00 PM",
      "location": "Cafeteria",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "SATURDAY 8/13",
      "dayIndex": 2,
      "title": "Natok #1",
      "time": "9:00 PM",
      "location": "Stage",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "SUNDAY 8/14",
      "dayIndex": 3,
      "title": "Check-in",
      "time": "8:00 AM",
      "location": "Classroom",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
    {
      "day": "SUNDAY 8/14",
      "dayIndex": 3,
      "title": "Dinner",
      "time": "8:00 PM",
      "location": "Cafeteria",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": true,
    },
    {
      "day": "SUNDAY 8/14",
      "dayIndex": 3,
      "title": "Natok #1",
      "time": "9:00 PM",
      "location": "Stage",
      "description":
          "This is a description of the event that you see by clicking on the card.",
      "isNow": false,
    },
  ];

  Map<String, List<Map<String, dynamic>>> _groupEventsByDay(
    List<Map<String, dynamic>> events,
  ) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final event in events) {
      final day = event["day"] as String;
      grouped.putIfAbsent(day, () => []).add(event);
    }

    return grouped;
  }

  List<Widget> _buildScheduleList(BuildContext context) {
    final groupedEvents = _groupEventsByDay(events);
    final List<Widget> widgets = [];

    _nowEventKeys.clear();

    groupedEvents.forEach((day, dayEvents) {
      widgets.add(
        DayDivider(
          dayDate: day,
          dayIndex: dayEvents.first["dayIndex"]?.toString() ?? "0",
        ),
      );

      for (final event in dayEvents) {
        final bool isNow = event["isNow"] == true;

        Widget card = ExpandableCard(
          title: event["title"] ?? "",
          time: event["time"] ?? "",
          location: event["location"] ?? "",
          description: event["description"] ?? "",
          isNow: isNow,
          animationController: _controller,
          navigateToPage: widget.navigateToPage,
        );

        if (isNow) {
          // Create a new key for each now event and add it to the list
          final key = GlobalKey();
          _nowEventKeys.add(key);

          card = Container(key: key, child: card);
        }

        widgets.add(card);
      }
    });

    return widgets;
  }

  void _jumpToNow() {
    if (_nowEventKeys.isEmpty) return;

    final firstNowKey = _nowEventKeys.first;

    final context = firstNowKey.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.15,
    );
  }

  void _updateNowVisibility() {
    final context = _nowEventKeys[0].currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final screenHeight = MediaQuery.of(context).size.height;

    final double top = position.dy;
    final double bottom = top + size.height;

    // Tune these margins if needed
    final bool isVisible = bottom > 120 && top < screenHeight - 160;

    if (_showJumpToNow == isVisible) {
      setState(() {
        _showJumpToNow = !isVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                "SCHEDULE",
                style: GoogleFonts.robotoCondensed(
                  color: DesignConstants.primaryTextColor,
                  fontSize: 34,
                ),
              ),
              const SizedBox(height: 20),

              ..._buildScheduleList(context),

              const SizedBox(height: 120),
            ],
          ),
        ),

        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          right: 20,
          bottom: _showJumpToNow ? 20 : -80,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: _showJumpToNow ? 1 : 0,
            child: FloatingActionButton.extended(
              onPressed: _showJumpToNow ? _jumpToNow : null,
              backgroundColor: DesignConstants.primaryCardColorLight,
              icon: const Icon(FontAwesomeIcons.anglesDown),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // change this value
              ),
              label: Text(
                "JUMP TO NOW",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
