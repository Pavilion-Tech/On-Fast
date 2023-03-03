import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import '../../../widgets/home/filter_bottom_sheet.dart';
import '../../../widgets/item_shared/category_widget.dart';
import '../../../widgets/item_shared/defult_form.dart';
import '../../../widgets/item_shared/filter.dart';
import '../../../widgets/item_shared/product_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  DefaultForm(
                    hint: tr('find_restaurant'),
                    suffix: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(Images.search,width: 16,color: Colors.grey.shade500,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CategoryWidget(),
                  ),
                  Expanded(
                      child: ListView.separated(
                        itemBuilder: (c,i)=>ProductItem(),
                        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                        itemCount: 5,
                      )
                  )
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),
                child: FilterWidget(
                  () {
                    showModalBottomSheet(
                        context: context,
                        shape:const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(50),
                              topStart: Radius.circular(50),
                            )
                        ),
                        builder: (context)=>FilterBottomSheet()
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


