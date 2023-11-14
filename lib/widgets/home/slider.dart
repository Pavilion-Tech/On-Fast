import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/home/map_screen.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../models/ads_model.dart';
import '../../modules/home/cubits/ads_cubit/ads_cubit.dart';
import '../../modules/home/cubits/ads_cubit/ads_states.dart';
import '../../modules/restaurant/restaurant_screen.dart';
import '../item_shared/image_net.dart';
import '../shimmer/ads_shimmer.dart';

class HomeSlider extends StatefulWidget {
  HomeSlider(this.closeTop);
  bool closeTop;

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdsCubit.get(context).getAds();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0,left: 20.0,bottom: 20.0),
      child: BlocConsumer<AdsCubit, AdsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var adsCubit = AdsCubit.get(context);
          if (adsCubit.adsModel ==null && state is GetAdsLoadingState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: AdsShimmer() ,
            );

          }
          if (adsCubit.adsModel ==null && state is GetAdsSuccessState) {
            return Container();
          }
          if (state is GetAdsErrorState) {
            // return UTI.dataEmptyWidget(noData: LocaleKeys.noDataFounded.tr(), imageName: ImgAssets.productNotFound);
            return Container();
          }
          return Column(
            children: [

              if(!widget.closeTop)const SizedBox(height: 20,),
              ConditionalBuilder(
                condition:AdsCubit.get(context).adsModel?.data?.imageAdvertisements?.isNotEmpty??true,
                fallback: (c)=>SizedBox(),
                builder: (c)=> AnimatedOpacity(
                  opacity: widget.closeTop?0:1,
                  duration: Duration(milliseconds: 500),
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: widget.closeTop?0:145,
                      child:CarouselSlider(
                        items: AdsCubit.get(context).adsModel!.data!.imageAdvertisements!.map((e) => bannerItem( imageAdvertisements: e,)).toList(),
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: 150,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlay: true,

                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            },
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(seconds: 3),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true),
                      )


                    // ListView.separated(
                    //     itemBuilder: (c,i){
                    //       return bannerItem(context, i);
                    //     },
                    //     physics: const BouncingScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     separatorBuilder: (c,i)=>const SizedBox(width: 30,),
                    //     itemCount: FastCubit.get(context).adsModel!.data!.imageAdvertisements!.length
                    // ),
                  ),
                ),
              ),
            ],
          );
        },


      ),
    );
  }

  InkWell bannerItem({required ImageAdvertisements imageAdvertisements} ) {
    return InkWell(
                      onTap: imageAdvertisements.type==1
                          ?null
                          :(){
                        if(imageAdvertisements.type==2){
                          openUrl(imageAdvertisements.link??'');
                        }else{
                          print("goooo");
                          print(imageAdvertisements.link);
                          navigateTo(context, RestaurantScreen(id: imageAdvertisements.link??'',isBranch: false,));
                          // FastCubit.get(context).singleProvider(imageAdvertisements.link??'',context);
                        }
                      },
                      child: Container(
                        height: 142,
                        width: size!.width*.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(21)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ImageNet(image:imageAdvertisements.backgroundImage??'',fit: BoxFit.cover,),
                      ),
                    );
  }
}
