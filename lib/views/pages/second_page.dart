import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/third_page.dart';
import 'package:flutter_application_1/views/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  final double bmi;
  final String bmiCategory;
  final String bmiRange;
  const SecondPage({
    super.key,
    required this.bmi,
    required this.bmiCategory,
    required this.bmiRange,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future<void> setPrefrence() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> bmiDataList = [];

    if (prefs.containsKey('bmi_data_list')) {
      final String? storedData = prefs.getString('bmi_data_list');
      if (storedData != null) {
        final List<dynamic> decodedData = jsonDecode(storedData);
        bmiDataList =
            decodedData.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    }

    bmiDataList.add({
      'bmi': widget.bmi.toStringAsFixed(1),
      'bmi_category': widget.bmiCategory,
      'bmi_range': widget.bmiRange,
    });

    await prefs.setString('bmi_data_list', jsonEncode(bmiDataList));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nilai BMI Tersimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e1438),
      appBar: AppBar(
        backgroundColor: Color(0xff12173a),
        leading: Icon(Icons.menu),
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Text(
              'Your Result',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Color(0xff1d1f33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.bmiCategory,
                      style: TextStyle(
                        color: Color(0xff31d384),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 120,
                      ),
                    ),
                    Text(
                      '${widget.bmiCategory} BMI range:',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      '${widget.bmiRange} kg/m2',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'You have a ${widget.bmiCategory} body',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => setPrefrence(),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width - 170,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xff191a2e),
                        ),
                        child: Center(
                          child: Text(
                            'SAVE RESULT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Button(
              text: 'GO TO HISTORY',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPage(),
                  ),
                );
              }),
          // SizedBox(height: 5),
          Button(
              text: 'RE-CALCULATE YOUR BMI',
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
