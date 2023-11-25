import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/providers/homeProvider.dart';
import 'package:weather_app/src/screens/saved_locations/saved_locations.dart';
import '../widgets/customAppBar.dart';
import 'widgets/current_detail_tile.dart';
import 'widgets/current_weather_tile.dart';
import 'widgets/forecast_tile.dart';

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
    return Scaffold(
      //  backgroundColor: const Color.fromARGB(255, 34, 10, 62),
      endDrawer: SavedLocations(),
      body: Stack(
        children: [
          Image.asset(
            'assets/dummy_bg.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.33),
            colorBlendMode: BlendMode.darken,
          ),
          const CustomAppBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'June 07',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      Text(
                        'Updated 6/7/2023 4:55 PM',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                const CurrentWeatherTile(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CurrentDetailTile(type: 'humidity', value: '59 %'),
                    CurrentDetailTile(type: 'wind', value: '4.6 km/h'),
                    CurrentDetailTile(type: 'feels like', value: '29ºC'),
                  ],
                ),
                const ForecastTile()
              ],
            ),
          )
        ],
      ),
    );
  }
}
