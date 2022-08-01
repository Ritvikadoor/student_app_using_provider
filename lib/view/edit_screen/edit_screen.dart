import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_provider/controllers/providers/provider_home.dart';
import 'package:school_management_provider/models/model_class/data_model.dart';

class ScreenEdit extends StatelessWidget {
  final StudentModel studentmdoel;

  ScreenEdit({Key? key, required this.studentmdoel}) : super(key: key);

  final nameUpdateController = TextEditingController();
  final ageUpdateController = TextEditingController();
  final phoneUpdateController = TextEditingController();
  final placeUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameUpdateController.text = studentmdoel.name;
    ageUpdateController.text = studentmdoel.age;
    phoneUpdateController.text = studentmdoel.phoneNumber;
    placeUpdateController.text = studentmdoel.place;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<FunctionProvider>(
          builder: (context, value, child) {
            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Center(
                    child: Text(
                  'EDIT',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                )),
                CircleAvatar(
                  radius: 80,
                  child: FunctionProvider().imgstring.trim().isEmpty
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: MemoryImage(
                            const Base64Decoder().convert(studentmdoel.imgstri),
                          ),
                        )
                      : Container(
                          color: Colors.white,
                        ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  // initialValue: '$namee',
                  controller: nameUpdateController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // initialValue: '$agee',
                  controller: ageUpdateController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // initialValue: '$phonee',
                  controller: phoneUpdateController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // initialValue: '$placee',
                  controller: placeUpdateController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black87),
                    ),
                    onPressed: () {
                      updateStudent();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Update'))
              ],
            );
          },
        ),
      )),
    );
  }

  Future<void> updateStudent() async {
    final nAme = nameUpdateController.text;
    final aGe = ageUpdateController.text;
    final pHone = phoneUpdateController.text;
    final pLace = placeUpdateController.text;

    if (nAme.isEmpty || aGe.isEmpty || pHone.isEmpty || pLace.isEmpty) {
      return;
    } else {
      final studentup = StudentModel(
          name: nAme,
          age: aGe,
          phoneNumber: pHone,
          place: pLace,
          imgstri: FunctionProvider().imgstring.isEmpty
              ? studentmdoel.imgstri
              : FunctionProvider().imgstring,
          id: studentmdoel.id);
      print(studentup.id);
      if (studentup.id != null) {
        await FunctionProvider().studentupdate(studentup.id!, studentup);
      }
    }
  }
}
