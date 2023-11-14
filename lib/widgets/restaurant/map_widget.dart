import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import '../../modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import '../../shared/components/components.dart';
import '../item_shared/image_net.dart';

class MapWidget extends StatefulWidget {
  MapWidget({required this.latLng,required this.image});

 final LatLng latLng;
 final String image;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  bool isSatellite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        await HomeCategoryCubit.get(context).getCurrentLocation();
        if(FastCubit.get(context).position!=null){
          String googleUrl =
              'https://www.google.com/maps/dir/?api=1&origin=${FastCubit.get(context).position!.latitude},${FastCubit.get(context).position!.longitude}&destination=${widget.latLng.latitude},${widget.latLng.longitude}';
          openUrl(googleUrl);
        }else{
          showToast(msg: tr('choose_your_location_first'));
        }

      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: widget.latLng,
                zoom: 14,
              ),
            mapType:isSatellite? MapType.satellite:MapType.normal,
            scrollGesturesEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: DefaultButton(
                  text: tr('change_map_type'),
                  onTap: (){
                    setState(() {
                      isSatellite = !isSatellite;
                    });
                  },
                width: 140,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15),
            ),
            child: ImageNet(image:widget.image,fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }
}
