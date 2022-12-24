import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hivestudent/controller/controller.dart';
import 'package:hivestudent/kconst/const.dart';

SearchController searchcontroller = Get.put(SearchController());

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (searchcontroller) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        searchcontroller.searchStudent(value);
                      },
                      //    ...,other fields
                      controller: searchcontroller.searchcontroller1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        label: const Text(
                          'search',
                          style: TextStyle(color: kwhite),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.purple.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.purple.shade800),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Container(
                        child: searchcontroller
                                .searchcontroller1.text.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  final data1 =
                                      searchcontroller.searchedstudent[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ListTile(
                                      tileColor: kwhite,
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
                                      title: Text(data1.name),
                                    ),
                                  );
                                },
                                itemCount:
                                    searchcontroller.searchedstudent.length,
                              )
                            : const Center(
                                child: Text('Search Anything',
                                    style: TextStyle(color: kwhite)),
                              )))
              ],
            );
          },
        ));
  }
}
