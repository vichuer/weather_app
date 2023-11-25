import 'package:flutter/material.dart';

class CurrentDetailTile extends StatelessWidget {
  final String type;
  final String value;

  const CurrentDetailTile({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/$type.png'),
        Text(
          type.toUpperCase(),
          style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5),
        ),
      ],
    );
  }
}
