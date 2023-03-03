import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

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
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
