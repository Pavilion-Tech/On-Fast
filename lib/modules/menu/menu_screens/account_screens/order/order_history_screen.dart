import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/modules/home/search/seach_screen.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/modules/menu/cubit/menu_states.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/defult_form.dart';

import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/item_shared/filter.dart';
import '../../../../../widgets/menu/order_widgets/filter_dialog.dart';
import '../../../../../widgets/menu/order_widgets/history_order_item.dart';
import '../../../../../widgets/shimmer/default_list_shimmer.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);

  late FilterDialog filterDialog;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    filterDialog  = FilterDialog(controller: controller,);
    MenuCubit.get(context).getAllOrders();
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return Scaffold(
          body: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: SizedBox(
              height: size!.height,
              child: Column(
                children: [
                  DefaultAppBar(tr('orders_history')),
                  Expanded(
                    child: ConditionalBuilder(
                        condition: cubit.orderModel!=null,
                        fallback: (c)=>DefaultListShimmer(),
                        builder: (c){
                          Future.delayed(Duration.zero,(){
                            cubit.paginationOrders(
                                status: filterDialog.currentIndex==5?null:filterDialog.currentIndex,
                              searchText: controller.text
                            );
                          });
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: DefaultForm(
                                          hint: tr('search_order'),
                                          type: TextInputType.number,
                                          controller: controller,
                                          onChange: (str){
                                            cubit.getAllOrders(searchText: str,status: filterDialog.currentIndex==5?null:filterDialog.currentIndex);
                                          },
                                        )
                                    ),
                                    const SizedBox(width: 20,),
                                    FilterWidget(() {
                                      showDialog(
                                          context: context,
                                          builder: (context) => filterDialog
                                      );
                                    })
                                  ],
                                ),
                                Expanded(
                                  child: ConditionalBuilder(
                                    condition: cubit.orderModel!.data!.data!.isNotEmpty,
                                    fallback: (c)=>Center(child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.splashImage,width: 200,),
                                        const SizedBox(height: 10,),
                                        Text(tr('no_orders'),style: TextStyle(color: defaultColor,fontSize: 20)),
                                      ],
                                    ),),
                                    builder: (c)=> ListView.separated(
                                        itemBuilder: (c, i) => HistoryOrderItem(cubit.orderModel!.data!.data![i]),
                                        separatorBuilder: (c, i) =>
                                        const SizedBox(height: 20,),
                                        padding: EdgeInsets.zero,
                                        controller:cubit.orderScrollController,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: cubit.orderModel!.data!.data!.length
                                    ),
                                  ),
                                ),
                                if(state is OrderLoadingState)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40.0),
                                    child: CupertinoActivityIndicator(),
                                  ),
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }
}
