import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/second_page.dart';
import 'package:flutter_application_1/views/widgets/button.dart';
import 'package:flutter_application_1/views/widgets/gender_widget.dart';
import 'package:flutter_application_1/views/widgets/weight_age_widget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double _height = 100;
  int _weight = 50;
  int selectedIndex = 0;
  double bmi = 0;
  String bmiCategory = "";
  String bmiRange = "";

  void _selectGender(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void calculateBMI() {
    setState(() {
      if (_height > 0) {
        bmi = _weight / ((_height / 100) * (_height / 100));

        if (bmi < 18.5) {
          bmiCategory = "Underweight";
          bmiRange = "< 18.5";
        } else if (bmi >= 18.5 && bmi < 24.9) {
          bmiCategory = "Normal";
          bmiRange = "18.5 - 24.9";
        } else if (bmi >= 25 && bmi < 29.9) {
          bmiCategory = "Overweight";
          bmiRange = "25 - 29.9";
        } else if (bmi >= 30 && bmi < 34.9) {
          bmiCategory = "Obesity I";
          bmiRange = "30 - 34.9";
        } else if (bmi >= 35 && bmi < 39.9) {
          bmiCategory = "Obesity II";
          bmiRange = "35 - 39.9";
        } else {
          bmiCategory = "Obesity III";
          bmiRange = ">= 40";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0e1438),
        appBar: AppBar(
          backgroundColor: Color(0xff12173a),
          leading: Icon(Icons.menu),
          title: Text('BMI CALCULATOR'),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// GENDER
                GestureDetector(
                  onTap: () => _selectGender(1),
                  child: GenderWidget(
                    index: 1,
                    icons: Icons.male,
                    text: 'MALE',
                    selectedIndex: selectedIndex,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _selectGender(2),
                  child: GenderWidget(
                    index: 2,
                    icons: Icons.female,
                    text: 'FEMALE',
                    selectedIndex: selectedIndex,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// HEIGHT
            height(),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// WEIGHT
                  WeightAgeWidget(
                    text: 'WEIGHT',
                    onChanged: (value) {
                      setState(() {
                        _weight = value;
                      });
                    },
                  ),
                  SizedBox(width: 20),

                  /// AGE
                  WeightAgeWidget(
                    text: 'AGE',
                  ),
                ],
              ),
            ),
            Spacer(),

            /// CALCULATE BUTTON
            Button(
                text: 'CALCULATE YOUR BMI',
                onTap: () {
                  calculateBMI();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(
                        bmi: bmi,
                        bmiCategory: bmiCategory,
                        bmiRange: bmiRange,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget height() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff141a3c),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'HEIGHT',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${_height.toInt()}",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'cm',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade700,
                trackHeight: 2.5,
                thumbColor: Colors.pink,
                overlayColor: Colors.pink.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              ),
              child: Slider(
                value: _height,
                min: 0,
                max: 200,
                onChanged: (value) {
                  setState(() {
                    _height = value;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
