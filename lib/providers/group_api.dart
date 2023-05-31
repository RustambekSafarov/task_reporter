import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_reporter/models/group.dart';
import 'package:http/http.dart' as http;

class GroupApi with ChangeNotifier {
  List<Group> _allGroups = [];
  List<Group> get allGroups => _allGroups;
  Future<void> getGroups() async {
    Uri url = Uri.parse('https://calms.pythonanywhere.com/students/groups/');
    http.Response response = await http.get(url);
    List dataFromJson = jsonDecode(response.body);
    _allGroups = dataFromJson.map((e) => Group.fromJson(e)).toList();
  }
}
