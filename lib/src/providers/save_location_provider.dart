import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/src/env/apis.dart';
import 'package:weather_app/src/env/keys.dart';
import 'package:weather_app/src/models/auto_complete_model.dart';
import 'package:weather_app/src/models/current_weather_model.dart';
import 'package:weather_app/src/models/location_detail_model.dart';
import 'package:weather_app/src/models/location_model.dart';
import 'package:weather_app/src/services/api_service.dart';

import '../services/db_helper.dart';

class SaveLocationProvider extends ChangeNotifier {
  List<LocationModel> savedLocations = [];

  LocationAutoCompleteModel locationAutoCompleteModel =
      LocationAutoCompleteModel();
  List<Prediction> searchResults = [];
  bool searchLocationLoading = false;
  String selectedLocationTemp = '';

  LocationDeatailModel locationDeatailModel = LocationDeatailModel();
  CurrentWeatherModel currentWeatherModel = CurrentWeatherModel();
  bool currentWeatherLoading = false;

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
            weatherImage: item['weatherImage'],
            lat: item['lat'],
            long: item['long']))
        .toList();

    log(savedLocations.toString());
    notifyListeners();
  }

  //Save new location's weather data
  Future saveNewLocation(location, weather, humidity, wind, temperature,
      weatherImage, lat, long) async {
    DBHelper.database();
    final newLocation = LocationModel(
        location: '$location',
        weather: '$weather',
        humidity: '$humidity',
        wind: '$wind',
        temperature: '$temperature',
        weatherImage: '$weatherImage',
        lat: '$lat',
        long: '$long');

    await DBHelper.insert(DBHelper.savedLocations, {
      'location': newLocation.location,
      'weather': newLocation.weather,
      'humidity': newLocation.humidity,
      'wind': newLocation.wind,
      'temperature': newLocation.temperature,
      'weatherImage': newLocation.weatherImage,
      'lat': newLocation.lat,
      'long': newLocation.long
    });
    notifyListeners();
  }

  searchLocation(String keyword) async {
    searchLocationLoading = true;
    notifyListeners();
    var data = {"input": keyword};
    await ApiService.apiMethodSetup(
            method: ApiMethod.get,
            url: Apis.placeAutoComplete,
            baseURL: '',
            data: data)
        .then((response) {
      if (response != null) {
        var json = response.data;
        log(json.toString());
        if (json['predictions'].isNotEmpty) {
          locationAutoCompleteModel = LocationAutoCompleteModel.fromJson(json);
          searchResults = locationAutoCompleteModel.predictions!;
          notifyListeners();
        }
      }

      searchLocationLoading = false;
      notifyListeners();
    });
  }

  clearSearchResults() {
    searchResults.clear();
    notifyListeners();
  }

  getLocationWeather() async {
    currentWeatherLoading = true;
    notifyListeners();
    var data = {"place_id": selectedLocationTemp};
    await ApiService.apiMethodSetup(
            method: ApiMethod.get,
            url: Apis.placeDetails,
            baseURL: '',
            data: data)
        .then((response) {
      if (response != null) {
        clearSearchResults();
        var json = response.data;
        locationDeatailModel = LocationDeatailModel.fromJson(json);
        getCurrentWeather(
            locationDeatailModel.result!.geometry!.location!.lat.toString(),
            locationDeatailModel.result!.geometry!.location!.lng.toString());
      }
    });
  }

  getCurrentWeather(String lat, String long) async {
    var data = {"key": AuthKeys.weatherAPiKey, "q": "$lat,$long"};

    await ApiService.apiMethodSetup(
            method: ApiMethod.get,
            url: Apis.weatherAPIBaseURL + Apis.currentWeather,
            baseURL: Apis.weatherAPIBaseURL,
            data: data)
        .then((response) {
      if (response != null) {
        var json = response.data;

        currentWeatherModel = CurrentWeatherModel.fromJson(json);

        currentWeatherLoading = false;
        notifyListeners();
      }
    });
  }
}
