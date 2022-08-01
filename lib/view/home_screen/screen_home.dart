import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_provider/controllers/providers/provider_home.dart';
import 'package:school_management_provider/view/add_screen/add_screen.dart';
import 'package:school_management_provider/view/student_details/student_details_screen.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = FunctionProvider().notifyListeners();
    print('runnning or not check');
    return ChangeNotifierProvider(
      create: (context) {
        FunctionProvider();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: Consumer<FunctionProvider>(
            builder: (BuildContext context, newValue, Widget? child) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = newValue.studentlistNotifier[index];
                    // print("lololololo${data.imgstri}");
                    return ListTile(
                      title: Text(data.name),
                      subtitle: Text(data.age),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            MemoryImage(Base64Decoder().convert(data.imgstri)),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  dialogShow(context, data.id!));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ScreenStudentDetails(
                                  studentmodel: data,
                                )));
                      },
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider();
                  },
                  itemCount: newValue.studentlistNotifier.length);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: const Text('ADD'),
          backgroundColor: Colors.black87,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) {
                return ScreenAdd();
              }),
            );
            context.read<FunctionProvider>().imgstring = '';
          },
        ),
      ),
    );
  }

  dialogShow(BuildContext context, int id) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
        TextButton(
            onPressed: () {
              Provider.of<FunctionProvider>(context, listen: false)
                  .deleteStudent(id);
              Navigator.of(context).pop();
            },
            child: Icon(Icons.delete))
      ]),
    );
  }
}
