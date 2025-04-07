import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seetle/src/constants/app_styles.dart';
import 'package:seetle/src/translate/jp.dart';
import 'package:seetle/src/utils/index.dart';

class CurrentPosition extends StatelessWidget {
  final LatLng currentLocation;
  final VoidCallback onRequestPermission;
  final VoidCallback onRequestAppPermission;
  final VoidCallback onCancel;

  const CurrentPosition({
    super.key,
    required this.currentLocation,
    required this.onRequestPermission,
    required this.onRequestAppPermission,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Column(
            children: [
              Center(
                child: Text(
                  positionInfo1,
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  positionInfo2,
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  positionInfo3,
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  positionInfo4,
                  style: TextStyle(
                    color: kColorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: vhh(context, 3)),
          Container(
            height: vhh(context, 20),
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: currentLocation,
                ),
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        _buildActionButton(useOne, onRequestPermission),
        _buildActionButton(useAppPermission, onRequestAppPermission),
        _buildActionButton(unUseAppPermission, onCancel, addBorder: false),
      ],
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed, {bool addBorder = true}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: addBorder
            ? const Border(
                bottom: BorderSide(color: kColorBorder, width: 0.5),
              )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          alignment: Alignment.center,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: kColorBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
