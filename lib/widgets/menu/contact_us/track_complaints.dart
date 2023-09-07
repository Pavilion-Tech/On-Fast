import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/models/contact_us_model.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/modules/menu/cubit/menu_states.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../shimmer/default_list_shimmer.dart';

class TrackComplaints extends StatelessWidget {
  const TrackComplaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ConditionalBuilder(
        condition: cubit.contactUsModel?.data?.data!= null,
        fallback: (c)=>DefaultListShimmer(havePadding: false),
        builder: (c)=> ConditionalBuilder(
          condition: cubit.contactUsModel!.data!.data!.isNotEmpty,
          builder: (c){
            Future.delayed(Duration.zero,(){
              cubit.paginationContactUs();
            });
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (c,i)=>itemBuilder(cubit.contactUsModel!.data!.data![i]),
                      separatorBuilder:(c,i)=> const SizedBox(height: 20,),
                      padding: EdgeInsets.zero,
                      controller: cubit.contactusScrollController,
                      itemCount: cubit.contactUsModel!.data!.data!.length
                  ),
                ),
                if(state is GetContactUsLoadingState)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: CupertinoActivityIndicator(),
                  ),
              ],
            );
          },
          fallback: (c)=> Column(
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
        ),
      ),
    );
  },
);
  }


  Widget itemBuilder(ContactUsData data){
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
                '${tr('complaints')} #${data.itemNumber??''}',
                style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.black),
              ),
              const Spacer(),
              Text(
                data.status==1?tr('not_solved'):tr('solved'),
                style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.createdAt??'',
            style:const TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
