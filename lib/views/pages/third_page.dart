import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/first_page.dart';
import 'package:flutter_application_1/views/widgets/custom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List<Map<String, dynamic>> bmiDataList = [];
  bool isDescending = true;

  @override
  void initState() {
    super.initState();
    getPreference();
  }

  Future<void> getPreference() async {
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

  Future<void> removeData(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(
                  color: Color(0xffff0067),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

                final String? storedData = prefs.getString('bmi_data_list');
                List<dynamic> bmiDataList = jsonDecode(storedData!);

                bmiDataList.removeAt(index);
                await prefs.setString('bmi_data_list', jsonEncode(bmiDataList));

                setState(() {
                  this.bmiDataList = bmiDataList
                      .map((e) => Map<String, dynamic>.from(e))
                      .toList();
                });
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Color(0xffff0067),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void sortData(bool descending) {
    setState(() {
      bmiDataList.sort(
        (a, b) {
          DateTime timeA = DateTime.parse(a['timestamp']);
          DateTime timeB = DateTime.parse(b['timestamp']);

          return descending ? timeB.compareTo(timeA) : timeA.compareTo(timeB);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e1438),
      appBar: AppBar(
        backgroundColor: Color(0xff12173a),
        title: Text('BMI CALCULATOR'),
        actions: [
          IconButton(
            icon:
                Icon(isDescending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                isDescending = !isDescending;
                sortData(isDescending);
              });
            },
          ),
        ],
        centerTitle: true,
        elevation: 2,
      ),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      body: ListView.builder(
        itemCount: bmiDataList.length,
        itemBuilder: (context, index) {
          final item = bmiDataList[index];
          final DateTime timestamp = DateTime.parse(item['timestamp']);
          final String formattedDate =
              DateFormat('EEEE, d MMMM yyyy HH:mm', 'en_US').format(timestamp);
          return GestureDetector(
            onLongPress: () => removeData(index),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, 20, 20, index == bmiDataList.length - 1 ? 20 : 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color(0xff272a4e),
                        borderRadius: BorderRadius.circular(5),
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'BMI : ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${item['bmi']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'BMI Category : ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${item['bmi_category']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffff0067),
        child: Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => FirstPage(),
            ),
          );
        },
      ),
    );
  }
}
