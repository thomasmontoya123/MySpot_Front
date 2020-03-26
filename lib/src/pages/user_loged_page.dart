//   New Home page, Book feature enabled
//  map creation, markers fetch 
//  search box
//  Log out
//  map style changer


// Dart imports
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';

// External Packages imports
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/distance.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/timezone.dart';

class UserLoged extends StatefulWidget {
  @override
  _UserLogedState createState() => _UserLogedState();
}

class _UserLogedState extends State<UserLoged> {
  String heroTag = '';
  String searchAddr = '';

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  
  static const LatLng _initialCoordinates =
      const LatLng(6.2461091, -75.5716757);

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
            markers: _createParkings(),
            onCameraMove: _onCameraMove,
          ),

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
                  button(_homeNavigate, Icons.exit_to_app, 'logOutTag'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    //  Actions to execute at the initial opening
    _getparkinLots();
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  Widget button(Function function, IconData icon, String heroTag) {
    // Creates the buttons on the right of the screen

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
    // change the map style from normal to satellite
    // and from satellite to normal

    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
        
      _getparkinLots();
    });
  }


  buttonSearch() async{
    // Search box autocomplete sugestions

    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyAXNenEkYbjszRhFM44TKHK1odiQr0-M9k',
      language: 'en',
      mode: Mode.overlay,
      components: [
        Component(Component.country, 'col')
      ]
    );
    }

  _homeNavigate() {
    // Log out button
    _showAlert(context);
  }

  _getparkinLots()async{
    // Fetch data from the API

    String url = 'http://18.233.97.235:3000/api/v1/main/';
    Response response = await get(url);

    var body = jsonDecode(response.body)['data'][0]['parkingName'];

    print(body);
  }

  void _showAlert(BuildContext context){
    // Validates the user log out

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('¿Estas seguro que deseas cerrar la sesion?'),
          content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
            FlutterLogo(size: 100)
          ], 
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.pushNamed(context, '/'), 
              ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pushNamed(context, '/loged'), 
              )
          ],
        );

      }
    );
  }

  Set<Marker> _createParkings() {
    // Create markers for the map

    final Set<Marker> _markers = {};

    LatLng _park2 = LatLng(6.256176, -75.591675);
    LatLng _park1 = LatLng(6.258064, -75.591203);
    LatLng _park0 = LatLng(6.259781, -75.588939);


    _markers.add(Marker(
        markerId: MarkerId('mockParkingLot0'),
        position: _park0,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Parqueadero estadio',
          snippet: 'Horario: 7:00am - 11:00pm',
          onTap: _showbook
        ),
      ));

    _markers.add(Marker(
        markerId: MarkerId('mockParkingLot1'),
        position: _park1,
        infoWindow: InfoWindow(
          title: 'Parqueadero obelisco',
          snippet: 'Horario: 7:00am - 11:00pm',
          onTap: _showbook,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

    _markers.add(Marker(
        markerId: MarkerId('mockParkingLot2'),
        position: _park2,
        infoWindow: InfoWindow(
          title: 'Parqueadero cancha',
          snippet: 'Horario: 7:00am - 11:00pm',
          onTap: _showbook
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));

    return _markers;
  }

  void _showbook(){
    DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2020, 6, 7), onChanged: (date) {
        print('change $date');
      }, onConfirm: (date) {
        print('confirm $date');
      }, currentTime: DateTime.now(), locale: LocaleType.es);
  }

}