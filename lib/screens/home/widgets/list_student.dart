import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentidcollage/provider/provider_student.dart';
import 'package:studentidcollage/screens/home/widgets/student_full_details.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentIdProvider>(
      builder: (context, studentList, Widget? child) {
        if (studentList.foundStudent.isNotEmpty) {
          return ListView.separated(
            itemBuilder: ((ctx, index) {
              final data = studentList.foundStudent[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                ),
                title: Text(data.name),
                trailing: IconButton(
                  onPressed: () {
                    // deleteStudent(index);
                    StudentIdProvider.deleteItem(
                      context,
                      data.id.toString(),
                    );
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red[900],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => FullDetails(
                            name: data.name,
                            age: data.age,
                            phone: data.phone,
                            place: data.place,
                            photo: data.photo,
                            index: index,
                            id: data.id,
                          )),
                    ),
                  );
                },
              );
            }),
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.foundStudent.length,
          );
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }
}
