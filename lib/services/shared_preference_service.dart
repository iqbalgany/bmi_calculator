import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/bmi_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIService {
  Future<void> saveBMIData({
    required double bmi,
    required String bmiCategory,
    required String bmiRange,
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    List<BMIHistory> bmiDataList = [];

    if (prefs.containsKey('bmi_data_list')) {
      final String? storedData = prefs.getString('bmi_data_list');
      if (storedData != null) {
        final List<dynamic> decodedData = jsonDecode(storedData);
        bmiDataList = decodedData.map((e) => BMIHistory.fromJson(e)).toList();
      }
    }

    bmiDataList.add(
      BMIHistory(
        bmi: bmi,
        bmiCategory: bmiCategory,
        bmiRange: bmiRange,
        timestamp: DateTime.now().toLocal(),
      ),
    );

    await prefs.setString('bmi_data_list', jsonEncode(bmiDataList));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nilai BMI Tersimpan'),
        duration: Duration(milliseconds: 100),
      ),
    );
  }

  Future<List<BMIHistory>> loadBMIData() async {
    final prefs = await SharedPreferences.getInstance();
    List<BMIHistory> bmiDataList = [];

    if (prefs.containsKey('bmi_data_list')) {
      final String? storedData = prefs.getString('bmi_data_list');
      if (storedData != null) {
        final List<dynamic> decodedData = jsonDecode(storedData);

        bmiDataList = decodedData.map((e) => BMIHistory.fromJson(e)).toList();
      }
    }

    return bmiDataList;
  }

  Future<void> removeBMIData({required int index}) async {
    final prefs = await SharedPreferences.getInstance();

    final String? storedData = prefs.getString('bmi_data_list');
    List<BMIHistory> bmiDataList = (jsonDecode(storedData!) as List)
        .map((e) => BMIHistory.fromJson(e))
        .toList();

    bmiDataList.removeAt(index);
    await prefs.setString(
      'bmi_data_list',
      jsonEncode(bmiDataList.map((e) => e.toJson()).toList()),
    );
  }

  List<BMIHistory> sortBMIData(List<BMIHistory> bmiDataList, bool descending) {
    bmiDataList.sort(
      (a, b) {
        return descending
            ? b.timestamp.compareTo(a.timestamp)
            : a.timestamp.compareTo(b.timestamp);
      },
    );

    return bmiDataList;
  }
}
