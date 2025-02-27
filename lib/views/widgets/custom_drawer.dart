import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/pages/first_page.dart';
import 'package:flutter_application_1/views/pages/third_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 200,
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/profile_image.jpeg',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Muhammad Iqbal Al Afgany',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text('qwertyuiop@gmail.com')
            ],
          ),
        ),
        Divider(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => FirstPage(),
              ),
            );
          },
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('HOME'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ThirdPage(),
              ),
            );
          },
          child: ListTile(
            leading: Icon(Icons.history),
            title: Text('HISTORY'),
          ),
        ),
      ],
    );
  }
}
