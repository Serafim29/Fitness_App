import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/lab3_data.dart';

class Lab3Repository {
  Future<Lab3Data> load() async {
    final source = await rootBundle.loadString('assets/data/lab3.json');
    final decoded = jsonDecode(source) as Map<String, dynamic>;
    return Lab3Data.fromJson(decoded);
  }
}
