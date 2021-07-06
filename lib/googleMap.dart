import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidg extends StatefulWidget {
  const GoogleMapWidg({Key key}) : super(key: key);

  @override
  _GoogleMapWidgState createState() => _GoogleMapWidgState();
}

class _GoogleMapWidgState extends State<GoogleMapWidg> {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;
  String postalCode;

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());

    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueCyan,
      ),
      infoWindow: InfoWindow(snippet: addressLocation),
    );
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 600,
                child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinates = new geoCo.Coordinates(
                        tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var firstAddress = address.first;
                    getMarkers(tapped.latitude, tapped.longitude);
                    FirebaseFirestore.instance.collection("loacation").add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                      'address': firstAddress.addressLine,
                      'country': firstAddress.countryName,
                      'postalCode': firstAddress.postalCode,
                    });
                    setState(() {
                      country = firstAddress.countryName;
                      postalCode = firstAddress.postalCode;
                      addressLocation = firstAddress.addressLine;
                    });
                  },
                  mapType: MapType.hybrid,
                  compassEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      googleMapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      position.latitude.toDouble(),
                      position.longitude.toDouble(),
                    ),
                    zoom: 15.0,
                  ),
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
              Text('Adress: $addressLocation'),
              Text('Country: $country'),
              Text('Postal  Code: $postalCode'),
            ],
          ),
        ),
      ),
    );
  }
}
