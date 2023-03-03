import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';

import 'notify_dialog.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  bool isNotified = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              tr('location'),style:const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 260,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('working_time'),style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          'Everyday',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          '09:30 AM - 11:30 ',style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('notify_me'),style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          tr('when_open'),style:const TextStyle(
                            fontWeight: FontWeight.w300,color: Colors.grey
                        ),
                        ),
                        const Spacer(),
                        InkWell(
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          onTap: (){
                            if(!isNotified){
                              showDialog(
                                  context: context,
                                  builder: (context)=>const NotifyDialog()
                              );
                            }
                            setState(() {
                              isNotified = ! isNotified;
                            });
                          },
                            child: AnimatedSwitcher(
                              duration:const Duration(milliseconds: 500),
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  return ScaleTransition(scale: animation, child: child);
                                },
                                child: Image.asset(isNotified?Images.notifyYes:Images.notifyNo,width: 33.5,key: ValueKey(isNotified),)))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset(Images.pickUp,width: 79,),
                    Text(
                      tr('pick_up')
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset(Images.dineIn2,width: 79,),
                    Text(
                      tr('dine_in')
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
