import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:settee/src/common/currentPosition.dart';
import 'package:settee/src/common/profileBottomSheet.dart';
import 'package:settee/src/common/whooSettingModalSheet.dart';
import 'package:settee/src/common/addFriendBottomSheet.dart';
import 'package:settee/src/screen/auth/phoneLogin.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng _currentLocation = const LatLng(35.682839, 139.759455);
  String _locationName = loading;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      _showLocationModal();
      await _getAddressFromCoordinates();
    });
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation.latitude, _currentLocation.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _locationName = '${placemarks[0].locality}, ${placemarks[0].country}';
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    // ignore: deprecated_member_use
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _showLocationModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CurrentPosition(
          currentLocation: _currentLocation,
          onRequestPermission: () async {
            await Permission.location.request();
            Navigator.of(context).pop();
          },
          onRequestAppPermission: () async {
            await Permission.locationAlways.request();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return const ProfileBottomSheet();
      },
    );
  }

  void _showSettingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return WhooSettingsScreen();
      },
    );
  }

  void _showAddFriendBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return const AddFriendBottomSheet();
      },
    );
  }

  bool allowRevert = true;

  Future<bool> _onWillPop() async {
    if (!allowRevert) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.all(0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 20,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('current_location'),
                      position: _currentLocation,
                      infoWindow: const InfoWindow(title: "Your Location"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                    ),
                  },
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Text(
                  _locationName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.person,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _showProfileBottomSheet(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _showSettingBottomSheet(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.group_add,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _showAddFriendBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 30,
                left: vMin(context, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () async{
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('uId');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneLoginScreen()),
                          );
                        },
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                    SizedBox(width: vMin(context, 10)),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Chat action
                        },
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                    SizedBox(width: vMin(context, 10)),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Locate action
                        },
                        padding: const EdgeInsets.all(0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
