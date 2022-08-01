import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:school_management_provider/controllers/providers/provider_home.dart';
import 'package:school_management_provider/models/model_class/data_model.dart';
import 'package:school_management_provider/view/edit_screen/edit_screen.dart';

class ScreenStudentDetails extends StatelessWidget {
  final StudentModel studentmodel;

  const ScreenStudentDetails({required this.studentmodel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              'DETAILS',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 100,
              child: FunctionProvider().imgstring.trim().isEmpty
                  ? CircleAvatar(
                      radius: 100,
                      backgroundImage: MemoryImage(
                        const Base64Decoder().convert(studentmodel.imgstri),
                      ),
                    )
                  : Container(
                      child: Image.asset(""),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 219, 219, 219),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Name : ${studentmodel.name}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Age: ${studentmodel.age}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Phone: ${studentmodel.phoneNumber}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Place: ${studentmodel.place}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 60, right: 60, top: 10),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ScreenEdit(
                                      studentmdoel: studentmodel,
                                    )));
                          },
                          child: const Text('Edit')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
