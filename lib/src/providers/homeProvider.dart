import 'package:flutter/cupertino.dart';
import 'package:location/location.dart' as loc;
import 'package:weather_app/src/models/forecast_weather_model.dart';
import 'package:weather_app/src/services/sharedpreference_service.dart';

import '../env/apis.dart';
import '../env/keys.dart';
import '../services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  ForecastWeatherModel currentWeatherModel = ForecastWeatherModel();
  loc.LocationData? pos;
  String bgImage = '';

  //get users live location
  Future getCurrentLocation() async {
    loc.Location location = loc.Location();
    pos = await location.getLocation();

    if (SharedPreferencesService.prefs.getString('lat') == null ||
        SharedPreferencesService.prefs.getString('long') == null) {
      SharedPreferencesService.prefs.setString('lat', pos!.latitude.toString());
      SharedPreferencesService.prefs
          .setString('long', pos!.longitude.toString());
      getForecastWeather(pos!.latitude.toString(), pos!.longitude.toString());
    } else {
      getForecastWeather(SharedPreferencesService.prefs.getString('lat') ?? "0",
          SharedPreferencesService.prefs.getString('long') ?? "0");
    }
    bgImage = SharedPreferencesService.prefs.getString('bgImage') ?? "";
  }

  //get weather data for provided details
  getForecastWeather(String lat, String long) async {
    var data = {"key": AuthKeys.weatherAPiKey, "q": "$lat,$long", "days": "5"};

    await ApiService.apiMethodSetup(
            method: ApiMethod.get,
            url: Apis.weatherAPIBaseURL + Apis.forecastWeather,
            baseURL: Apis.weatherAPIBaseURL,
            data: data)
        .then((response) {
      if (response != null) {
        var json = response.data;

        currentWeatherModel = ForecastWeatherModel.fromJson(json);

        // currentWeatherLoading = false;
        getBG(currentWeatherModel.location!.region ?? "");
        notifyListeners();
      }
    });
  }

  //get background image
  getBG(String query) async {
    var data = {
      'query': query,
      'per_page': 1,
      'orientation': 'portrait',
      'page': 1,
    };

    await ApiService.apiMethodSetup(
            method: ApiMethod.get,
            url: Apis.pexelsApi,
            baseURL: '',
            token: AuthKeys.pexelsKey,
            data: data)
        .then((response) {
      if (response != null) {
        var json = response.data;

        String url = json['photos'][0]['src']['large2x'];
        bgImage = url;
        notifyListeners();
        SharedPreferencesService.prefs.setString('bgImage', url);
      }
    });
  }
}
