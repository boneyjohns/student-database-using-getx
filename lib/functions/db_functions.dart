// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import '../model/db_model.dart';

// ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
// Future<void> addstudent(StudentModel value) async {
//   final studentDB = await Hive.openBox<StudentModel>('studentcolection');
//   final _id = await studentDB.add(value);
//   value.id = _id;

//   studentListNotifier.value.add(value);
//   studentListNotifier.notifyListeners();
// }

// Future<void> getStudents() async {
//   final studentDB = await Hive.openBox<StudentModel>('studentcolection');
//   studentListNotifier.value.clear();

//   studentListNotifier.value.addAll(studentDB.values);
//   studentListNotifier.notifyListeners();
// }

// Future<void> deleteStudent(id) async {
//   final studentDB = await Hive.openBox<StudentModel>('studentcolection');
//   await studentDB.delete(id);

//   getStudents();
// }
