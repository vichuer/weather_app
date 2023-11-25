import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class HomeProvider extends ChangeNotifier {
  Future getCurrentLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();
    // SharedPrefrence().setLatitude(_pos.latitude);
    // SharedPrefrence().setLongitude(_pos.longitude);
    print(_pos);
  }
}
