import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../models/provider_products_model.dart';


class ExtraWidget extends StatefulWidget {

  ExtraWidget(this.extras);

  List<Extra> extras;
  List<String> extraId = [];

  @override
  State<ExtraWidget> createState() => _ExtraWidgetState();
}

class _ExtraWidgetState extends State<ExtraWidget> {
  List<int> indexes = [];


  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Wrap(
      spacing: 15,
      runSpacing: 15,
      children: List.generate(widget.extras.length, (i) =>itemBuilder(widget.extras[i],i)),
    ),
  );
  }

  Widget itemBuilder(Extra model,int index){
    return model.name!=''?InkWell(
      onTap: (){
        setState(() {
          if(indexes.any((element) => index == element)){
            indexes.remove(index);
            widget.extraId.remove(model.id);
          }else{
            indexes.add(index);
            widget.extraId.add(model.id??'');
          }
        });
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: indexes.any((element) => index == element) ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                model.name??'',
                style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              ),
            ),
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
