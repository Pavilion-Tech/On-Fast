import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../../models/provider_category_model.dart';
import '../../../shared/components/constant.dart';
import '../../../widgets/restaurant/map_widget.dart';
import '../../../widgets/restaurant/notify_dialog.dart';

class Info extends StatefulWidget {
  Info(this.providerData);

final  ProviderData providerData;
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  bool isNotified = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0,right: 20,left: 20,bottom: 5),
            child: Text(
              tr('location'),style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            height: 260,
            child: MapWidget(
              image: widget.providerData.personalPhoto??'',
              latLng: LatLng(
                double.parse(widget.providerData.currentLatitude??'25.2048'),
                double.parse(widget.providerData.currentLongitude??'55.2708'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(Images.fav,color: Colors.grey,),
                            SizedBox(height: 5,),
                            Text(tr("AddedToFavourites"))
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(Images.share, ),
                            SizedBox(height: 5,),
                            Text(tr("Share_Restaurant"))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(
                      tr('working_time'),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xff4B4B4B)),
                    ),
                    Row(
                      children: [
                        Text(
                          'Everyday',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Color(0xff2C2C2C)),
                        ),
                        const Spacer(),
                        Text(
                          '${widget.providerData.openingTime}  - ${widget.providerData.closingTime} ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                if(token!=null)
                if(widget.providerData.crowdedStatus ==1&&widget.providerData.openStatus != 'open')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('notify_me'),style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          tr('when_open'),style:const TextStyle(
                            fontWeight: FontWeight.w300,color: Colors.grey
                        ),
                        ),
                        const Spacer(),
                        ConditionalBuilder(
                          condition: state is! NotifyMeLoadingState,
                          fallback: (c)=>CupertinoActivityIndicator(),
                          builder: (c)=> InkWell(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            onTap: (){
                              if(!widget.providerData.notifyMe!){
                                FastCubit.get(context).notifyMe(
                                    id:widget.providerData.id??'',
                                  context: context,
                                  notificationStatus: 1
                                );

                              }else{
                                FastCubit.get(context).notifyMe(
                                    id:widget.providerData.id??'',
                                    notificationStatus: 2
                                );
                              }
                              setState(() {
                                widget.providerData.notifyMe = ! widget.providerData.notifyMe!;
                              });
                            },
                              child: AnimatedSwitcher(
                                duration:const Duration(milliseconds: 500),
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return ScaleTransition(scale: animation, child: child);
                                  },
                                  child: Image.asset(widget.providerData.notifyMe!?Images.notifyYes:Images.notifyNo,width: 33.5,key: ValueKey(widget.providerData.notifyMe!),))),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Image.asset(Images.pickUp,width: 79,),
          //           Text(
          //             tr('pick_up')
          //           ),
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Image.asset(Images.dineIn2,width: 79,),
          //           Text(
          //             tr('dine_in')
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  },
);
  }
}
