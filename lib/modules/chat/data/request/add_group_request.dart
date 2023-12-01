import 'dart:io';

import 'package:dio/dio.dart';


class AddGroupRequest {

    String groupName;  String groupImage;  List<int> groupUsers;



  AddGroupRequest({required this.groupName, required  this.groupImage,required this.groupUsers, });

  Future< Map<String, dynamic>> toRequest() async => {

    "group_name":groupName,
    "users[]":groupUsers,
    'group_image': await MultipartFile.fromFile(
      groupImage,
      filename:  groupImage.split('/').last,
    ),


  };


}