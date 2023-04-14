import 'package:Grad/app/controller/calendar/calendar_controller.dart';
import 'package:Grad/app/controller/others/update-controller.dart';
import 'package:Grad/app/core/functions/functions.dart';
import 'package:Grad/app/ui/android/widgets/calendar/passed_events.dart';
import 'package:Grad/app/ui/android/widgets/calendar/upcoming_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController calendarController = Get.put(CalendarController());
  @override
  Widget build(BuildContext context) {
    List<Tab> _tab = eventTabbar();
    return DefaultTabController(
      initialIndex: 0,
      length: _tab.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorDark,
          bottom: TabBar(
            isScrollable: false,
            tabs: _tab,
          ),
        ),
        body: TabBarView(
          children: [
            ///
            ///Upcoming events
            ///
            UpcomingEvents(),

            ///
            ///Passed Events
            ///
            PassedEvents(),
          ],
        ),
        floatingActionButton: calendarController.user_group.value == "admin"
            ? FloatingActionButton(
                onPressed: () async {
                  UpdateController updateController =
                      Get.put(UpdateController());

                  await Get.toNamed("new-event");
                  updateController.updateSession();
                },
                child: Icon(FeatherIcons.plus),
              )
            : Container(),
      ),
    );
  }
}
