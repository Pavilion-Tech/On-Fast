import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({
    required this.title,
    required this.subSubTitle,
    required this.subTitle,
    required this.subTitleDesc,
    required this.subSubTitleDesc,
});

  String title;
  String subTitle;
  String subTitleDesc;
  String subSubTitle;
  String subSubTitleDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Text(
                subTitle,
                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              Text(
                subTitleDesc,
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              subSubTitle,
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
            ),
            const Spacer(),
            Text(
              subSubTitleDesc,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
