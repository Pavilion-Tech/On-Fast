import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  Note(this.note);
  String note;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('notes'),
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        Text(
          note,
          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
