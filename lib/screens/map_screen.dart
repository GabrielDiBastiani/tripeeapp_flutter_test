import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

// void main() => runApp(MapScreen());

class MapScreen extends StatefulWidget {
	@override
	_MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
	GoogleMapController mapController;
  Position position;
  // Widget _child;
  static LatLng _initialPosition;

  Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('denied');
        break;
      case GeolocationStatus.disabled:
        showToast('disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Access granted');
        // _getCurrentLocation();
        _getUserLocation();
    }
	}

  ///Create marker in the map
  // Set<Marker> _createMarker(){
  //   return <Marker>[
  //     Marker(
  //       markerId: MarkerId('home'),
  //       position: LatLng(position.latitude,position.longitude),
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: InfoWindow(title: 'Current Location')
  //     )
  //   ].toSet();
  // }

  void showToast(message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

	@override
  void initState() {
    getLocation();
    super.initState();
  }

//   void _getCurrentLocation() async{
//     Position res = await Geolocator().getCurrentPosition();
//     setState(() {
//       position = res;
//       _child = _mapWidget();
//     });
//   }

void _currentLocation() async {
    Position res = await Geolocator().getCurrentPosition();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(res.latitude, res.longitude),
        zoom: 17.0,
      ),
    ));
  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

	void _onMapCreated(GoogleMapController controller) {
		mapController = controller;
	}

  // Widget _mapWidget(){
  //   return GoogleMap(
  //     mapType: MapType.normal,
  //     // markers: _createMarker(),
  //     initialCameraPosition: CameraPosition(
  //       target: LatLng(position.latitude,position.longitude),
  //       zoom: 17.0,
  //     ),
  //     onMapCreated: _onMapCreated,
  //     myLocationEnabled: true,
  //       // _setStyle(controller);
  //   );
  // }

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					title: Text('Tripee'),
					backgroundColor: Colors.black,      
				),
				drawer: new Drawer(),
				body: _initialPosition == null
        ? Container(
            child: Center(
              child: Text(
                'loading map..', 
                style: TextStyle(
                  fontFamily: 'Avenir-Medium', 
                  color: Colors.grey[400]
                ),
              ),
            ),
          ) 
        : GoogleMap(
            mapType: MapType.normal,
            // markers: _createMarker(),
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 17.0,
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
              // _setStyle(controller);
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _currentLocation,
            child: Icon(Icons.location_on),            
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),           
			),
		);
	}

	// @override
	// Widget build(BuildContext context) {
	// 	return MaterialApp(
	// 		home: Scaffold(
	// 			appBar: AppBar(
	// 				title: Text('Tripee'),
	// 				backgroundColor: Colors.black,      
	// 			),
	// 			drawer: new Drawer(),
	// 			body: GoogleMap(
	// 				onMapCreated: _onMapCreated,
	// 				initialCameraPosition: CameraPosition(
	// 				target: _center,
	// 				zoom: 11.0,
	// 				),
	// 			),
	// 		),
	// 	);
	// }
}