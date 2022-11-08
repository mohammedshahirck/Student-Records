// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentidcollage/provider/provider_student.dart';
import '../../../db/functions/db_functions.dart';
import '../../../db/model/data_model.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  bool imageAlert = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentIdProvider =
        Provider.of<StudentIdProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      studentIdProvider.photos = null;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text('Fill The Details'),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<StudentIdProvider>(
                    builder: (context, value, Widget? child) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: value.photos == null
                              ? const CircleAvatar(
                                  backgroundColor: Colors.black38,
                                  radius: 60,
                                  child: Icon(
                                    Icons.image,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(
                                      value.photos!.path,
                                    ),
                                  ),
                                  radius: 60,
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          studentIdProvider.getPhoto();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Full Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Age'),
                    validator: (
                      value,
                    ) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Age ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone Number';
                      } else if (value.length != 10) {
                        return 'Enter valid Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _placeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Place'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Place ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // studentIdProvider;
                      if (_formKey.currentState!.validate() &&
                          studentIdProvider.photos != null) {
                        // Provider.of<StudentIdProvider>(context, listen: false);
                        onAddStudentButtonClicked(context);
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(ctx) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phone = _phoneNumberController.text.trim();
    final place = _placeController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        phone.isEmpty ||
        place.isEmpty ||
        Provider.of<StudentIdProvider>(ctx, listen: false)
            .photos!
            .path
            .isEmpty) {
      return;
    }

    final student = StudentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        age: age,
        phone: phone,
        place: place,
        photo: Provider.of<StudentIdProvider>(ctx, listen: false).photos!.path);

    Provider.of<DbFunctions>(ctx, listen: false).addStudent(student);
    Provider.of<DbFunctions>(ctx, listen: false).getAllStudents();
    //   Navigator.of(ctx).pop();
  }

  // File? _photo;
  // Future<void> getPhoto() async {
  //   final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (photo == null) {
  //     return;
  //   } else {
  //     final photoTemp = File(photo.path);
  //     setState(
  //       () {
  //         _photo = photoTemp;
  //       },
  //     );
  //   }
  // }
}
