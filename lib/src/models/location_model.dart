class LocationModel {
  final int? id;
  final String location;
  final String weather;
  final String humidity;
  final String wind;
  final String temperature;
  final String weatherImage;

  LocationModel(
      {this.id,
      required this.location,
      required this.weather,
      required this.humidity,
      required this.wind,
      required this.temperature,
      required this.weatherImage});
}
