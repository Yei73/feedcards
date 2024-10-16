import 'package:flutter/material.dart';

class Titlecard extends StatelessWidget {
  const Titlecard({super.key, required this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text("Y"),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 22, 22, 22),
          ),
        )
      ],
    );
  }
}
