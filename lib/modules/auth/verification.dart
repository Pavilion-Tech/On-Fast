import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

import '../../layout/layout_screen.dart';
import '../../shared/components/constant.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  int _start = 60;

  bool timerFinished = false;

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 40,left: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30,bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('verification'),
              style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 30),
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: tr('enter_code_from_phone'),
                style: TextStyle(color: Colors.grey.shade600),
                children: [
                  TextSpan(
                    text: '32545 3621 2545',
                      style: const TextStyle(color: Colors.black)
                  )
                ]
              )
            ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 40),
             child: RawKeyboardListener(
               focusNode: FocusNode(),
               onKey: (RawKeyEvent event) {
                 if (event.logicalKey.keyLabel == 'Backspace') {
                   myLocale =='ar'
                       ? FocusManager.instance.primaryFocus!.nextFocus()
                       :FocusManager.instance.primaryFocus!.previousFocus();                 }
               },
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   OTPWidget(autofocus: myLocale == 'ar'?false:true),
                   OTPWidget(),
                   OTPWidget(),
                   OTPWidget(autofocus: myLocale == 'ar'?true:false),
                 ],
               ),
             ),
           ),
            const SizedBox(height: 10,),
            if (!timerFinished)
              Text(
                '00:$_start',
              ),
            if (timerFinished)
              InkWell(
                onTap: () {
                  timer;
                  _start = 60;
                  timerFinished = false;
                  startTimer();
                },
                child:Text(
                  tr('try_again'),
                ),
              ),
            const SizedBox(height: 10,),
            DefaultButton(
                text: tr('verify'),
                onTap: (){
                  navigateAndFinish(context, FastLayout());
                }
            )
          ],
        ),
      ),
    );
  }
}


class OTPWidget extends StatelessWidget {

  OTPWidget({this.autofocus = false,this.onFinished});

  bool autofocus;
  VoidCallback? onFinished;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        autofocus:autofocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '*',
          hintStyle:const TextStyle(fontSize: 40),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(color:Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:defaultColor)
          )
        ),
        onChanged: (value) {
          if(value.isNotEmpty){
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.previousFocus()
                :FocusManager.instance.primaryFocus!.nextFocus();
            if(onFinished!=null)onFinished!();
          }else{
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.nextFocus()
                :FocusManager.instance.primaryFocus!.previousFocus();
          }
          },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

