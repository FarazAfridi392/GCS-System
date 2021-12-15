import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/services/database/product_database_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopLocation extends StatefulWidget {
  String shopName;
  ShopLocation({this.shopName});
  @override
  _ShopLocationState createState() => _ShopLocationState();
}

class _ShopLocationState extends State<ShopLocation> {
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
            'Shop Location',
          ),
        ),
        body: FutureBuilder(
            future: ProductDatabaseHelper().getShopLocationWithID(
              EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.shopProduct),
            ),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
             
              Set<Marker> getMarker() {
                // ignore: prefer_collection_literals
                return <Marker>[
                  Marker(
                      visible: true,
                      markerId: MarkerId(snapshot.data['latitude'].toString() +
                          snapshot.data['longitude'].toString()),
                      position: LatLng(snapshot.data['latitude'],
                          snapshot.data['longitude']),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueCyan),
                      infoWindow: InfoWindow(
                          snippet: snapshot.data['Address'], title: 'Shop Name: ' + widget.shopName))
                ].toSet();
              }

              ;
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        compassEnabled: true,
                        trafficEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            _googleMapController = controller;
                          });
                        },
                        markers: getMarker(),
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            position.latitude.toDouble(),
                            position.longitude.toDouble(),
                          ),
                          zoom: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Shop Name: ' + widget.shopName),
                    Text('Address: ' + snapshot.data['Address']),
                    Text('Country Name: ' + snapshot.data['Country']),
                    Text('Postal Code: ' + snapshot.data['postalCode']),
                  ],
                ),
              );
            }));
  }
}
