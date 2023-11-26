import 'package:flutter/material.dart';
import 'package:weather_app/src/models/forecast_weather_model.dart';

import 'forecast_tile_single.dart';

class ForecastTile extends StatelessWidget {
  final List<Forecastday> forecastWeather;

  const ForecastTile({super.key, required this.forecastWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var elements in forecastWeather)
            ForecastTileSingle(
              forecastday: elements,
            )
        ],
      ),
    );
  }
}
