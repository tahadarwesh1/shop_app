class FavoritesModel {
  late bool status;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  List<FavoritesData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoritesData.fromJson(element));
    });
  }
}

class FavoritesData {
  late int id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        (json['product'] != null ? Product.fromJson(json['product']) : null)!;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
