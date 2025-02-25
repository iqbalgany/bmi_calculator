import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  final IconData icons;
  final String text;
  final int index;
  final int selectedIndex;
  const GenderWidget({
    super.key,
    required this.icons,
    required this.text,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == selectedIndex;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xff272a4e),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              size: 100,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
