import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String currentLocation;

  const CustomAppBar({super.key, required this.currentLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: AppBar(
        title: Row(
          children: [
            const Icon(
              CupertinoIcons.location_solid,
            ),
            Text(
              currentLocation,
              style: const TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
