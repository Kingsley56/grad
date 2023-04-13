import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:Grad/app/controller/account/account_controller.dart';
import 'package:Grad/app/controller/others/update-controller.dart';
import 'package:Grad/app/core/constants/asset_path.dart';

class AccountSection extends GetView<AccountController> {
  const AccountSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        top: 10,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account".toUpperCase(),
                  ),
                ],
              ),
              Divider(),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    onTap: () async {
                      UpdateController updateController =
                          Get.put(UpdateController());

                      await Get.toNamed("/edit-profile");
                      updateController.updateSession();
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      FeatherIcons.user,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Edit Account",
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => Get.toNamed("/change-password-account"),
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      PASSWORD,
                      width: 25,
                    ),
                    title: Text(
                      "Change Password",
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => showAlertDialog(context),
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      LOGOUT,
                      width: 25,
                    ),
                    title: Text(
                      "Logout",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Logout pop up
  ///

  showAlertDialog(BuildContext context) {
    ///
    ///No button
    ///
    Widget nobutton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    ///
    /// yes button
    ///
    Widget yesButton = TextButton(
      child: Text("Yes, Log me out"),
      onPressed: () async {
        await controller.logout();
        Navigator.pop(context);

        ///
        /// Back to select school
        ///
        Get.offAllNamed("/");
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to logout?"),
      actions: [
        nobutton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
