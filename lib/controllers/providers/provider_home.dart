import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:school_management_provider/models/model_class/data_model.dart';

class FunctionProvider with ChangeNotifier {
  FunctionProvider() {
    getallStudents();
  }
  final List<StudentModel> studentlistNotifier = [];

  void addStudent(StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    final _id = await studentDb.add(value);
    value.id = _id;
    await studentDb.put(value.id, value);
    await getallStudents();
    // print('object');
  }

  getallStudents() async {
    // print('Getting datas');
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    studentlistNotifier.clear();
    studentlistNotifier.addAll(studentDb.values.toList());
    notifyListeners();
  }

  deleteStudent(int id) async {
    print('deleting ui');
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.delete(id);
    getallStudents();
  }

  studentupdate(int id, StudentModel value) async {
    final studentDb = await Hive.openBox<StudentModel>('student_db');
    await studentDb.put(id, value);
    getallStudents();

    notifyListeners();
  }

  String imgstring = '';

  File? imageFile;
  changeImage(String imgstring) {
    this.imgstring = imgstring;
    notifyListeners();
  }
}
