import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:untitled/models/place.dart';
import 'package:untitled/models/place_search.dart';
import 'package:untitled/services/directions-service.dart';
import 'package:untitled/services/marker_service.dart';
import 'package:untitled/services/places_service.dart';
import '../../services/location-services.dart';
import 'google-maps-states.dart';

class GoogleMapsCubit extends Cubit<GoogleMapsCubitStates> {
  GoogleMapsCubit() : super(GMInitState());
  PlacesService? placesService;
  MarkerService? markerService;
  final googleMapsDirectionsService = GoogleMapsDirectionsService();
  StreamSubscription? locationSubscription;
  StreamSubscription? boundsSubscription;
  //for getUserLocation
  LocationData? deviceCurrentLocation;
  List<Marker> loactionMarkers = [];
  CameraPosition? initialCameraPositionn;
  LatLng? initCameraPositionTarget;
  Completer<GoogleMapController>? completer;
  //for onMapCreated
  Set<Marker> markerss = {};
  //for searchmethod
  var searchController = TextEditingController();
  var focusNode = FocusNode();
  //places
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place>? selectedLocation;
  StreamController<LatLngBounds>? bounds;
  Place? selectedLocationStatic;
  String? placeType;
  String? placeName;
  List<Place>? placeResults;
  List<Marker>? markers;
  Set<String>? placeNamee;
  Completer<GoogleMapController>? mapController;
  String? searchResultSelectedItem;
  String?selectedPlaceId;

  //init GoolgleMapCubit
  static GoogleMapsCubit get(context) => BlocProvider.of(context);

  onInit() {
    selectedLocation = StreamController<Place>();
    bounds = StreamController<LatLngBounds>();
    completer = Completer();
    placesService = PlacesService();
    markerService = MarkerService();
    getLocation();
    emit(GMInitState());
  }

  onDispose() {
    selectedLocation = null;
    bounds = null;
    completer = null;
    placesService = null;
    markerService = null;
    // searchResultSelectedItem=null;
    // selectedPlaceId=null;
    // selectedLocationStatic=null;
    onInit();
    emit(ClearSelectedLocationState());
  }

  // onSearchbarSuffixIconTapped
  onSearchbarSuffixIconTapped() {
    searchController.clear();
    emit(OnSearchbarSuffixIconTapped());
  }

  Future getLocation() async {
    emit(GetCurrentLocationLoadingState());
    await LocationService.getUserLocation().then((value) {
      deviceCurrentLocation = LocationService.deviceCurrentLocation;
      initialCameraPositionn = LocationService.initialCameraPositionn;
      initCameraPositionTarget=LatLng( LocationService.deviceCurrentLocation!.latitude!, LocationService.deviceCurrentLocation!.longitude!);
      print(
          'location service is 121211212211212   ${LocationService.deviceCurrentLocation!.longitude}');
      print(value.toString());
      emit(GetCurrentLocationSuccessState());
    });
  }

