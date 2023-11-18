import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/shimmer/default_list_shimmer.dart';
import '../../../widgets/home/filter_bottom_sheet.dart';
import '../../../widgets/item_shared/category_widget.dart';
import '../../../widgets/item_shared/defult_form.dart';
import '../../../widgets/item_shared/filter.dart';
import '../../../widgets/item_shared/provider_item.dart';
import '../cubits/home_category_cubit/home_category_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: InkWell(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: SafeArea(
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
                            child: Image.asset(Images.search, width: 16,
                              color: Colors.grey.shade500,),
                          ),
                          controller: controller,
                          onChange: (str){
                            if(str.isNotEmpty){
                              cubit.getProviderCategorySearch(search: str);
                            }else{
                              cubit.providerCategorySearchModel = null;
                              cubit.emitState();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CategoryWidget(data: cubit.categoriesModel!.data,isSearch: true),
                        ),
                        Expanded(
                            child: ConditionalBuilder(
                              condition: state is! ProviderCategorySearchLoadingState,
                              fallback: (c)=>DefaultListShimmer(havePadding: false),
                              builder: (c)=> ConditionalBuilder(
                                condition: cubit.providerCategorySearchModel!=null,
                                fallback: (c)=>const SizedBox(),
                                builder: (c)=> ConditionalBuilder(
                                  condition: cubit.providerCategorySearchModel!.data!.data!.isNotEmpty,
                                  fallback: (c)=>AutoSizeText(tr('no_results'),
                                    minFontSize: 8,
                                    maxLines: 1,),
                                  builder: (c){
                                    Future.delayed(Duration.zero,(){
                                      cubit.paginationProviderCategorySearch(controller.text);
                                    });
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: ListView.separated(
                                            itemBuilder: (c, i) => ProviderItem(providerData: cubit.providerCategorySearchModel!.data!.data![i]),
                                            separatorBuilder: (c, i) =>
                                            const SizedBox(height: 20,),
                                            controller: cubit.providerSearchScrollController,
                                            itemCount: cubit.providerCategorySearchModel!.data!.data!.length,
                                          ),
                                        ),
                                        if(state is ProviderCategorySearchLoadingState)
                                          CupertinoActivityIndicator()
                                      ],
                                    );
                                  }
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: AlignmentDirectional.bottomEnd,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 20, right: 20, bottom: 50),
                  //     child: FilterWidget(
                  //           () {
                  //         showModalBottomSheet(
                  //             context: context,
                  //             shape: const RoundedRectangleBorder(
                  //                 borderRadius: BorderRadiusDirectional.only(
                  //                   topEnd: Radius.circular(50),
                  //                   topStart: Radius.circular(50),
                  //                 )
                  //             ),
                  //             builder: (context) => FilterBottomSheet()
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


