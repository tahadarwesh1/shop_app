class SearchModel {
  late bool status;
  late Null message;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int currentPage;
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  late int id;
  late int price;
  late String image;
  late String name;
  late String description;
  List<String> images = [];
  late dynamic discount;

  late bool inFavorites;
  late bool inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    discount = json['discount'];

    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
