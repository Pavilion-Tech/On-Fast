import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../modules/home/search/seach_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

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
          const SizedBox(height: 20,),
          SizedBox(
            height: 145,
            child: ListView.separated(
                itemBuilder: (c,i){
                  return Container(
                    height: 142,
                    width: size!.width*.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(21)
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
                  );
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (c,i)=>const SizedBox(width: 30,),
                itemCount: 3
            ),
          )
        ],
      ),
    );
  }
}
