import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class LangDialog extends StatefulWidget {
  const LangDialog({Key? key}) : super(key: key);

  @override
  State<LangDialog> createState() => _LangDialogState();
}

class _LangDialogState extends State<LangDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            itemBuilder(
              title: tr('en'),
              image: Images.en,
              isSelected: myLocale == 'en',
            ),
            const SizedBox(height: 20,),
            itemBuilder(
              title: tr('ar'),
              image: Images.flag8,
              isSelected: myLocale == 'ar',
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder({
  required String title,
  required String image,
  required bool isSelected,
}){
    return InkWell(
      onTap: (){
        setState(() {
          myLocale == 'en'? myLocale = 'ar':myLocale = 'en';
          context.setLocale(Locale(myLocale));
          CacheHelper.saveData(key: 'locale', value: myLocale);
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          color:isSelected? defaultColor:Colors.white,
          borderRadius: BorderRadiusDirectional.circular(5),
          border: Border.all(color: defaultColor)
        ),
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 10,
                color: isSelected ?Colors.white:defaultColor
              ),
            ),
            const Spacer(),
            Image.asset(image,width: 27,)
          ],
        ),
      ),
    );
  }

}
