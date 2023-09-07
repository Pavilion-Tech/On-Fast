import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/models/category_model.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

import 'image_net.dart';


class CategoryWidget extends StatefulWidget {
  CategoryWidget({this.data,this.isRestaurant = false,this.isSearch = false});

  List<CategoryData>? data;

  bool isRestaurant;
  bool isSearch;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  int currentIndex = 0;

  @override
  void initState() {
    if(widget.isSearch){
      if(widget.data!=null){
        FastCubit.get(context).categorySearchId = widget.data![0].id??'';
        FastCubit.get(context).emitState();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: widget.data!=null,
      fallback: (c)=>SizedBox(),
      builder: (c)=> SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: List.generate(widget.data!.length, (i) => categoryItem(widget.data![i],i)),
        ),
      ),
    );
  }

  Widget categoryItem(CategoryData category,int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
          if(widget.isSearch){
            FastCubit.get(context).categorySearchId = category.id??'';
            FastCubit.get(context).emitState();
          } else if(widget.isRestaurant){
            FastCubit.get(context).providerProductId = category.id??'';
            FastCubit.get(context).getAllProducts();
          }else{
            FastCubit.get(context).categoryId = category.id??'';
            FastCubit.get(context).getProviderCategory();
          }
        });
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: 30,
        padding:const EdgeInsetsDirectional.only(start: 10,end: 20),
        //alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(48),
          color: currentIndex == index?defaultColor:Colors.grey.shade400
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,height: 25,
              decoration: BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNet(image:category.image??'',),
            ),
            const SizedBox(width: 5,),
            Text(
              category.title??'',
              maxLines: 1,
              style: TextStyle(
                color: currentIndex == index?Colors.white:null
              ),
            ),
          ],
        ),
      ),
    );
  }
}



