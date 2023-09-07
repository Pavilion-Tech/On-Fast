import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../models/provider_products_model.dart';


class SelectType extends StatefulWidget {

  SelectType(this.types);

  List<Types> types;
  String typeId = '';

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  int currentIndex = 0;

  @override
  void initState() {
    if(widget.types.isNotEmpty)
    Future.delayed(Duration.zero,(){
      setState(() {
        widget.typeId = widget.types[0].id??'';
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Wrap(
      spacing: 15,
      runSpacing: 15,
      children: List.generate(widget.types.length, (i) =>itemBuilder(widget.types[i],i)),
    ),
  );
  }

  Widget itemBuilder(Types model,int index){
    return model.name!= ''?InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
          widget.typeId = model.id??'';
        });
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: currentIndex == index ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name??'',
              style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 5,),
            Text(
              '${model.price??''} AED',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ):SizedBox();
  }
}
