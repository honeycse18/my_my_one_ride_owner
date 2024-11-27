import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_car_owner/utils/app_singleton.dart';
import 'package:one_ride_car_owner/utils/constants/app_images.dart';

class TrackingScreenController extends GetxController {
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  GoogleMapController? googleMapController;

  final String riderMarkerID = 'riderID';
  final String markerID = 'markerID';

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
  }

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    // panelController.open();
  }

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addRiderMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    // _setAddress(latLng);
    update();
  }

  Future<void> _addRiderMarker(LatLng latLng) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.riderGPSImage);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(riderMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
  }
}
