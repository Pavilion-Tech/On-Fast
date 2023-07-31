class CategoryModel {
  bool? status;
  String? msg;
  Body? body;

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? categoryName;
  String? categoryImg;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
  }


}