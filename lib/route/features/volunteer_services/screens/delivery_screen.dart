import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../common/global_constant.dart';

class DeliveryScreen extends StatefulWidget {
  final LatLng initCoordinates;
  const DeliveryScreen(this.initCoordinates, {super.key});
  static const routeName = './delivery-screen';

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

final dummyCoordinates = [
  LatLng(13.045647041175298, 77.57219072431326),
  LatLng(13.02245769329124, 77.56092477589846),
  LatLng(13.050488850609451, 77.55912065505983),
];

class _DeliveryScreenState extends State<DeliveryScreen> {
  LatLng? _pickedLocation;
  final logger = Logger();
  final Set<Marker> markers = {};
  final Set<Polyline> polyline = {};
  MapType currentMapType = MapType.normal;

  void _toggleMapType() {
    setState(() {
      {
        if (currentMapType == MapType.normal) {
          currentMapType = MapType.satellite;
        } else {
          currentMapType = MapType.normal;
        }
      }
    });
  }

  void _getLocation(LatLng newLocation) {
    _pickedLocation = newLocation;
    logger.d('${newLocation.latitude}   ${newLocation.longitude}');
  }

  @override
  void initState() {
    _getLocation(widget.initCoordinates);
    final n = dummyCoordinates.length;
    markers.add(Marker(
      markerId: MarkerId(n.toString()),
      infoWindow: InfoWindow(title: 'YOU'),
      position: _pickedLocation!,
    ));
    dummyCoordinates.add(widget.initCoordinates);
    polyline.add(Polyline(
      width: 5,
      polylineId: const PolylineId('1'),
      points: dummyCoordinates,
      color: Colors.blue,
    ));

    for (int i = 0; i < n; i++) {
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        infoWindow: InfoWindow(title: 'NGO'),
        position: dummyCoordinates[i],
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: currentMapType,
            initialCameraPosition: CameraPosition(
              target: _pickedLocation!,
              zoom: 13.4746,
            ),
            onTap: _getLocation,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: markers,
            polylines: polyline,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _toggleMapType,
              child: const Icon(
                Icons.map_sharp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
