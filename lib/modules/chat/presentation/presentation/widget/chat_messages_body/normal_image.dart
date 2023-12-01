import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


const double BUBBLE_RADIUS_IMAGE = 16;

class BubbleNormalImageUpdate extends StatelessWidget {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final String id;
  final Widget image;
  final double bubbleRadius;
  final bool isMe;
  final String caption;
  final String time;
  final String userName;

  final void Function()? onTap;

  const BubbleNormalImageUpdate({
    Key? key,
    required this.id,
    required this.image,
    this.bubbleRadius = BUBBLE_RADIUS_IMAGE,
    this.isMe = true,
    this.onTap,
    this.time = "",
    this.caption = "", required this.userName,
  }) : super(key: key);

  /// image bubble builder method
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isMe
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .6,
          ),
          child: GestureDetector(
              onTap: onTap ??
                  () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return _DetailScreen(
                        tag: id,
                        image: image,
                      );
                    }));
                  },
              child: Container(
                decoration: BoxDecoration(
                  color: isMe ? Theme.of(context).primaryColor :  Colors.blueGrey,
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(bubbleRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Hero(
                            tag: id,
                            child: Container(
                                height: 300,
                                child: Center(child: image)),
                          ),
                          caption.isEmpty
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Html(
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(14.0),
                                        color: isMe ?  Colors.white : Colors.black,
                                      ),
                                    },
                                    data: caption ?? "",
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}

/// detail screen of the image, display when tap on the image bubble
class _DetailScreen extends StatefulWidget {
  final String tag;
  final Widget image;

  const _DetailScreen({Key? key, required this.tag, required this.image}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

/// created using the Hero Widget
class _DetailScreenState extends State<_DetailScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: widget.tag,
            child: widget.image,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
