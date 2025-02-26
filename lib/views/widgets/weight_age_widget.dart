import 'dart:async';

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
  Timer? _timer;

  void _increment() {
    setState(() {
      number++;
    });
    widget.onChanged?.call(number);
  }

  void _decrement() {
    if (number > 0) {
      setState(() {
        number--;
      });
    }
    widget.onChanged?.call(number);
  }

  void _startIncrementing() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _increment();
    });
  }

  void _startDecrementing() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      _decrement();
    });
  }

  void _stopCounting() {
    _timer?.cancel();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Text(
            "$number",
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (_) => _startIncrementing(),
                onTapUp: (_) => _stopCounting(),
                onTapCancel: _stopCounting,
                child: Container(
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
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTapDown: (_) => _startDecrementing(),
                onTapUp: (_) => _stopCounting(),
                onTapCancel: _stopCounting,
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
