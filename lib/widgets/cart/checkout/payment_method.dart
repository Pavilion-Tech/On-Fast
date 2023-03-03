import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

class PaymentMethodModel{
  String? image;
  String? title;
  PaymentMethodModel({
    this.title,
    this.image,
});
}

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  List<PaymentMethodModel> model = [
    PaymentMethodModel(image: Images.visa),
    PaymentMethodModel(image: Images.applePay),
    PaymentMethodModel(image: Images.mada),
    PaymentMethodModel(title: tr('pay_on_delivery')),
    PaymentMethodModel(title: '${tr('use_wallet_balance')}(250)'),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsetsDirectional.only(start: 10,bottom: 15),
          child: Text(
            tr('select_payment_method'),
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.separated(
              itemBuilder: (c,i)=>itemBuilder(model[i],i),
              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              physics:const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.zero,
              shrinkWrap: true,
              itemCount: model.length
          ),
        )

      ],
    );
  }

  Widget itemBuilder(PaymentMethodModel model,int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadiusDirectional.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            if(model.image!=null)
            Image.asset(model.image!,width: 54,),
            if(model.title!=null)
            Text(model.title!,style: TextStyle(fontSize: 16),),
            const Spacer(),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.grey.shade400,
              child:currentIndex == index? CircleAvatar(
                radius: 6,
                backgroundColor: defaultColor,
              ):null,
            ),
          ],
        ),
      ),
    );
  }
}



