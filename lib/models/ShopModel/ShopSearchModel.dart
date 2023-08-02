class SearchModel {
  bool? status;
  Null message;
  Data? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}
class Data {
  List<Product> searchData =[];

  Data.fromJson(Map<String, dynamic> json) {
      json['data'].forEach((v) {
        if(v != null){
        searchData.add(new Product.fromJson(v));}
      });

  }
}
class Product {
  int? id;
  dynamic price;
  int? discount;
  String? image;
  String? name;
  String? description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}