import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hivestudent/controller/addcontroller.dart';
import 'package:hivestudent/kconst/const.dart';
import 'package:hivestudent/screens/Student_view.dart';
import 'package:hivestudent/screens/edit.dart';
import 'package:hivestudent/screens/searchscreen.dart';
import 'dart:core';
import 'add_students.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kappbarcolour,
        toolbarHeight: 70,
        title: const Text('Student database'),
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const SearchScreen());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: GetBuilder<Addcontroller>(
          init: Addcontroller(),
          builder: (Addcontroller addController) {
            return Container(
              margin: const EdgeInsets.all(20),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data1 = addController.studentdata[index];
                    //  final image1 = images[index];
                    return ListTile(
                      tileColor: kwhite,
                      onTap: () {
                        Get.to(() => StudentView(obj: data1));
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(() => EditStudent(
                                      obj: data1,
                                      index: index,
                                    ));
                              },
                              icon: const Icon(Icons.edit),
                              color: kblack),
                          IconButton(
                              onPressed: () async {
                                Get.defaultDialog(
                                    middleText: 'It will delete from Database',
                                    title: "Delete",
                                    textConfirm: "delete",
                                    textCancel: "cancel",
                                    onConfirm: () async {
                                      addController.deleteStudent(index);
                                      Get.back();
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 72, 18, 105),
                                    titleStyle:
                                        const TextStyle(color: Colors.white),
                                    middleTextStyle:
                                        const TextStyle(color: Colors.white),
                                    radius: 30);

                                // Dialogbox1(index);
                              },
                              icon: const Icon(Icons.delete),
                              color: const Color.fromARGB(255, 2, 37, 66)),
                        ],
                      ),
                      leading: data1.imagepath == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.green,
                              // backgroundImage: AssetImage(
                              //     'assets/117-1176594_student-learning-education-college-student-vector-png-transparent.png'),
                              radius: 25,
                            )
                          : CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: Image.file(
                                  File(data1.imagepath!),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                      //  CircleAvatar(
                      //     backgroundImage: data1.imagepath ==null?  AssetImage(data1.imagepath)),
                      title: Text(
                        data1.name.toString(),
                        style: const TextStyle(color: ktextcolour),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 10,
                      color: kwhite,
                    );
                  },
                  itemCount: addController.studentdata.length),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kbuttoncolour,
        onPressed: () {
          Get.to(() => AddStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
