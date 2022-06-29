import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/bloc/google-maps-cubit/google-maps-states.dart';
import 'package:untitled/components/neu-tadbar-container.dart';
import '../bloc/google-maps-cubit/google-maps-cubit.dart';
import 'package:untitled/components/show_modal_bottomsheet.dart' ;

import '../components/neu-button.dart';
import '../ui-widgets/custom-app-bar.dart';
import '../ui-widgets/custom-darwer.dart';
import '../ui-widgets/map-distenation-confirm-widget.dart';
class GoogleMapsScreen extends StatelessWidget {
  final GlobalKey testScreeenGlobal = GlobalKey();
  GoogleMapsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar:const PreferredSize(child: CustomNewAppBar(appBarTitle: 'Maps',),preferredSize: Size(double.infinity,60),),
      drawer: Drawer(child:const CustomDrawer(),width: MediaQuery.of(ctx).size.width*.60,),
      body:BlocBuilder<GoogleMapsCubit, GoogleMapsCubitStates>(
          builder: (context, snapshot) {
            GoogleMapsCubit cubit = GoogleMapsCubit.get(context);
            return Stack(
              children: [
                if (cubit.initialCameraPositionn == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  GoogleMap(
                    mapType: MapType.normal,
                    trafficEnabled: true,
                    indoorViewEnabled: true,
                    compassEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: cubit.initCameraPositionTarget!,
                      zoom: 14,
                    ),
                    onMapCreated: cubit.onMapCreated,
                    markers: cubit.markerss,
                    polylines: Set<Polyline>.of(cubit.mapPolyLines.values),
                    // markers: googleMapsCubit.markers,
                  ),
                Positioned(
                  top: 10,
                  right: 60,
                  child: CustomSearchContainer(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextFormField(
                        controller: cubit.searchController,
                        focusNode: cubit.focusNode,
                        decoration: const InputDecoration(
                          hintText: '  Search ...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          cubit.searchPlaces(value);
                        },
                        onTap: () {
                          cubit.focusNode.addListener(() {
                            if(cubit.focusNode.hasFocus) {
                              cubit.searchController.selection = TextSelection(baseOffset: 0, extentOffset: cubit.searchController.text.length);
                            }
                          });
                          // cubit.onSearchbarSuffixIconTapped();
                        }

                    ),
                  ),
                ),
                if (cubit.searchResults != null&& cubit.searchResults!.isNotEmpty)
                  CustomSearchContainer(
                    margin: const EdgeInsets.only(top: 55),
                    height: MediaQuery.of(context).size.width * .75,
                    width: MediaQuery.of(context).size.width * .99,
                    child: Material(
                      child: ListView.builder(
                          itemCount: cubit.searchResults!.length,
                          itemBuilder: (cntext, index) {
                            return ListTile(
                              title: Text(
                                cubit.searchResults![index].description!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                var x=cubit.searchResults![index].placeId!;
                                cubit.selectedPlaceId=x;
                                cubit.searchResultSelectedItem=cubit.searchResults![index].description;
                                cubit.setSelectedLocation(
                                    cubit.searchResults![index].placeId!);
                                cubit.listenForSelectedPlaces();
                                showCustomModalBottomsheet(
                                    context:ctx,
                                    widget:    MapDestinationConfirmWidget(
                                      destinationAddress:cubit.searchResultSelectedItem ??'no place selected',
                                      onConfirmTapped: (){
                                        Navigator.of(ctx)..pop()..pop();
                                        cubit.onDispose();
                                      },
                                      onResetDistenationTapped:(){
                                        Navigator.pop(ctx);

                                      } ,
                                    )
                                  // showCustomModalBottomSheet(


                                );

                              },
                            );
                          }),
                    ),
                  ),
                if (cubit.markerss.isNotEmpty)
                  Positioned(
                      bottom: 10,
                      right: 5,
                      left: 20,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomBottomSheetButton(
                              text: 'Save mark',
                              borderColor: Colors.blue,
                              textColor: Colors.blue,
                              shadowDarkColor: Colors.white,
                              function: (){
                                Navigator.of(context).pop();
                                cubit.onDispose();
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomBottomSheetButton(
                              text: 'cancel',
                              borderColor: Colors.blue,
                              textColor: Colors.blue,
                              shadowDarkColor: Colors.white,
                              function: (){
                                cubit.searchResultSelectedItem='select location';
                                Navigator.of(context).pop();
                                cubit.onDispose();
                              },
                            ),
                          ),
                        ],
                      ))

              ],
            );
          }) ,
    ) ;

  }

}
