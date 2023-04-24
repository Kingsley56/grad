import 'package:grad/app/controller/menu/classes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grad/app/data/model/campus_model.dart' as campusModel;

class Campus extends GetView<ClassesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Obx(
        () => _method(),
      ),
    );
  }

  Widget _method() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Campus",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<campusModel.Campus>(
          isExpanded: true,
          hint: Text("Campus"),
          value: controller.campus_value.value,
          onChanged: (campusModel.Campus? value) {
            if (value != null) {
              controller.updateCampusState(value);
            }
          },
          items: controller.campus
              .map(
                (e) => DropdownMenuItem<campusModel.Campus>(
                  child: Text("${e.name}"),
                  value: e,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
