import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';

class PickUpTime extends StatelessWidget {
  PickUpTime(this.time);

  String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('pick_up_time'),
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Image.asset(Images.calendar,width: 28,),
            const SizedBox(width: 10,),
            Text(
              '${tr('pick_up_time')}  $time',
              style:const TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
