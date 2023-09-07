import 'package:flutter/material.dart';
import 'package:on_fast/models/provider_products_model.dart';
import 'package:on_fast/shared/styles/colors.dart';


class SelectSize extends StatefulWidget {
  SelectSize(this.sizes);
  List<Sizes> sizes;

  late String sizedId;

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  int currentIndex = 0;


  @override
  void initState() {
    if(widget.sizes.isNotEmpty)
    Future.delayed(Duration.zero,(){
      setState(() {
        widget.sizedId = widget.sizes[0].id??'';
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
        children: List.generate(widget.sizes.length, (i) =>itemBuilder(widget.sizes[i],i)),
      ),
    );
  }

  Widget itemBuilder(Sizes model,int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
          widget.sizedId = model.id??'';
        });
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: currentIndex == index ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.name??'',
              style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                '${model.priceAfterDiscount??''}',
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