  void onMapCreated(GoogleMapController googleMapController) {
    completer!.complete(googleMapController);
    emit(SetMarkerState());
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService!.getAutocomplete(searchTerm);
    print('search term isssssssssssssssssssssss $searchTerm');
    print('search term isssssssssssssssssssssss ${searchResults![0]}');
    emit(SearchPlacesStaeState());
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService!.getPlace(placeId);
    if (markerss.isEmpty) {
      markerss.add(Marker(
          markerId: MarkerId(sLocation.geometry!.location!.lat!.toString() +
              sLocation.geometry!.location!.lng!.toString()),
          position: LatLng(sLocation.geometry!.location!.lat!,
              sLocation.geometry!.location!.lng!),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title: sLocation.name,
              snippet:
                  ' ${LatLng(sLocation.geometry!.location!.lat!, sLocation.geometry!.location!.lng!)}')));
    } else {
      markerss.clear();
      markerss.add(Marker(
          markerId: MarkerId(sLocation.geometry!.location!.lat!.toString() +
              sLocation.geometry!.location!.lng!.toString()),
          position: LatLng(sLocation.geometry!.location!.lat!,
              sLocation.geometry!.location!.lng!),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title: sLocation.name,
              snippet:
                  ' ${LatLng(sLocation.geometry!.location!.lat!, sLocation.geometry!.location!.lng!)}')));
    }
    placeName = sLocation.name;
    selectedLocation!.add(sLocation);
    selectedLocationStatic = sLocation;
    addPolyLine();
    searchResults = null;
    emit(SetSelectedLocationState());
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = await placesService!.getPlaces(
          selectedLocationStatic!.geometry!.location!.lat!,
          selectedLocationStatic!.geometry!.location!.lng!,
          placeType!);
      markers = [];
      if (places.isNotEmpty) {
        var newMarker = markerService!.createMarkerFromPlace(places[0], false);
        markers!.add(newMarker);
      }

      var locationMarker =
          markerService!.createMarkerFromPlace(selectedLocationStatic!, true);
      markers!.add(locationMarker);

      var _bounds = markerService!.bounds(Set<Marker>.of(markers!));
      bounds!.add(_bounds);

      emit(TogglePlaceTypeState());
    }
  }

  Future<void> goToPlace(Place place) async {
    final GoogleMapController controller = await completer!.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry!.location!.lat!, place.geometry!.location!.lng!),
            zoom: 14.0),
      ),
    );
    getSelectedLocationAddressByLatLng(
        lat: place.geometry!.location!.lat, lng: place.geometry!.location!.lng);
    emit(GoToPlacesState());
  }
  Future<void> goToMissionPlace() async {
    final GoogleMapController controller = await completer!.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: initCameraPositionTarget!,
            zoom: 14.0),
      ),
    );
    // getSelectedLocationAddressByLatLng(
    //     lat: place.geometry!.location!.lat, lng: place.geometry!.location!.lng);
    emit(GoToPlacesState());
  }

  listenForSelectedPlaces() {
    locationSubscription = selectedLocation!.stream.listen((place) {
      if (place != null) {
        goToPlace(place);
        // addPolyLine();
      } else {
        searchController.text = "";
      }
    });
    bounds!.stream.listen((bounds) async {
      final GoogleMapController controller = await completer!.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    emit(ListenForSelectedPlaceState());
  }

  getSelectedLocationAddressByLatLng({double? lat, double? lng}) async {
    await placemarkFromCoordinates(lat!, lng!);
    emit(GetSelectedLocationAddressByLatLng());
  }

  Map<PolylineId, Polyline> mapPolyLines = {};
  int polyLineIdCounter = 1;
  void addPolyLine() {
    final String polylineIdVal = 'polyline_id_$polyLineIdCounter';
    polyLineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.red,
      width: 5,
      points: createPoints(),
    );
    mapPolyLines[polylineId] = polyline;
    emit(AddPolyLineState());
  }

  List<LatLng> points = <LatLng>[];
  List<LatLng> createPoints() {
    if (selectedLocationStatic!.geometry!.location!.lat == null) {
      points.add(LatLng(LocationService.deviceCurrentLocation!.latitude!,
          LocationService.deviceCurrentLocation!.longitude!));
      points.add(LatLng(selectedLocationStatic!.geometry!.location!.lat!,
          selectedLocationStatic!.geometry!.location!.lng!));
    } else {
      points.clear();
      points.add(LatLng(LocationService.deviceCurrentLocation!.latitude!,
          LocationService.deviceCurrentLocation!.longitude!));
      points.add(LatLng(selectedLocationStatic!.geometry!.location!.lat!,
          selectedLocationStatic!.geometry!.location!.lng!));
    }
    return points;
  }





void disposeMissionInfo(){
    searchResultSelectedItem=null;
    selectedLocationStatic=null;
    placesService=null;
    selectedPlaceId=null;
    onInit();
}
}
