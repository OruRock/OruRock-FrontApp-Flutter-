import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> hasLocationPermission() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    return false;
  }

  final status = await Geolocator.requestPermission();

  if (status == LocationPermission.denied ||
      status == LocationPermission.deniedForever) {
    return false;
  }

  return true;
}