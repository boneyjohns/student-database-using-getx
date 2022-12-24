import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hivestudent/model/db_model.dart';
import 'package:image_picker/image_picker.dart';

class Addcontroller extends GetxController {
  List<StudentModel> studentdata = [];
  Future<void> getingStudentlist() async {
    final box = await Hive.openBox<StudentModel>('studentcolection');
    studentdata = box.values.toList();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> addingTobox(namecontroller, agecontroller, locationcontroller,
      qualificationcontroller, imagePath) async {
    // String? imagePath;
    final _namecontroller1 = namecontroller.text.trim();
    final _agecontroller1 = agecontroller.text.trim();
    final _locationController1 = locationcontroller.text.trim();
    final _qualificationController1 = qualificationcontroller.text.trim();
    if (_namecontroller1.isNotEmpty) {
      final data = StudentModel(
          imagepath: imagePath,
          name: _namecontroller1,
          age: _agecontroller1,
          location: _locationController1,
          qualificcation: _qualificationController1);

      final box = await Hive.openBox<StudentModel>('studentcolection');

      await box.add(data);

      studentdata = box.values.toList();
    }

    update();
  }

  deleteStudent(index) async {
    final box = await Hive.box<StudentModel>('studentcolection');

    if (index >= 0) {
      await box.deleteAt(index);
    }

    studentdata = box.values.toList();
    update();
  }

  Future<void> editbox(namecontroller, agecontroller, locationcontroller,
      qualificationcontroller, imagePath, index) async {
    final _namecontroller1 = namecontroller.text.trim();
    final _agecontroller1 = agecontroller.text.trim();
    final _locationController1 = locationcontroller.text.trim();
    final _qualificationController1 = qualificationcontroller.text.trim();
    if (_namecontroller1.isNotEmpty) {
      final data = StudentModel(
          imagepath: imagePath,
          name: _namecontroller1,
          age: _agecontroller1,
          location: _locationController1,
          qualificcation: _qualificationController1);

      final box = await Hive.openBox<StudentModel>('studentcolection');

      await box.putAt(index, data);

      studentdata = box.values.toList();
    }

    update();
  }
}
