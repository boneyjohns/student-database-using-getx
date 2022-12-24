import 'dart:developer';
import 'dart:io';
import 'dart:core';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivestudent/controller/addcontroller.dart';
import 'package:hivestudent/kconst/const.dart';
import 'package:hivestudent/main.dart';
import 'package:hivestudent/model/db_model.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  final TextEditingController _nameControler = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _qulificationController = TextEditingController();

  XFile? image;

  String? imagepath;

  var box = Hive.box<StudentModel>('studentcolection');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kappbarcolour,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0))),
        title: Text('Add Your Detials'),
      ),
      body: GetBuilder(
          init: Addcontroller(),
          builder: (Addcontroller addcontroller) {
            return Form(
              child: ListView(
                children: [
                  if (imagepath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.file(
                        File(imagepath!),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kbuttoncolour),
                    onPressed: () => getImage(source: ImageSource.gallery),
                    child: const Text('Select New Image'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kbuttoncolour),
                      onPressed: () => getImage(source: ImageSource.camera),
                      child: const Text('Take New Image')),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      style: const TextStyle(color: kwhite),
                      controller: _nameControler,
                      decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        hintStyle: TextStyle(color: kwhite),
                        hintText: 'Name',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextField(
                      style: const TextStyle(color: kwhite),
                      controller: _ageController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: kwhite),
                        hintText: 'Age',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Location',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _qulificationController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        hintText: 'Qualification',
                        filled: true,
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kbuttoncolour),
                        onPressed: () async {
                          await addController.addingTobox(
                              _nameControler,
                              _ageController,
                              _locationController,
                              _qulificationController,
                              imagepath);
                          log(_nameControler.text);
                          log(imagepath.toString());

                          // box.add(StudentModel(
                          //   imagepath: imagepath,
                          //   name: _nameControler.text,
                          //   age: _ageController.text,
                          //   location: _locationController.text,
                          //   qualificcation: _qulificationController.text,
                          // ));
                          Navigator.of(context).pop();
                        },
                        child: Text('ADD-STUDENT')),
                  ),
                ],
              ),
            );
          }),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      // setState(() {
      imagepath = (image!.path);
      // });
    } else {
      return null;
    }
  }
}

OutlineInputBorder myinputborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 255, 255, 255),
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 0, 225, 255),
        width: 3,
      ));
}
