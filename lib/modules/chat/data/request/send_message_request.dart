import 'dart:io';

import 'package:dio/dio.dart';

import '../../presentation/presentation/widget/image_picker_helper/compress_file.dart';


class SendMessageRequest {



  String? to;
  String? type;
  String? message;
  String? image;
  String? voice;
  String? video;
  String? doc;
  String? roomType;
  String? roomId;


  @override
  String toString() {
    return 'SendMessageRequest{to: $to, message: $message, roomType: $roomType, roomId: $roomId}, image: $image}';
  }

  SendMessageRequest({  this.to,   this.message,  this.roomType,  this.roomId,this.image,  this.type,
    this.voice,this.video,this.doc});

  Future< Map<String, dynamic>> toRequest() async => {

     if(roomType=="Private") 'to':   to,
    if(message !=null) 'message': message,
    'room_type': roomType,
    if(roomType=="Gruppe")  'room_id': roomId,
    if(image !=null) 'image':await _handleImages( ) ,
    if(voice !=null) 'voice': await MultipartFile.fromFile(
      voice!,
      filename:  voice!.split('/').last,
    ),
    if(video !=null) 'video':  await MultipartFile.fromFile(
      video!,
      filename: video?.split('/')
          .last,
    ),
    if(doc !=null) 'doc': await MultipartFile.fromFile(
      doc!,
      filename:  doc!.split('/').last,
    ),

  };

    _handleImages( ) async {
      var element = await CompressImage.compressImage(File(image ?? ""));
      var s = await MultipartFile.fromFile(
        element.path,
        filename: element.path
            .split('/')
            .last,
      );
      return s;
    }









  // _handleVideo( ) async {
  //
  //
  //
  //
  //   String?  element =  await compressVideo(video!);
  //     print("after compress");
  //     print(element);
  //     var s = await MultipartFile.fromFile(
  //       element!,
  //       filename: element.split('/')
  //           .last,
  //     );
  //     return s;
  //   }
  // Future<String?> compressVideo(String videoPath) async {
  //   // Compress the video
  //   final compressedVideo = await VideoCompress.compressVideo(
  //     videoPath,
  //     quality: VideoQuality.DefaultQuality,
  //     );
  //   print("compressedVideo.filesize");
  //   print(compressedVideo?.filesize);
  //   return compressedVideo?.path;
  // }
}