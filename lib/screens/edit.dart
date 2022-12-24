import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivestudent/kconst/const.dart';
import 'package:hivestudent/main.dart';
import 'package:hivestudent/model/db_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';

class EditStudent extends StatelessWidget {
  final box = Hive.box<StudentModel>('studentcolection');
  final StudentModel obj;
  final int index;
  // final formKey = GlobalKey<FormState>();

  EditStudent({Key? key, required this.obj, required this.index})
      : super(key: key);

//   @override
//   _EditStudentState createState() => _EditStudentState();
// }

// class _EditStudentState extends State<EditStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  int? newKey;
  int? accessKey;
  XFile? image;
  String? imagePath;

  void details() {
    nameController.text = obj.name;
    ageController.text = obj.age.toString();
    placeController.text = obj.location;
    imagePath = obj.imagepath;
    qualificationController.text = obj.qualificcation;

    newKey = obj.key;
    List<StudentModel> student = box.values.toList();
    for (int i = 0; i < student.length; i++) {
      if (student[i].key == newKey) {
        accessKey = i;
        break;
      }
    }
  }

  // @override
  // void initState() {
  //   details();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        details();
      },
    );
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: Text('Edit Student'),
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(48.0))),
          backgroundColor: kappbarcolour,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imagePath != null)
                    ClipRRect(
                      child: Image.file(
                        File(imagePath!),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.man,
                        color: Colors.black,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                    controller: nameController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Age",
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: placeController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Location",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.black,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: qualificationController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Qualification",
                      prefixIcon: Icon(
                        Icons.turned_in_not_outlined,
                        color: Colors.black,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kbuttoncolour)),
                          onPressed: () =>
                              getImage(source: ImageSource.gallery),
                          child: const Text('Select New Image')),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kbuttoncolour)),
                          onPressed: () => getImage(source: ImageSource.camera),
                          child: const Text('Take New Image')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kbuttoncolour)),
                      onPressed: () {
                        // box.putAt(
                        //     accessKey!,
                        //     StudentModel(
                        //         imagepath: imagePath,
                        //         name: nameController.text,
                        //         age: ageController.text,
                        //         location: placeController.text,
                        //         qualificcation: qualificationController.text));

                        addController.editbox(
                            nameController,
                            ageController,
                            placeController,
                            qualificationController,
                            imagePath,
                            accessKey);
                        Navigator.pop(context);
                      },
                      child: const Text('Submit changes'))
                ],
              ),
            ),
          ),
        ));
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      // setState(() {
      imagePath = (image!.path);
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
        color: Colors.white,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ));
}
