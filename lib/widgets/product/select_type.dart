import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

class SelectTypeModel{
  SelectTypeModel({
    required this.size,
    required this.price,
    required this.index,
});
  String size;
  String price;
  int index;
}

class SelectType extends StatefulWidget {

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  int currentIndex = 0;

  List<SelectTypeModel> model = [
    SelectTypeModel(
      index: 0,
      price: '25',
      size: 'XL'
    ), SelectTypeModel(
      index: 1,
      price: '20',
      size: 'L'
    ), SelectTypeModel(
      index: 2,
      price: '15',
      size: 'M'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
          itemBuilder:(c,i)=> itemBuilder(model[i]),
          separatorBuilder: (c,i)=>const SizedBox(width: 8,),
          scrollDirection: Axis.horizontal,
          itemCount: model.length
      ),
    );
  }

  Widget itemBuilder(SelectTypeModel model){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = model.index;
        });
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: currentIndex == model.index ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'Option',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              '${model.price} AED',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
