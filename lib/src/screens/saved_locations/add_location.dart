import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/providers/save_location_provider.dart';
import 'package:weather_app/src/screens/saved_locations/widgets/gradient_bg.dart';
import 'package:weather_app/src/screens/saved_locations/widgets/saved_location_tile.dart';
import 'package:weather_app/src/services/navigation_service.dart';

import '../widgets/search_textfield.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveLocationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: const Text('Add Location'),
                ),
                SearchTextField(
                  searchResults: provider.searchResults,
                  onChanged: (value) {
                    if (value.length > 2 && !provider.searchLocationLoading) {
                      provider.searchLocation(value);
                    } else {
                      provider.clearSearchResults();
                    }
                  },
                  isLoading: provider.searchLocationLoading,
                ),
                if (provider.currentWeatherModel.location != null)
                  SaveLocationTile(
                      location:
                          provider.currentWeatherModel.location?.name ?? "",
                      weather: provider
                              .currentWeatherModel.current?.condition?.text ??
                          "",
                      humidity: provider.currentWeatherModel.current!.humidity
                          .toString(),
                      wind: provider.currentWeatherModel.current!.windKph
                          .toString(),
                      temperature: provider.currentWeatherModel.current!.tempC!
                          .toStringAsFixed(0),
                      image:
                          "https:${provider.currentWeatherModel.current!.condition?.icon ?? ""}"),
                if (provider.currentWeatherModel.location != null)
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: TextButton.icon(
                          onPressed: () {
                            provider
                                .saveNewLocation(
                                    provider.currentWeatherModel.location?.name ??
                                        "",
                                    provider.currentWeatherModel.current?.condition
                                            ?.text ??
                                        "",
                                    provider
                                        .currentWeatherModel.current!.humidity
                                        .toString(),
                                    provider
                                        .currentWeatherModel.current!.windKph
                                        .toString(),
                                    provider.currentWeatherModel.current!.tempC!
                                        .toStringAsFixed(0),
                                    "https:${provider.currentWeatherModel.current!.condition?.icon ?? ""}",
                                    provider.currentWeatherModel.location!.lat,
                                    provider.currentWeatherModel.location!.lon)
                                .then((value) {
                              Fluttertoast.showToast(msg: 'Added Successfully');
                              provider.getSavedLocations();
                              pop();
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
