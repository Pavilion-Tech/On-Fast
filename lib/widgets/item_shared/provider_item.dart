import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/models/provider_category_model.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../modules/restaurant/restaurant_screen.dart';
import 'image_net.dart';

class ProviderItem extends StatelessWidget {

  ProviderItem ({this.isBranch = false,this.providerData});
  ProviderData? providerData;
  bool isBranch;
  @override
  Widget build(BuildContext context) {
    return providerData!=null?InkWell(
      onTap: (){
       try{
         FastCubit.get(context).productsModel = null;
         FastCubit.get(context).providerId = providerData?.id??'';
         FastCubit.get(context).providerProductId = providerData!.childCategoriesModified!.isNotEmpty?providerData!.childCategoriesModified![0].id??"":'';
         FastCubit.get(context).providerBranchesModel=null;
         FastCubit.get(context).providerBranchesId = providerData?.id??'';
         FastCubit.get(context).getAllProductsBranches();
         if(FastCubit.get(context).providerProductId.isNotEmpty){
           FastCubit.get(context).getAllProducts();
         }
         navigateTo(context, RestaurantScreen(providerData!,isBranch: isBranch,));
       }catch(e){
         print(e.toString());
       }
      },
      child: Container(
        width: double.infinity,
        height: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          border: Border.all(color: Colors.grey)
        ),
        padding: const EdgeInsets.only(right: 5,left: 5,bottom: 5,top: 5),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: ImageNet(image:providerData!.personalPhoto??'',fit: BoxFit.cover,),
            ),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  providerData!.name??'',
                  style: TextStyle(fontSize: 16),
                ),
                // Text(
                //   'Pickup & Dine In Service',
                //   style: TextStyle(fontSize: 11),
                // ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Images.star,width: 15,),
                    const SizedBox(width: 5,),
                    Text(
                      '${providerData!.totalRate??0} (${providerData!.totalRateCount})',
                      style: TextStyle(fontSize: 10,color: Colors.grey),
                    ),
                    SizedBox(width: size!.width*.01,),
                    if(providerData!.distance!=null)
                    Image.asset(Images.location,width: 15,),
                    if(providerData!.distance!=null)
                    const SizedBox(width: 5,),
                    if(providerData!.distance!=null)
                    Text(
                      providerData!.distance!,
                      style: TextStyle(fontSize: 10,color: Colors.grey),
                    ),
                    if(providerData!.duration!=null)
                      SizedBox(width: size!.width*.01,),
                    if(providerData!.duration!=null)
                      Image.asset(Images.timer,width: 15,),
                    const SizedBox(width: 5,),
                    Text.rich(
                      TextSpan(
                        text:'${providerData!.duration??''} | ',
                        style: TextStyle(fontSize: 10,color: Colors.grey),
                        children: [
                          TextSpan(
                            text: providerData?.crowdedStatus ==1 ?tr('crowded'):tr('not_crowded'),
                            style: TextStyle(fontSize: 10)
                          )
                        ]
                      )
                    ),
                    SizedBox(width: size!.width*.01,),
                    CircleAvatar(
                      backgroundColor:providerData?.openStatus == 'open'? Colors.green:Colors.red,
                      radius: 5,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      tr(providerData?.openStatus??'open'),
                      style: TextStyle(fontSize: 10,color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ):SizedBox();
  }
}
