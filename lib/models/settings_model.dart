class SettingsModel {
  bool? status;
  String? msg;
  Body? body;

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

}

class Body {
  List<Cities>? cities;
  Terms? terms;
  AboutUs? aboutUs;
  List<ContactUsType>? contactUsType;
  SocialLinks? socialLinks;
  List<ReadyOrderRange>? readyOrderRange;
  List<Categories>? categories;
  List<Zones>? zones;


  Body.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    terms = json['terms'] != null ? new Terms.fromJson(json['terms']) : null;
    aboutUs = json['about_us'] != null
        ? new AboutUs.fromJson(json['about_us'])
        : null;
    if (json['contact_us_type'] != null) {
      contactUsType = <ContactUsType>[];
      json['contact_us_type'].forEach((v) {
        contactUsType!.add(new ContactUsType.fromJson(v));
      });
    }
    socialLinks = json['social_links'] != null
        ? new SocialLinks.fromJson(json['social_links'])
        : null;
    if (json['ready_order_range'] != null) {
      readyOrderRange = <ReadyOrderRange>[];
      json['ready_order_range'].forEach((v) {
        readyOrderRange!.add(ReadyOrderRange.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['zones'] != null) {
      zones = <Zones>[];
      json['zones'].forEach((v) {
        zones!.add(Zones.fromJson(v));
      });
    }
  }

}

class Cities {
  int? id;
  String? nameAr;
  String? nameEn;
  String? lat;
  String? lng;

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    lat = json['lat'];
    lng = json['lng'];
  }

}

class Terms {
  String? termsAr;
  String? termsEn;

  Terms.fromJson(Map<String, dynamic> json) {
    termsAr = json['terms_ar'];
    termsEn = json['terms_en'];
  }

}

class AboutUs {
  String? aboutUsAr;
  String? aboutUsEn;

  AboutUs.fromJson(Map<String, dynamic> json) {
    aboutUsAr = json['about_us_ar'];
    aboutUsEn = json['about_us_en'];
  }

}

class ContactUsType {
  int? id;
  String? nameAr;
  String? nameEn;

  ContactUsType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

}

class SocialLinks {
  String? whatsApp;
  String? faceBook;
  String? instagram;
  String? twitter;
  String? email;
  String? phone;

  SocialLinks.fromJson(Map<String, dynamic> json) {
    whatsApp = json['WhatsApp'];
    faceBook = json['FaceBook'];
    instagram = json['Instagram'];
    twitter = json['Twitter'];
    email = json['Email'];
    phone = json['Phone'];
  }

}

class ReadyOrderRange {
  int? id;
  String? name;

  ReadyOrderRange.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}

class Categories {
  int? id;
  String? categoryName;
  String? categoryImg;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
  }


}

class Zones {
  int? id;
  String? zoneName;


  Zones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneName = json['zone_name'];
  }
}
