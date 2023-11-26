import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/models/forecast_weather_model.dart';

class ForecastTileSingle extends StatelessWidget {
  final Forecastday forecastday;

  const ForecastTileSingle({super.key, required this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          DateFormat('MMM dd').format(forecastday.date ?? DateTime.now()),
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Image.network(
          'httpS:${forecastday.day!.condition!.icon ?? ""}',
          height: 55,
        ),
        Column(
          children: [
            Text(
              '${forecastday.day!.avgtempC!.toStringAsFixed(0)}º',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${forecastday.day!.maxwindKph!}\nkm/h',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
