import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:school_management_provider/controllers/providers/provider_home.dart';
import 'package:school_management_provider/models/model_class/data_model.dart';
import 'package:school_management_provider/view/home_screen/screen_home.dart';

class ScreenEdit extends StatelessWidget {
  final StudentModel studentmdoel;

  ScreenEdit({Key? key, required this.studentmdoel}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
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
                Form(
                  key: _formkey,
                  child: const Center(
                      child: Text(
                    'EDIT',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  )),
                ),
                Center(
                  child: ClipOval(child: imageprofile(context)),
                ),
                // Stack(
                //   children: [
                //     value.imgstring.trim().isEmpty
                //         ? Image.asset(
                //             "lib/res/images/add_screen_profile_pic.webp",
                //             fit: BoxFit.contain,
                //             height: 250,
                //             width: 250,
                //           )
                //         : Image.memory(
                //             const Base64Decoder().convert(value.imgstring),
                //             width: 250,
                //             height: 250,
                //             fit: BoxFit.cover,
                //           ),
                //     Positioned(
                //       left: 50,
                //       right: 50,
                //       top: 170,
                //       bottom: 0,
                //       // padding: const EdgeInsets.only(top: 150, left: 150),
                //       child: IconButton(
                //           onPressed: () {
                //             showBottomSheet(
                //                 context: context,
                //                 builder: (BuildContext context) {
                //                   return Text('hey');
                //                 });
                //           },
                //           icon: const Icon(
                //             Icons.camera_alt,
                //             color: Colors.black,
                //             size: 40,
                //           )),
                //     )
                //   ],
                // ),

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
                      updateStudent(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx1) => ScreenHome(),
                        ),
                      );
                    },
                    child: const Text('Update'))
              ],
            );
          },
        ),
      )),
    );
  }

  Widget imageprofile(BuildContext context) {
    return Consumer<FunctionProvider>(
      builder: (context, value, child) => Stack(
        children: [
          value.imgstring.trim().isNotEmpty
              ? CircleAvatar(
                  radius: 100,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(value.imgstring),
                  ),
                )
              : CircleAvatar(
                  radius: 100,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(studentmdoel.imgstri),
                  ),
                ),
          Positioned(
            left: 50,
            right: 50,
            top: 110,
            bottom: 0,
            // padding: const EdgeInsets.only(top: 150, left: 150),
            child: IconButton(
                onPressed: () {
                  showBottomSheet(context);
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 40,
                )),
          )
        ],
      ),
      // builder: (context, value, child) => Stack(
      //   children: [
      //     value.imgstring.trim().isNotEmpty
      // ? CircleAvatar(
      //     radius: 50,
      //     backgroundImage: MemoryImage(
      //       const Base64Decoder().convert(value.imgstring),
      //     ),
      //   )
      // : CircleAvatar(
      //     radius: 50,
      //     backgroundImage: MemoryImage(
      //       const Base64Decoder().convert(studentmdoel.imgstri),
      //     ),
      //   ),
      //     Positioned(
      //       left: 50,
      //       right: 50,
      //       top: 170,
      //       bottom: 0,
      //       // padding: const EdgeInsets.only(top: 150, left: 150),
      //       child: IconButton(
      //           onPressed: () {
      //             showBottomSheet(context);
      //           },
      //           icon: const Icon(
      //             Icons.camera_alt,
      //             color: Colors.black,
      //             size: 40,
      //           )),
      //     )
      //   ],
      // ),
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
          child: Column(children: [
            const Text('choise your profile photo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      takecamera(context);
                    },
                    icon: const Icon(Icons.camera)),
                IconButton(
                    onPressed: () {
                      takePhoto(context);
                    },
                    icon: const Icon(Icons.browse_gallery))
              ],
            )
          ]),
        );
      },
    );
  }

  Future<void> takePhoto(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageTemprary = File(image.path);
    final bayts = File(image.path).readAsBytesSync();
    String encode = base64Encode(bayts);

    context.read<FunctionProvider>().imgstring = encode;
    context.read<FunctionProvider>().changeImage(encode);
  }

  Future<void> takecamera(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageTemprary = File(image.path);

    final bayts = File(image.path).readAsBytesSync();
    String encode = base64Encode(bayts);

    context.read<FunctionProvider>().imgstring = encode;
    context.read<FunctionProvider>().changeImage(encode);
  }

  Future<void> updateStudent(BuildContext context) async {
    final nAme = nameUpdateController.text;
    final aGe = ageUpdateController.text;
    final pHone = phoneUpdateController.text;
    final pLace = placeUpdateController.text;

    if (context.read<FunctionProvider>().imgstring.isEmpty) {
      context.read<FunctionProvider>().imgstring = studentmdoel.imgstri;
    }

    if (nAme.isEmpty || aGe.isEmpty || pHone.isEmpty || pLace.isEmpty) {
      return;
    } else {
      final studentup = StudentModel(
          name: nAme,
          age: aGe,
          phoneNumber: pHone,
          place: pLace,
          imgstri: context.read<FunctionProvider>().imgstring,
          id: studentmdoel.id);
      print(studentup.id);
      if (studentup.id != null) {
        await FunctionProvider().studentupdate(studentup.id!, studentup);
        await Provider.of<FunctionProvider>(_formkey.currentContext!,
                listen: false)
            .studentupdate(studentup.id!, studentup);
      }
    }
  }
}
