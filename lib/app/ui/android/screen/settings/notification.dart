import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad/app/controller/settings/settings_controller.dart';
import 'package:grad/app/core/functions/functions.dart';

class Notification extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Notification"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
            bottom: 15,
          ),
          child: Obx(() {
            if (controller.loading.value)
              return Center(
                child: CircularProgressIndicator(),
              );
            var settings = controller.app_notifications_settings;
            return ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "App notification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Turn off app notification"),
                  trailing: Switch(
                    value: settings["app"],
                    onChanged: (bool? newValue) =>
                        controller.updateNotification("app", newValue),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Announcement",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Turn off announcement"),
                  trailing: Switch(
                    value: settings["announcement"],
                    onChanged: (bool? newValue) =>
                        controller.updateNotification("announcement", newValue),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Email notification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Turn off Email notification"),
                  trailing: Switch(
                    value: settings["email"],
                    onChanged: (bool? newValue) =>
                        controller.updateNotification("email", newValue),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "SMS notification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text("Turn off SMS notification"),
                  trailing: Switch(
                    value: settings["sms"],
                    onChanged: (bool? newValue) =>
                        controller.updateNotification("sms", newValue),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}