import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_reporter/models/student.dart';
import 'package:http/http.dart' as http;

class StudentApi with ChangeNotifier {
  List<Student> _students = [];
  List<Student> get students => _students;
  Future<void> getStudents() async {
    Uri url = Uri.parse('https://calms.pythonanywhere.com/students/');
    http.Response response = await http.get(url);
    List dataFromJson = jsonDecode(response.body);
    _students = dataFromJson.map((e) => Student.getStudent(e)).toList();
    // print(_students);
    notifyListeners();
  }
}
