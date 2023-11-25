import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/src/models/location_model.dart';

import '../services/db_helper.dart';

class SaveLocationProvider extends ChangeNotifier {
  List<LocationModel> savedLocations = [];

  //Fetch all saved weather data
  Future getSavedLocations() async {
    final dataList = await DBHelper.selectProduct();
    savedLocations = dataList
        .map((item) => LocationModel(
            location: item['location'],
            weather: item['weather'],
            humidity: item['humidity'],
            wind: item['wind'],
            temperature: item['temperature'],
            weatherImage: item['weatherImage']))
        .toList();

    log(savedLocations.toString());
    notifyListeners();
  }

  //Save new location's weather data
  Future saveNewLocation(
      location, weather, humidity, wind, temperature, weatherImage) async {
    DBHelper.database();
    final newLocation = LocationModel(
        location: '$location',
        weather: '$weather',
        humidity: '$humidity',
        wind: '$wind',
        temperature: '$temperature',
        weatherImage: '$weatherImage');

    await DBHelper.insert(DBHelper.savedLocations, {
      'location': newLocation.location,
      'weather': newLocation.weather,
      'humidity': newLocation.humidity,
      'wind': newLocation.wind,
      'temperature': newLocation.temperature,
      'weatherImage': newLocation.weatherImage,
    });
    notifyListeners();
  }
}
