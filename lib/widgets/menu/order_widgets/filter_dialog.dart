import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

class FilterDialog extends StatefulWidget {
  FilterDialog ({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int currentIndex = 0;

  List<String> titles = [
    'new',
    'pending',
    'ready',
    'completed',
    'cancel',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(50),
      ),
      contentPadding: EdgeInsets.zero,
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      content:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemBuilder(
                title:titles[0] , index: 0
            ),Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: itemBuilder(
                  title:titles[1] , index: 1
              ),
            ),itemBuilder(
                title:titles[2] , index: 2
            ),Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: itemBuilder(
                  title:titles[3] , index: 3
              ),
            ),itemBuilder(
                title:titles[4] , index: 4
            ),
            const SizedBox(height: 30,),
            DefaultButton(text: tr('apply'), onTap: (){})
          ],
        ),
      ),
    );
  }

  Widget itemBuilder({
  required String title,
  required int index,
}){
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Container(
          height: 40,
          key: ValueKey(currentIndex == index),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(37),
            border: Border.all(color: currentIndex == index?defaultColor:Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(currentIndex == index)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5),
                child: Icon(Icons.check,color: defaultColor,),
              ),
              Text(
                tr(title),
                style: TextStyle(color: currentIndex == index ?defaultColor:Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
