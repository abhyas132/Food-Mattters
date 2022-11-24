// class UpdateLocationScreen extends StatefulWidget {
//   final LatLng coordinates;
//   const UpdateLocationScreen(this.coordinates);
//   static const routeName = './update-location';
//   @override
//   State<UpdateLocationScreen> createState() => UpdateLocationScreenState();
// }

// class UpdateLocationScreenState extends State<UpdateLocationScreen> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(22.572645, 88.363892),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition:
//             CameraPosition(target: LatLng(22.572645, 88.363892)),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
import 'dart:async';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_matters/common/global_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateLocationScreen extends ConsumerStatefulWidget {
  final LatLng coordinates;
  const UpdateLocationScreen(this.coordinates);
  static const routeName = './update-location';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends ConsumerState<UpdateLocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng? _pickedLocation;
  final _logger = Logger();

  void _getLocation(LatLng position) {
    setState(() {
      Logger().v("${position.latitude} ${position.longitude}");
      _pickedLocation = position;
    });
  }

  Future<void> _updateLocation(LatLng newLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    Logger().d('${GlobalVariables.baseUrl}api/v1/update/location');

    final res = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}api/v1/update/location'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token!,
        },
        body: {
          "latitude": newLocation.latitude,
          "longitude": newLocation.longitude,
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation(widget.coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // context.loaderOverlay.show();
              await _updateLocation(_pickedLocation!);
              // context.loaderOverlay.hide();
              // ShowSnakBar(
              //     context: context, content: 'Location updated successfully');
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: LoaderOverlay(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _pickedLocation!,
            zoom: 15.4746,
          ),
          onTap: _getLocation,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _pickedLocation == null
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId('newplace'),
                      position: _pickedLocation!)
                },
        ),
      ),
    );
  }
}
