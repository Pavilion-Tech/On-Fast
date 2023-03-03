import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';

class TrackComplaints extends StatelessWidget {
  const TrackComplaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Image.asset(Images.noCompaints,width: size!.width*.6,),
          Text(
            tr('opps'),
            style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
          ),
          Text(
            tr('no_complaints'),
            style:const TextStyle(color: Colors.black54,fontWeight: FontWeight.w400,fontSize: 13),
          ),
          Text(
            tr('if_you'),
            textAlign: TextAlign.center,
            style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
          ),
        ],
      ),
    );
  }

  // ListView.separated(
  // itemBuilder: (c,i)=>itemBuilder(),
  // separatorBuilder:(c,i)=> const SizedBox(height: 20,),
  // itemCount: 3
  // )

  Widget itemBuilder(){
    return Container(
      height: 63,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.grey.shade200
      ),
      alignment: AlignmentDirectional.center,
      padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${tr('complaints')} #225354',
                style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.black),
              ),
              const Spacer(),
              Text(
                'Solved',
                style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Date 20June 2019',
            style:const TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
