import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivestudent/controller/addcontroller.dart';
import 'package:hivestudent/kconst/const.dart';
import 'package:hivestudent/model/db_model.dart';
//import 'package:hivestudent/model/db_model.dart';
import 'package:hivestudent/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart' as pathprovide;

Addcontroller addController = Get.put(Addcontroller());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathprovide.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(StudentModelAdapter());
  // final box = await Hive.openBox<StudentModel>('studentcolection');
  // final studentdata = box.values.toList();
  await addController.getingStudentlist();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: kwhite),
      home: const HomePage(),
    );
  }
}
