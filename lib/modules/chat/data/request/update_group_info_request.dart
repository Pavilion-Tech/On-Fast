import 'dart:io';

import 'package:dio/dio.dart';
import '../response/get_group_info_response.dart';

class UpdateGroupInfoRequest {
  fromInfo(GroupInfoData? info) {
    name = info?.chatRoomName;
    oldImage = info?.chatRoomImage ;
    groupId = info?.chatRoomId.toString() ;

  }

  File? image;
  String? oldImage;
  String? name;
  String? groupId;


  UpdateGroupInfoRequest();

  Future< Map<String, dynamic>> toRequest() async => {

    'group_name':   name,
    'group_image': await _getImage(),
    'group_id': groupId,


  };

  Future<MultipartFile?> _getImage() async {
    if (image == null) return null;
    print("imageimageimageFile");
    print(image);
    return MultipartFile.fromFile(
      image!.path,
      filename: image!.path.split('/').last,
    );
  }
}