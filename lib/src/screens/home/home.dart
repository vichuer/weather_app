import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/providers/homeProvider.dart';
import 'package:weather_app/src/screens/saved_locations/saved_locations.dart';
import 'package:weather_app/src/screens/widgets/loader.dart';
import '../widgets/custom_app_bar.dart';
import 'widgets/current_detail_tile.dart';
import 'widgets/current_weather_tile.dart';
import 'widgets/forecast_tile.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeProvider = HomeProvider();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.getCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //  backgroundColor: const Color.fromARGB(255, 34, 10, 62),
      endDrawer: const SavedLocations(),
      body: Stack(
        children: [
          Image.asset(
            'assets/dummy_bg.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.6),
            colorBlendMode: BlendMode.darken,
          ),
          if (homeProvider.bgImage.isNotEmpty)
            Image.network(
              homeProvider.bgImage,
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          if (homeProvider.currentWeatherModel.location != null)
            CustomAppBar(
              currentLocation:
                  homeProvider.currentWeatherModel.location!.name ?? "",
            ),
          if (homeProvider.currentWeatherModel.current != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('MMMM dd').format(DateTime.parse(
                              homeProvider
                                  .currentWeatherModel.location!.localtime!
                                  .split(' ')
                                  .first)),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        ),
                        Text(
                          'Updated as of ${DateFormat('dd/M/y hh:mm a').format(DateTime.parse(homeProvider.currentWeatherModel.current?.lastUpdated ?? ""))}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  CurrentWeatherTile(
                      weather: homeProvider
                              .currentWeatherModel.current?.condition?.text ??
                          "",
                      icon:
                          'https:${homeProvider.currentWeatherModel.current?.condition?.icon ?? ""}',
                      temperature: homeProvider
                          .currentWeatherModel.current!.tempC!
                          .toStringAsFixed(0),
                      isMini: false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CurrentDetailTile(
                          type: 'humidity',
                          value:
                              '${homeProvider.currentWeatherModel.current?.humidity ?? ""} %'),
                      CurrentDetailTile(
                          type: 'wind',
                          value:
                              '${homeProvider.currentWeatherModel.current?.windKph ?? ""} km/h'),
                      CurrentDetailTile(
                          type: 'feels like',
                          value:
                              '${homeProvider.currentWeatherModel.current?.feelslikeC ?? ""}ºC'),
                    ],
                  ),
                  ForecastTile(
                    forecastWeather:
                        homeProvider.currentWeatherModel.forecast!.forecastday!,
                  )
                ],
              ),
            )
          else
            const Loader()
        ],
      ),
    );
  }
}
