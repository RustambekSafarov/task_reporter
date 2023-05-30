import 'package:flutter/material.dart';

import '../models/result.dart';

class ResultApi with ChangeNotifier {
  List<Result> _allResults = [];
  List<Result> get allResult {
    return [..._allResults];
  }

  Future<void> getResult() async {}
}
