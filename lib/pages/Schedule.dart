import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50, width: MediaQuery.sizeOf(context).width),
          Text(
            "SCHEDULE",
            style: GoogleFonts.getFont(
              "Roboto Condensed",
              textStyle: TextStyle(
                color: DesignConstants.primaryTextColor,
                fontSize: 34,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          DayDivider(dayDate: "FRIDAY 8/12", dayIndex: "1"),
          ExpandableCard(title: "Check-in", time: "8:00 AM", location: "Classroom", description: "This is a description of the event that you see by clicking on the card.", isNow: false, animationController: _controller, navigateToPage: widget.navigateToPage,),
          ExpandableCard(title: "Dinner", time: "7:00 PM", location: "Cafeteria", description: "This is a description of the event that you see by clicking on the card.", isNow: true, animationController: _controller, navigateToPage: widget.navigateToPage,),
          ExpandableCard(title: "Natok #1", time: "7:10 PM", location: "Stage #1", description: "This is a description of the event that you see by clicking on the card.", isNow: true, animationController: _controller, navigateToPage: widget.navigateToPage,),
        ],
      ),
    );
  }
}
