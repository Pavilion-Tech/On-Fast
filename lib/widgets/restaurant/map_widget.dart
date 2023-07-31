import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/components/components.dart';
import '../../shared/images/images.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        String googleUrl =
            'https://www.google.com/maps/dir/?api=1&origin=25.2048,55.2708&destination=25.2148,55.2808';
        print(googleUrl);
        openUrl(googleUrl);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    25.2048,55.2708
                ),
                zoom: 14,
              ),
            scrollGesturesEnabled: false,
          ),
          Container(
            height: 75,
            width: 75,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15),
            ),
            child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
