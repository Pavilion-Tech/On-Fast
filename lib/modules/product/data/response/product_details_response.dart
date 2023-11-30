import '../../../../models/provider_products_model.dart';

class ProductDetailsResponse {
  String? message;
  bool? status;
  ProductData? data;

  ProductDetailsResponse({this.message, this.status, this.data});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  ProductData.fromJson(json['data']) : null;
  }

}



class ProviderId {
  String? id;
  String? name;
  String? address;
  List<String>? categoryId;
  String? image;

  ProviderId({this.id, this.name, this.address, this.categoryId, this.image});

  ProviderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    categoryId = json['category_id'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    return data;
  }
}



