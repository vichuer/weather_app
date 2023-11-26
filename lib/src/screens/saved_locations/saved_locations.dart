import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/providers/homeProvider.dart';
import 'package:weather_app/src/providers/save_location_provider.dart';
import 'package:weather_app/src/screens/saved_locations/add_location.dart';
import 'package:weather_app/src/screens/widgets/loader.dart';
import 'package:weather_app/src/screens/widgets/no_data.dart';
import 'package:weather_app/src/services/navigation_service.dart';
import 'package:weather_app/src/services/sharedpreference_service.dart';

import 'widgets/gradient_bg.dart';
import 'widgets/saved_location_tile.dart';

class SavedLocations extends StatelessWidget {
  const SavedLocations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppBar(
                    leading: BackButton(),
                    title: const Text('Saved Locations'),
                    actions: [
                      InkWell(
                        onTap: () {
                          push(context, const AddLocation());
                        },
                        child: Image.asset(
                          'assets/search.png',
                          width: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                    child: FutureBuilder(
                        future: Provider.of<SaveLocationProvider>(context,
                                listen: false)
                            .getSavedLocations(),
                        builder: (context, snapshot) => snapshot
                                    .connectionState ==
                                ConnectionState.waiting
                            ? const Loader()
                            : Consumer(
                                child: const NoData(),
                                builder: (context,
                                        SaveLocationProvider locProvider,
                                        child) =>
                                    locProvider.savedLocations.isEmpty
                                        ? child!
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            itemCount: locProvider
                                                .savedLocations.length,
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                var homeProvider =
                                                    Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false);
                                                var prefs =
                                                    SharedPreferencesService
                                                        .prefs;

                                                prefs.setString(
                                                    'lat',
                                                    locProvider
                                                        .savedLocations[index]
                                                        .lat);
                                                prefs.setString(
                                                    'long',
                                                    locProvider
                                                        .savedLocations[index]
                                                        .long);
                                                homeProvider.getForecastWeather(
                                                    locProvider
                                                        .savedLocations[index]
                                                        .lat,
                                                    locProvider
                                                        .savedLocations[index]
                                                        .long);
                                                pop();
                                              },
                                              child: SaveLocationTile(
                                                  location: locProvider
                                                      .savedLocations[index]
                                                      .location,
                                                  weather: locProvider
                                                      .savedLocations[index]
                                                      .weather,
                                                  humidity: locProvider
                                                      .savedLocations[index]
                                                      .humidity,
                                                  wind: locProvider
                                                      .savedLocations[index]
                                                      .wind,
                                                  temperature: locProvider
                                                      .savedLocations[index]
                                                      .temperature,
                                                  image: locProvider
                                                      .savedLocations[index]
                                                      .weatherImage),
                                            ),
                                          ),
                              ))),
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: TextButton.icon(
                        onPressed: () {
                          push(context, const AddLocation());
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 30,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Add New',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
