import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService{
 static LocationData? deviceCurrentLocation;
 static List<Marker> loactionMarkers = [];
  static var initCameraPosition = const LatLng(30.42796133580664, 31.085749655962);
  static CameraPosition? initialCameraPositionn;
 static Future getUserLocation() async {
    print(
        'i am into devil now ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ???????????????????????????????????');
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    LocationData? locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    initCameraPosition =
        LatLng(locationData.latitude!, locationData.longitude!);
    deviceCurrentLocation = locationData;
    initialCameraPositionn = CameraPosition(
      target: initCameraPosition,
      zoom: 14.4746,
    );
    location.enableBackgroundMode(enable: true);

  }
}