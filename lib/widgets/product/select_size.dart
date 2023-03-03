import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

class SelectSizeModel{
  SelectSizeModel({
    required this.size,
    required this.height,
    required this.price,
    required this.index,
});
  String size;
  double height;
  String price;
  int index;
}

class SelectSize extends StatefulWidget {

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  int currentIndex = 0;

  List<SelectSizeModel> model = [
    SelectSizeModel(
      height: 34,
      index: 0,
      price: '25',
      size: 'XL'
    ), SelectSizeModel(
      height: 31,
      index: 1,
      price: '20',
      size: 'L'
    ), SelectSizeModel(
      height: 29,
      index: 2,
      price: '15',
      size: 'M'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        itemBuilder(model[0]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: itemBuilder(model[1]),
        ),
        itemBuilder(model[2]),
      ],
    );
  }

  Widget itemBuilder(SelectSizeModel model){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = model.index;
        });
      },
      child: Container(
        height: model.height,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: currentIndex == model.index ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        alignment: AlignmentDirectional.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.size,
              style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                model.price,
                style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              'AED',
              style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
