import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/bmi_history_model.dart';
import 'package:flutter_application_1/services/shared_preference_service.dart';
import 'package:flutter_application_1/views/pages/calculate_page.dart';
import 'package:flutter_application_1/views/pages/result_page.dart';
import 'package:flutter_application_1/views/widgets/custom_drawer.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final BMIService _bmiService = BMIService();
  List<BMIHistory> bmiDataList = [];
  bool isDescending = true;

  @override
  void initState() {
    super.initState();
    _loadBMIData();
  }

  Future<void> _loadBMIData() async {
    List<BMIHistory> data = await _bmiService.loadBMIData();
    setState(() {
      bmiDataList = data;
    });
  }

  void _sortData(bool descending) {
    setState(() {
      bmiDataList = _bmiService.sortBMIData(bmiDataList, descending);
    });
  }

  Future<void> _removeData(int index) async {
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
                await _bmiService.removeBMIData(index: index);

                _loadBMIData();
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
                _sortData(isDescending);
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
          final DateTime timestamp = item.timestamp;
          final String formattedDate =
              DateFormat('EEEE, d MMMM yyyy HH:mm', 'id_ID').format(timestamp);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmi: item.bmi,
                      bmiCategory: item.bmiCategory,
                      bmiRange: item.bmiRange,
                    ),
                  ));
            },
            onLongPress: () => _removeData(index),
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
                                '${item.bmi}',
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
                                item.bmiCategory,
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
              builder: (context) => CalculatePage(),
            ),
          );
        },
      ),
    );
  }
}
