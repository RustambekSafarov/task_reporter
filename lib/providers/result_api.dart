import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/result.dart';

class ResultApi with ChangeNotifier {
  List<Result> _allResults = [];
  List<Result> get allResult {
    return [..._allResults];
  }

  Future<List<Result>> getResult(String assingmentName) async {
    Uri url = Uri.parse('https://calms.pythonanywhere.com/reporter/?assignment_name=$assingmentName');
    http.Response response = await http.get(url);
    List dataFromJson = jsonDecode(response.body) ?? [];
    print(dataFromJson.runtimeType);
    _allResults = dataFromJson.map<Result>((data) => Result.getResult(data)).toList();
    print(_allResults);
    return dataFromJson.map<Result>((data) => Result.getResult(data)).toList();
    // notifyListeners();
  }
}
