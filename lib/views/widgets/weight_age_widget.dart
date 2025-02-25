import 'package:flutter/material.dart';

class WeightAgeWidget extends StatefulWidget {
  final String text;
  final int number;
  final Function(int)? onChanged;
  const WeightAgeWidget({
    super.key,
    required this.text,
    this.number = 50,
    this.onChanged,
  });

  @override
  State<WeightAgeWidget> createState() => _WeightAgeWidgetState();
}

class _WeightAgeWidgetState extends State<WeightAgeWidget> {
  late int number = widget.number;

  void _increment() {
    setState(() {
      number++;
    });
    widget.onChanged?.call(number);
  }

  void _decrement() {
    setState(() {
      number--;
    });
    widget.onChanged?.call(number);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 150,
      decoration: BoxDecoration(
        color: Color(0xff141a3c),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Text(
            "${number}",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff272a4e),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => _increment(),
                  icon: Icon(
                    Icons.add,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff272a4e),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () => _decrement(),
                  icon: Icon(
                    Icons.remove,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
