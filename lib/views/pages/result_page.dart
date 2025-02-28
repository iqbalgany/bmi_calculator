import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/custom_button.dart';
import 'package:flutter_application_1/views/widgets/custom_drawer.dart';

import '../../services/shared_preference_service.dart';

class ResultPage extends StatefulWidget {
  final double bmi;
  final String bmiCategory;
  final String bmiRange;
  const ResultPage({
    super.key,
    required this.bmi,
    required this.bmiCategory,
    required this.bmiRange,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final BMIService _bmiService = BMIService();

  Future<void> _saveBMI() async {
    await _bmiService.saveBMIData(
        bmi: widget.bmi,
        bmiCategory: widget.bmiCategory,
        bmiRange: widget.bmiRange,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e1438),
      appBar: AppBar(
        backgroundColor: Color(0xff12173a),
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
        elevation: 2,
      ),
      drawer: Drawer(
        child: CustomDrawer(),
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
                borderRadius: BorderRadius.circular(5),
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
                        fontSize: 100,
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
                      'You have a ${widget.bmiCategory} body weight.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _saveBMI(),
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
          CustomButton(
              text: 'RE-CALCULATE\n YOUR BMI',
              onTap: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
