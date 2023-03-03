import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


// Future<XFile?> checkImageSize (XFile? image)async{
//   if(image!=null) {
//     final bytes = (await image.readAsBytes()).lengthInBytes;
//     final kb = bytes / 1024;
//     final mb = kb / 1024;
//     if(mb<5.0){
//       return image;
//     }else {
//       showToast(msg: tr('image_size'));
//       return null;
//     }
//   }
// }

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false,
  );
}




Future showToast ({required String msg , bool? toastState})
{
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    fontSize: 16.0,
    backgroundColor: toastState != null
        ? toastState ?Colors.yellow[900]
        : Colors.red : Colors.green,
  );
}

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
//
//
// checkNet(context) {
//   if (!isConnect!) {
//     navigateTo(context,const NoInterNet(),);
//   }
// }

