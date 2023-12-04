import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/layout_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/uti.dart';
import 'checkout_done.dart';


class WebViewCustomScreen extends StatefulWidget {
  final String? url;
  final String? title;
  final AppBar? appBar;
  final bool enableForward;

  const WebViewCustomScreen(
      {Key? key,
      this.title,
      required this.url,
      this.appBar,
      this.enableForward = false})
      : super(key: key);

  @override
  _WebViewCustomScreenState createState() => _WebViewCustomScreenState();
}

class _WebViewCustomScreenState extends State<WebViewCustomScreen> {
  bool isLoading = false;
  String html = '';
  String url = '';
  late WebViewController _webViewController;

  @override
  void initState() {
    // #docregion platform_features
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    final WebViewController webViewController =
        WebViewController.fromPlatformCreationParams(params);

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            isLoading=progress!=100;
            print("progress");
            print(progress);
            setState(() {

            });
            webViewController.runJavaScriptReturningResult(
                "javascript:(function() { "
                "var head = document.getElementsByTagName('header')[0];"
                "head.parentNode.removeChild(head);"
                "var sale = document.getElementsByClassName('hot-sale-bar')[0];"
                "sale.parentNode.removeChild(sale);"
                "var footer = document.getElementsByClassName('footer-bottom dark_style')[0];"
                "footer.parentNode.removeChild(footer);"
                "})()"
            );
          },
          onPageStarted: (String url) {
            print("onPageStarted");
            print(url);
          },

          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
            Timer(const Duration(seconds: 1), () {
              print("success_payment");
              UTI.showSnackBar(context, "success payment", "success");
              //
              // navigateAndFinish(context, FastLayout());
            });
          },
          onPageFinished: (String url) {
            print("onPageFinished");
            this.url=url;
            print(url);
            // showDialog(context: context, barrierDismissible: false, builder: (context) =>
            //     CheckoutDone("",false));
            if (url.contains('completed')){
              Timer(const Duration(seconds: 1), () {
                 print("success_payment");
                 UTI.showSnackBar(context, "success payment", "success");
                 //
                 // navigateAndFinish(context, FastLayout());
              });
            }
            if (url.contains('cancelled')){
              print("failed_payment");
              Timer(const Duration(seconds: 1), () {
                UTI.showSnackBar(context, "عذرا حدث خطألم نستطيع اكمال الدفع", "error");

                // FastCubit.get(context).changeIndex(0);
                // navigateAndFinish(context, FastLayout());
              });
            }
          },

          onWebResourceError: (WebResourceError error) {
            print("onWebResourceError");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("NavigationRequest");
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? ''));
    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _webViewController = webViewController;
    super.initState();
  }

  /**
   * https://on-fast-dashboard.pavilionapps.com/complete-online-order/65606175b096ee891ab3f04d?complete_order_status=completed
   */
  /**
   *https://on-fast-dashboard.pavilionapps.com/complete-online-order/65606175b096ee891ab3f04d?tap_id=chg_TS04A2320231140u1YH2411051&data=C92A6F94C819F733E70155D80662EEAB28514CC651B8A20B9E9391A8047892A8F34E28E0F1E8458CA0D3882452964871831A13ACCFE606BB820EBF25E0217D6A452AD170463EE75998CA7982C39DBB049919C4C6406147366FAE093F8FB497F407638C2803E71E525B51B61E67FAE2A8C61AEFBF4B06F997B98DD12920FD598A4FECB4938496E8755E59B3CEBA0C550CD62037472E3DCB538E99CB1AF247089F228F9B143197CF13A428D0DB9B18DA044109924009F37DCCEF8248F30647ED048DD8F49089802FEE9983A99F45C593851CD7E7B5FC115A939AB8BA8706887FAD648C5A71C10FFDBF9D9D1A74002CD038292FD77293DB971B
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.appBar ??
          AppBar(
            backgroundColor: defaultColor,
            elevation: 0.0,
            title: Image.asset(
              Images.appIcon,
              height: 40,
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: Builder(builder: (buildContext) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () async {

                      FastCubit.get(context).changeIndex(0);
                      navigateAndFinish(context,FastLayout());

                    },
                  ),

                ],
              );
            }),
          ),
      body: WillPopScope(
        onWillPop: ()async{
          FastCubit.get(context).changeIndex(0);
          navigateAndFinish(context,FastLayout());
          return true;
        },
        child: Builder(builder: (BuildContext context) {
          if(isLoading) return Center(child: CircularProgressIndicator(color: defaultColor),);
          return  WebViewWidget(
            controller: _webViewController,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                Factory<TapGestureRecognizer>(
                    () => TapGestureRecognizer()..onTapDown = (tap) {})),
          );
        }),
      ),
    );
  }
}
