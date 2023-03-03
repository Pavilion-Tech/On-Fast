import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

class CategoryModel{
  String image;
  String title;
  CategoryModel({required this.title,required this.image});
}

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  int currentIndex = 0;
  List<CategoryModel> categories = [
    CategoryModel(
        title: 'Pizza',
        image: Images.pizza,
    ), CategoryModel(
        title: 'Burger',
        image: Images.burger,
    ), CategoryModel(
        title: 'Coffee',
        image: Images.coffee,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          itemBuilder: (c,i)=>categoryItem(
              categories[i],
              i
          ),
          separatorBuilder: (c,i)=>const SizedBox(width: 10,),
          itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget categoryItem(CategoryModel category,int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: 30,
        padding:const EdgeInsetsDirectional.only(start: 10,end: 40),
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(48),
          color: currentIndex == index?defaultColor:Colors.grey.shade400
        ),
        child: Row(
          children: [
            Image.asset(category.image,width: 30,height: 25,),
            const SizedBox(width: 5,),
            Text(
              category.title,
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



