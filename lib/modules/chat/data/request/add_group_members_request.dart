import 'dart:io';

import 'package:dio/dio.dart';


class AddGroupMembersRequest {

  List<int> groupUsers;
  String groupId;



  AddGroupMembersRequest({required this.groupId,  required this.groupUsers, });

  Future< Map<String, dynamic>> toRequest() async => {

    "users[]":groupUsers,
    "group_id":groupId,



  };


}