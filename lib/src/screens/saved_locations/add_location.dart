import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/providers/save_location_provider.dart';
import 'package:weather_app/src/screens/saved_locations/widgets/gradient_bg.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SaveLocationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          SafeArea(
            child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      log('message');
                      Fluttertoast.showToast(msg: 'msg');
                      provider.saveNewLocation('Manjeri', 'Cloudy', '45', '2.6',
                          '30', 'weatherImage');
                    },
                    child: const Text('Add'),
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
