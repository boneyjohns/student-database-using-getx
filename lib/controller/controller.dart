import 'package:flutter/material.dart';
// import 'package:flutter_application_9/db/dbmodel/dbmodel.dart';,
// import 'package:flutter_application_9/main.dart';
import 'package:get/state_manager.dart';
import 'package:hivestudent/main.dart';

import '../model/db_model.dart';

class SearchController extends GetxController {
  List<StudentModel> searchedstudent = [];
  final searchcontroller1 = TextEditingController();

  searchStudent(value) {
    searchedstudent = addController.studentdata
        .where((element) => element.name.contains(value.toLowerCase()))
        .toList();

    update();
  }
}
