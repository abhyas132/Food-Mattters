import 'dart:async';
import 'dart:convert';
import 'package:foods_matters/common/utils/show_snackbar.dart';
import 'package:foods_matters/provider_route/features/user_services/repository/user_provider.dart';
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
  const UpdateLocationScreen(this.coordinates, {super.key});
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
      _logger.v("${position.latitude} ${position.longitude}");
      _pickedLocation = position;
    });
  }

  Future<void> _updateLocation(LatLng newLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    _logger.v('${GlobalVariables.baseUrl}api/v1/update/location');
    _logger.v(newLocation.latitude);
    _logger.v(newLocation.longitude);
    try {
      final res = await http.post(
          Uri.parse('${GlobalVariables.baseUrl}api/v1/update/location'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': token!,
          },
          body: json.encode({
            "latitude": newLocation.latitude,
            "longitude": newLocation.longitude,
          }));
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation(widget.coordinates);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDataProvider).user;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              context.loaderOverlay.show();
              await _updateLocation(_pickedLocation!).then((value) {
                context.loaderOverlay.hide();
                ShowSnakBar(
                    context: context, content: 'Location updated successfully');
                Navigator.pop(context);
              });
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
