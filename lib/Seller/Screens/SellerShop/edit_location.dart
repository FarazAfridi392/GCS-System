import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditLocation extends StatefulWidget {
  const EditLocation({Key key}) : super(key: key);

  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;
  String postalCode;
  double lat;
  double lang;
  String shopId = EcommerceApp.auth.currentUser.uid;

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: addressLocation));
    setState(() {
      // markers[markerId] = marker;
      markers.isEmpty ? markers[markerId] = marker : markers.clear();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Location',
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinated = new geoCo.Coordinates(
                        tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local
                        .findAddressesFromCoordinates(coordinated);
                    lat = tapped.latitude;
                    lang = tapped.longitude;
                    var firstAddress = address.first;

                    getMarkers(tapped.latitude, tapped.longitude);

                    setState(() {
                      addressLocation = firstAddress.addressLine;
                      country = firstAddress.countryName;
                      postalCode = firstAddress.postalCode;
                    });
                  },
                  mapType: MapType.hybrid,
                  compassEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      _googleMapController = controller;
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
              SizedBox(
                height: 10,
              ),
              Text('Address: $addressLocation'),
              Text('Country Name: $country'),
              Text('Postal Code: $postalCode'),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final coordinated = new geoCo.Coordinates(lat, lang);
                  var address = await geoCo.Geocoder.local
                      .findAddressesFromCoordinates(coordinated);
                  var firstAddress = address.first;
                  getMarkers(lat, lang);
                  final itemsRef =
                      FirebaseFirestore.instance.collection('Shop');
                  if (itemsRef
                          .doc(shopId)
                          .collection('location')
                          .doc(shopId)
                          .snapshots() ==
                      null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  await itemsRef
                      .doc(shopId)
                      .collection('location')
                      .doc(shopId)
                      .set({
                    'latitude': lat,
                    'longitude': lang,
                    'Address': firstAddress.addressLine,
                    'Country': firstAddress.countryName,
                    'postalCode': firstAddress.postalCode
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      'Edit Location',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kYellow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
