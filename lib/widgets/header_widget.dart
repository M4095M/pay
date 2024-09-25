import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  HeaderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.deepPurple,
      child: Row(
        children: [
          Icon(Icons.attach_money, color: Colors.white, size: 32),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
        ],
      ),
    );
  }
}
