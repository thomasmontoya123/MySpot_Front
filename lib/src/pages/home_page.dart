import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/timezone.dart';
import 'package:http/http.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String heroTag = '';
  String searchAddr = '';

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  
  static const LatLng _initialCoordinates =
      const LatLng(6.2461091, -75.5716757);
  final Set<Marker> _markers = {};
  LatLng _lastPosition = _initialCoordinates;
  MapType _currentMapType = MapType.normal;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text('MySpot'),
          backgroundColor: Colors.blueGrey),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: _initialCoordinates, zoom: 11.0),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 16.0, right: 90.0, left: 20.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Colors.blueGrey,
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //       hintText: 'Search',
          //       labelText: 'Spot',
          //       labelStyle: TextStyle(color: Colors.white),
          //     ),
          //     onChanged: (value) {
          //       setState(() {
          //         searchAddr = value;
          //       });
          //     },
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  button(buttonSearch, Icons.search, 'searchTag'),
                  SizedBox(height: 16.0),
                  button(_onMapTypeButtonPressed, Icons.map, 'mapTypeTag'),
                  SizedBox(height: 16.0),
                  button(_loginNavigate, Icons.account_circle, 'loginTag'),
                  // button(_onAddMarkerButtonPressed, Icons.location_on, 'addMarkerTag'),
                  // SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _getparkinLots();
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  Widget button(Function function, IconData icon, String heroTag) {
    return FloatingActionButton(
      heroTag: heroTag,
      child: Icon(
        icon,
        size: 36.0,
      ),
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blueGrey,
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
        
      _getparkinLots();
    });
  }

  // _onAddMarkerButtonPressed(){
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId(_lastPosition.toString()),
  //       position: _lastPosition,
  //       infoWindow: InfoWindow(
  //         title: 'my first parking lot',
  //         snippet: 'This is a snippet'
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }

  buttonSearch() async{
    
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyAXNenEkYbjszRhFM44TKHK1odiQr0-M9k',
      language: 'en',
      mode: Mode.overlay,
      components: [
        Component(Component.country, 'col')
      ]
    );
    // print(searchAddr);
    // Geolocator().placemarkFromAddress(searchAddr).then((result) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(result[0].position.latitude, result[0].position.longitude),
    //       zoom: 10.0)));
    // });
    }

  _loginNavigate() {
    Navigator.pushNamed(context, '/login');
  }

  _getparkinLots()async{
    String url = 'http://18.233.97.235:3000/api/v1/main/';
    Response response = await get(url);

    var body = jsonDecode(response.body)['data'][0]['parkingName'];

    print(body);
  }

}
