import 'dart:developer';

import 'package:flutter/material.dart';

class CurrentWeatherTile extends StatelessWidget {
  final bool isMini;
  final String temperature;
  final String icon;
  final String weather;

  const CurrentWeatherTile(
      {super.key,
      required this.isMini,
      required this.temperature,
      required this.icon,
      this.weather = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Image.network(
            icon,
            height: isMini ? 65 : 100,
            width: isMini ? 65 : 100,
            fit: BoxFit.cover,
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isMini)
              Text(
                weather,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: isMini ? 25 : 40,
                    fontWeight: FontWeight.w700),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 3.0),
                          blurRadius: 10.0,
                          color: Color.fromARGB(133, 0, 0, 0),
                        ),
                      ],
                      color: Colors.white,
                      fontSize: isMini ? 48 : 86,
                      fontWeight: isMini ? FontWeight.w700 : FontWeight.w500),
                ),
                Padding(
                  padding: isMini
                      ? const EdgeInsets.only(top: 5)
                      : const EdgeInsets.only(top: 15.0),
                  child: const Text(
                    ' ºC',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
