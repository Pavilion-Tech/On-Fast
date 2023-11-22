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
                "})()");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print("onPageFinished");
            if (url.contains('success_payment')){
              Timer(const Duration(seconds: 1), () {
                 print("urlurlurl");

                 navigateAndFinish(context, FastLayout());
              });
            }
            if (url.contains('failed_payment')){
              Timer(const Duration(seconds: 1), () {
                UTI.showSnackBar(context, "عذرا حدث خطألم نستطيع اكمال الدفع", "error");
                FastCubit.get(context).changeIndex(0);
                navigateAndFinish(context, FastLayout());
              });
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {

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

                     Navigator.pop(context);

                    },
                  ),

                ],
              );
            }),
          ),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.pop(context);
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
