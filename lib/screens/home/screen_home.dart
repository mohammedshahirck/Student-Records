import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentidcollage/provider/provider_student.dart';
import 'package:studentidcollage/screens/home/widgets/add_student.dart';
import 'package:studentidcollage/screens/home/widgets/list_student.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentIdProvider>(context, listen: false).getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Student Database',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FloatingActionButton.extended(
            icon: const Icon(
              Icons.add,
            ),
            backgroundColor: Colors.deepPurple,
            label: const Text(
              'Add new Student',
            ),
            onPressed: () {
              Navigator.of(
                context,
              ).push(
                MaterialPageRoute(
                  builder: (
                    context,
                  ) =>
                      AddStudent(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Consumer(
              builder: (context, StudentIdProvider value, Widget? child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CupertinoSearchTextField(
                    padding: const EdgeInsets.all(20),
                    itemColor: Colors.black,
                    backgroundColor: Colors.blue[60],
                    controller: searchController,
                    onChanged: (value) {
                      Provider.of<StudentIdProvider>(context, listen: false)
                          .runFilter(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListStudent(
                    controller: searchController,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
