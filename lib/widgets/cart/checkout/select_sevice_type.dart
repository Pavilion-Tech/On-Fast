import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';

import '../../../shared/images/images.dart';

class SelectServiceType extends StatefulWidget {
  SelectServiceType({Key? key}) : super(key: key);

  int currentIndex = 1;


  @override
  State<SelectServiceType> createState() => _SelectServiceTypeState();
}

class _SelectServiceTypeState extends State<SelectServiceType> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsetsDirectional.only(top: 30.0,bottom: 10,start: 20),
          child: Text(
            tr('select_service'),
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Row(
          children: [
            itemBuilder(
              image: Images.pickUp,
              title: 'pick_up',
              index: 1
            ),
            itemBuilder(
                image: Images.dineIn2,
                title: 'dine_in',
              index: 2
            )
          ],
        ),
      ],
    );
  }

  Widget itemBuilder({
  required String image,
  required String title,
  required int index,
}){
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            widget.currentIndex = index;
          });
          FastCubit.get(context).emitState();
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                Image.asset(image,width: 78,),
                Text(
                  tr(title),
                  style:const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if(widget.currentIndex != index)
              Container(color: Colors.grey.shade100.withOpacity(.6),height: 120,width: 120,)
          ],
        ),
      ),
    );
  }
}
