import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentidcollage/db/functions/db_functions.dart';
import 'package:studentidcollage/db/model/data_model.dart';

class StudentIdProvider with ChangeNotifier {
  final List<StudentModel> studentList = DbFunctions.studentList;

  File? photos;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);

      photos = photoTemp;
    }
    notifyListeners();
  }

  List<StudentModel> foundStudent = [];
  Future<void> getAllStudents() async {
    final students = await DbFunctions().getAllStudents();
    foundStudent = students;

    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    List<StudentModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = studentList;
    } else {
      results = studentList
          .where(
            (user) => user.name.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
      log('success');
    }

    foundStudent = results;
    notifyListeners();
  }

  static deleteItem(BuildContext context, String id) async {
    log("called");
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const Text('Are you sure want to delete this ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Provider.of<DbFunctions>(context, listen: false)
                      .deleteStudent(id);
                  Provider.of<StudentIdProvider>(context, listen: false)
                      .getAllStudents();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Successfully deleted'),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.of(context).pop();
                },
                child: const Text('Yes')),
          ],
        );
      },
    );
  }
}
