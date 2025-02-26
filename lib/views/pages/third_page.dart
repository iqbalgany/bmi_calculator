import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<Map<String, dynamic>> bmiDataList = [];

  @override
  void initState() {
    super.initState();
    getPrefrence();
  }

  Future<void> getPrefrence() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('bmi_data_list')) {
      final String? storedData = prefs.getString('bmi_data_list');
      if (storedData != null) {
        final List<dynamic> decodedData = jsonDecode(storedData);
        setState(() {
          bmiDataList =
              decodedData.map((e) => Map<String, dynamic>.from(e)).toList();
        });
      }
    }
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
      body: ListView.builder(
        itemCount: bmiDataList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Color(0xff272a4e),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: Offset(4, 4),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BMI : ${bmiDataList[index]['bmi']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'BMI Category : ${bmiDataList[index]['bmi_category']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'BMI Range : ${bmiDataList[index]['bmi_range']}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(),
            ),
          );
        },
      ),
    );
  }
}
