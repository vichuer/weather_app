import 'package:weather_app/src/env/keys.dart';

class Apis {
  static String weatherAPIBaseURL = 'http://api.weatherapi.com/v1/';
  static String currentWeather = 'current.json';
  static String forecastWeather = 'forecast.json';

  static String placeAutoComplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=${AuthKeys.locationKey}';

  static String placeDetails =
      'https://maps.googleapis.com/maps/api/place/details/json?key=${AuthKeys.locationKey}';
}
