import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentidcollage/screens/home/widgets/edit_student.dart';

class FullDetails extends StatelessWidget {
  const FullDetails({
    Key? key,
    required this.name,
    required this.age,
    required this.phone,
    required this.place,
    required this.photo,
    required this.index,
    this.id,
  }) : super(
          key: key,
        );
  final String name;
  final String age;
  final String phone;
  final String place;
  final String photo;
  final int index;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Full Details Of Student',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditStudent(
                        age: age,
                        place: place,
                        index: index,
                        name: name,
                        phone: phone,
                        image: photo,
                        id: id.toString(),
                      )),
            );
          },
          icon: const Icon(
            Icons.edit,
          ),
          label: const Text(
            'Edit',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(File(photo)),
                  ),
                ),
                Text(
                  'Full Name:$name',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Age:$age',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Phone NO:$phone',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Place:$place',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
