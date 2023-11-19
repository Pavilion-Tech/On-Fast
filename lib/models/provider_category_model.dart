import 'package:on_fast/models/category_model.dart';

class ProviderCategoryModel {
  String? message;
  bool? status;
  Data? data;

  ProviderCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class ProviderBranchesModel {
  String? message;
  bool? status;
  Data? data;

  ProviderBranchesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<ProviderData>? data;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
      });
    }
  }

}

class ProviderData {


  String? id;
  int? itemNumber;
  String? name;
  String? email;
  String? country;
  List<String>? categoryId;
  String? currentLatitude;
  String? currentLongitude;
  String? firebaseToken;
  String? whatsappNumber;
  String? phoneNumber;
  String? personalPhoto;
  String? currentLanguage;
  int? totalRate;
  int? totalRateNumber;
  int? totalRateCount;
  int? crowdedStatus;
  int? openingTime;
  int? closingTime;
  int? status;
  List<CategoryData>? childCategoriesModified;
  List<CategoryData>? categories;
  String? createdAt;
  String? deliveryTime;
  String? deliveryFees;
  String? deliveryBy;
  bool? notifyMe;
  bool? isFavorited;
  String? distance;
  String? duration;
  String? openStatus;


  ProviderData.fromJson(Map<String, dynamic> json) {
    notifyMe = json['notify_me'];
    distance = json['distance'];
    duration = json['duration'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    openStatus = json['opeing_status'];
    isFavorited = json['is_favorited'];
    id = json['id'];
    itemNumber = json['item_number'];
    deliveryTime = json['delivery_time'].toString();
    deliveryFees = json['delivery_fees'].toString();
    deliveryBy = json['delivery_by'].toString();
    name = json['name'];
    email = json['email'];
    country = json['country'];
    categoryId = json['category_id'].cast<String>();
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    totalRate = json['total_rate'];
    totalRateNumber = json['total_rate_number'];
    totalRateCount = json['total_rate_count'];
    crowdedStatus = json['crowded_status'];
    status = json['status'];
    if (json['child_categories_modified'] != null) {
      childCategoriesModified = <CategoryData>[];
      if(json['child_categories_modified'].isNotEmpty){
        json['child_categories_modified'].forEach((v) {
          childCategoriesModified!.add(CategoryData.fromJson(v));
        });
      }
    }  if (json['categories'] != null) {
      categories = <CategoryData>[];
      if(json['categories'].isNotEmpty){
        json['categories'].forEach((v) {
          categories!.add(CategoryData.fromJson(v));
        });
      }
    }
    createdAt = json['created_at'];
  }
}

