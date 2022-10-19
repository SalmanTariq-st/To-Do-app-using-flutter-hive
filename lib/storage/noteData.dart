// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class noteData {
  List notes = [];

  final box = Hive.box('note');

  void loadData() {
    notes = box.get('note');
  }

  void createInitialData() {
    notes = [
      ['Exercise', true],
      ['Learn', true],
    ];
  }

  void updateDatabase() {
    box.put('note', notes);
  }
}
