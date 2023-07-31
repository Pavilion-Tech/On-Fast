class HomeModel {
  bool? status;
  String? msg;
  Body? body;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

}

class Body {
  List<Categories>? categories;

  Body.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

}

class Categories {
  int? categoryId;
  List<Restaurants>? restaurants;

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add( Restaurants.fromJson(v));
      });
    }
  }

}

class Restaurants {
  int? id;
  String? restaurantName;
  String? restaurantImg;
  int? serviceId;
  String? address;
  Null? lat;
  Null? lng;
  int? busyStatus;
  String? startTime;
  String? endTime;
  String? startDay;
  String? endDay;
  int? rate;
  int? cityId;
  int? readyOrderRange;
  List<Services>? services;
  int? restaurantOpenOrClose;
  bool? isReminder;
  String? distance;


  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurant_name'];
    restaurantImg = json['restaurant_img'];
    serviceId = json['service_id'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    busyStatus = json['busy_status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startDay = json['start_day'];
    endDay = json['end_day'];
    rate = json['rate'];
    cityId = json['city_id'];
    readyOrderRange = json['ready_order_range'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    restaurantOpenOrClose = json['restaurant_open_or_close'];
    distance = json['distance'];
    isReminder = json['is_reminder'];
  }

}

class Services {
  int? id;
  String? name;

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}


