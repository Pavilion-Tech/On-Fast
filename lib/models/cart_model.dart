class CartModel {
  String? message;
  bool? status;
  Data? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  CartData? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }

}

class CartData {
  List<Cart>? cart;
  InvoiceSummary? invoiceSummary;

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    invoiceSummary = json['invoice_summary'] != null
        ? new InvoiceSummary.fromJson(json['invoice_summary'])
        : null;
  }

}

class Cart {
  String? id;
  int? quantity;
  String? productTitle;
  String? productSelectedSizeTitle;
  String? productSelectedSizeId;
  int? productRate;
  String? productImage;
  int? productPrice;
  String? productId;
  String? userId;
  List<Extras>? extras;
  List<Types>? types;


  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    productTitle = json['product_title'];
    productSelectedSizeTitle = json['product_selected_size_title'];
    productSelectedSizeId = json['product_selected_size_id'];
    productRate = json['product_rate'];
    productImage = json['product_image'];
    productPrice = json['product_price'];
    productId = json['product_id'];
    userId = json['user_id'];
    if (json['extras'] != null) {
      extras = <Extras>[];
      json['extras'].forEach((v) {
        extras!.add(Extras.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
  }

}

class InvoiceSummary {
  int? subTotalPrice;
  int? vatValue;
  int? appFees;
  int? totalPrice;


  InvoiceSummary.fromJson(Map<String, dynamic> json) {
    subTotalPrice = json['sub_total_price'];
    vatValue = json['vat_value'];
    appFees = json['app_fees'];
    totalPrice = json['total_price'];
  }

}

class Extras {
  String? selectedExtra;
  String? selectedExtraName;
  int? selectedExtraPrice;

  Extras.fromJson(Map<String, dynamic> json) {
    selectedExtra = json['selected_extra'];
    selectedExtraName = json['selected_extra_name'];
    selectedExtraPrice = json['selected_extra_price'];
  }
}

class Types {
  String? selectedType;
  String? selectedTypeName;
  int? selectedTypePrice;

  Types.fromJson(Map<String, dynamic> json) {
    selectedType = json['selected_type'];
    selectedTypeName = json['selected_type_name'];
    selectedTypePrice = json['selected_type_price'];
  }

}
