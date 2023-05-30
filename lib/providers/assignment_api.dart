import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/assignment.dart';

class AssignmentApi with ChangeNotifier {
  List<Assignment> _allAssignment = [];

  bool _resultVisible = false;

  bool get resultVisible {
    return _resultVisible;
  }

  List<Assignment> get allAssignment {
    return _allAssignment;
  }

  void onVisible(bool a) {
    _resultVisible = a;
  }

  Future<void> getAssignments() async {
    Uri url = Uri.parse('https://calms.pythonanywhere.com/assignments/');
    final response = await http.get(url);
    List data = jsonDecode(response.body);
    _allAssignment = data.map((e) => Assignment.getAssignment(e)).toList();

    notifyListeners();
  }
}
