import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier {
  Future getCurrentLocation() async {
    Location location = Location();
    LocationData pos = await location.getLocation();
    // SharedPrefrence().setLatitude(_pos.latitude);
    // SharedPrefrence().setLongitude(_pos.longitude);
    print(pos);
  }
}
