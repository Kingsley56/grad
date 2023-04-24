import 'dart:math' as math;

import 'package:grad/app/controller/menu/attendance_controller.dart';
import 'package:grad/app/core/constants/asset_path.dart';
import 'package:grad/app/data/services/GetService.dart';
import 'package:grad/app/data/services/StreamService.dart';
import 'package:grad/app/ui/android/screen/chats/channelPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:path_provider/path_provider.dart';

double getCollapseOpacity(context) {
  final settings =
      context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
  final deltaExtent = settings.maxExtent - settings.minExtent;
  final t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
      .clamp(0.0, 1.0);
  final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
  const fadeEnd = 1.0;
  final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
  return opacity;
}

Map<String, dynamic> greetings() {
  String gt = "";
  String icon = "";
  var hour = DateTime.now().hour;
  if (hour <= 12) {
    gt = 'Good Morning';
    icon = SUNRISE;
  } else if ((hour > 12) && (hour <= 16)) {
    gt = 'Good Afternoon';
    icon = SUNRISE;
  } else if ((hour > 16) && (hour < 20)) {
    gt = 'Good Evening';
    icon = SUNSET;
  } else {
    gt = 'Good Night';
    icon = NIGHT;
  }
  return {
    "greeting": gt,
    "icon": icon,
  };
}

Map<String, dynamic> currentDate() {
  String time = Jiffy().jm;
  String day = Jiffy().E;

  return {
    "day": day,
    "time": time,
  };
}

String convertToDate(String date) {
  List<String> list = date.split("-");
  int year = int.parse(list[0]);
  int month = int.parse(list[1]);
  int day = int.parse(list[2]);
  return Jiffy([year, month, day]).yMMMMd;
}

List<Tab> eventTabbar() {
  return [
    Tab(
      child: Text("Upcoming Events"),
    ),
    Tab(
      child: Text("Passed Events"),
    ),
  ];
}

List<Tab> staffsTabbar() {
  return [
    Tab(
      child: Text("Teachers"),
    ),
    Tab(
      child: Text("Non teachers"),
    ),
  ];
}

AppBar customAppBar({
  required name,
  type = null,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    title: Text(
      "$name",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    leading: IconButton(
      icon: Icon(
        FeatherIcons.cornerUpLeft,
        color: Colors.black,
      ),
      onPressed: () => Get.back(),
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: [
      type == "attendance"
          ? PopupMenuButton(
              itemBuilder: (_) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Add Attendance"),
                  ),
                ];
              },
              onSelected: (_) async {
                var param = Get.arguments;
                var attendanceController = Get.put(AttendanceController());

                if (_ == 0) {
                  await Get.toNamed(
                    "/attendance/add",
                    arguments: param,
                  );
                  attendanceController.get();
                }
              },
            )
          : Container(),
    ],
  );
}

String getConfigValue(list, key) {
  for (var item in list) {
    if (item['name'] == key) return item['value'] ?? "";
  }
  return "";
}

List<String> yearList() {
  List<String> year = [];
  int latestYear = DateTime.now().year;
  int earlistYear = 2010;
  for (var i = earlistYear; i <= latestYear; i++) {
    year.add("$i/${(i + 1)}");
  }
  return year;
}

String diffDateHuman(x) {
  final ago = DateTime.parse(x);
  return timeago.format(ago, locale: 'en_short');
}

String eventDate(start, end) {
  final dateformat = DateFormat.MMMd();

  final datatimestart = DateTime.parse(start);
  final datetimeend = DateTime.parse(end);
  return dateformat.format(datatimestart) +
      " - " +
      dateformat.format(datetimeend);
}

Icon announcementIcons(type) {
  if (type == "General Announcement") {
    return Icon(
      FeatherIcons.alertTriangle,
      color: Colors.blue,
    );
  } else if (type == "Public Holiday") {
    return Icon(
      FeatherIcons.calendar,
      color: Colors.purple,
    );
  } else if (type == "Mid term break") {
    return Icon(
      FeatherIcons.cloudRain,
      color: Colors.orange,
    );
  } else if (type == "Examination") {
    return Icon(
      FeatherIcons.bookOpen,
      color: Colors.green,
    );
  } else if (type == "School Fees") {
    return Icon(
      FeatherIcons.dollarSign,
      color: Colors.red,
    );
  } else if (type == "PTA Meeting") {
    return Icon(
      FeatherIcons.users,
      color: Colors.black,
    );
  } else if (type == "Others") {
    return Icon(
      FeatherIcons.info,
      color: Colors.red,
    );
  } else if (type == "Result") {
    return Icon(
      FeatherIcons.shield,
      color: Colors.yellow,
    );
  } else {
    return Icon(
      FeatherIcons.database,
      color: Colors.purpleAccent,
    );
  }
}

Icon userStatusIcon(String status) {
  if (status == "1") {
    return Icon(
      FeatherIcons.xCircle,
      color: Color.fromARGB(255, 54, 244, 174),
    );
  } else if (status == "2") {
    return Icon(
      FeatherIcons.checkCircle,
      color: Colors.green,
    );
  } else if (status == "0") {
    return Icon(
      FeatherIcons.userX,
      color: Colors.red,
    );
  } else {
    return Icon(
      FeatherIcons.xCircle,
      color: Colors.red,
    );
  }
}

Icon classSection(String section) {
  if (section == "nursery") {
    return Icon(
      FeatherIcons.gitPullRequest,
      color: Color.fromARGB(255, 64, 129, 250),
    );
  } else if (section == "primary") {
    return Icon(
      FeatherIcons.gitBranch,
      color: Colors.green,
    );
  } else if (section == "junior") {
    return Icon(
      FeatherIcons.gitMerge,
      color: Color.fromARGB(255, 43, 42, 42),
    );
  } else if (section == 'senior') {
    return Icon(
      FeatherIcons.gift,
      color: Color.fromARGB(255, 246, 200, 73),
    );
  } else {
    return Icon(
      FeatherIcons.xCircle,
      color: Colors.red,
    );
  }
}

Future<void> createChannel(BuildContext context, String memberId) async {
  Channel channel = await getIt<StreamService>()
      .createChannel([StreamChat.of(context).currentUser!.id, memberId]);

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return StreamChannel(
          child: ChannelPage(),
          channel: channel,
        );
      },
    ),
  );
}

String chatStreamId(school, id) {
  String uid = school + "_" + id;
  return removeAllWhitespace(uid);
}

String removeAllWhitespace(String str) {
  return str.replaceAll(RegExp(r"\s+"), "");
}

Future<String?> findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  if (directory != null) return directory.path;
  return null;
}
