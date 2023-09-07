import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/home/map_screen.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../modules/home/search/seach_screen.dart';
import '../../modules/restaurant/restaurant_screen.dart';
import '../item_shared/image_net.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar(this.closeTop);
  bool closeTop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0,left: 20.0,bottom: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('search_for'),
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),
                  ),
                  Text(
                    tr('fav_food'),
                    style:const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  navigateTo(context, SearchScreen());
                },
                child: Container(
                  height: 53,width: 53,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadiusDirectional.circular(10)
                  ),
                  alignment: AlignmentDirectional.center,
                  child:Image.asset(Images.search,width: 26,),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: (){
              FastCubit.get(context).getCurrentLocation();
              navigateTo(context, MapScreen());
            },
            child: Row(
              children: [
                Image.asset(Images.location,width: 20,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    FastCubit.get(context).locationController.text.isNotEmpty
                        ?FastCubit.get(context).locationController.text
                        :tr('choose_your_location'),
                    maxLines: 2,
                    style: TextStyle(height: 1),
                  ),
                )
              ],
            ),
          ),
          if(!closeTop)const SizedBox(height: 20,),
          ConditionalBuilder(
            condition: FastCubit.get(context).adsModel!.data!.imageAdvertisements!.isNotEmpty,
            fallback: (c)=>SizedBox(),
            builder: (c)=> AnimatedOpacity(
              opacity: closeTop?0:1,
              duration: Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: closeTop?0:145,
                child: ListView.separated(
                    itemBuilder: (c,i){
                      return InkWell(
                        onTap: FastCubit.get(context).adsModel!.data!.imageAdvertisements![i].type==1
                            ?null
                            :(){
                          if(FastCubit.get(context).adsModel!.data!.imageAdvertisements![i].type==2){
                            openUrl(FastCubit.get(context).adsModel!.data!.imageAdvertisements![i].link??'');
                          }else{
                            FastCubit.get(context).singleProvider(FastCubit.get(context).adsModel!.data!.imageAdvertisements![i].link??'',context);
                          }
                        },
                        child: Container(
                          height: 142,
                          width: size!.width*.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(21)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ImageNet(image:FastCubit.get(context).adsModel!.data!.imageAdvertisements![i].backgroundImage??'',fit: BoxFit.cover,),
                        ),
                      );
                    },
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (c,i)=>const SizedBox(width: 30,),
                    itemCount: FastCubit.get(context).adsModel!.data!.imageAdvertisements!.length
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
