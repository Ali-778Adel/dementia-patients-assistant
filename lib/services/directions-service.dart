import 'dart:convert';
import 'dart:io';
import 'package:untitled/constants/endpoints.dart';
//not activated
class GoogleMapsDirectionsService {
  Future getDirections({
    double?currentLocationLat,
    double?currentLocationLng,
    double?destinationLat,
    double?destinationLng,

  })async{
   return await HttpClient()
       .getUrl(Uri
       .parse('https://maps.googleapis.com/maps/api/directions/json?origin=$currentLocationLat,$currentLocationLng&destination=$destinationLat,$destinationLng&key=$googleMapsApiKey'))
       .then((req)=>req.close())
       .then((res) =>res.transform(utf8.decoder).join())
       .then((str) {
         json.decode(str);
         print('respose str is $str');

   });
  }
}