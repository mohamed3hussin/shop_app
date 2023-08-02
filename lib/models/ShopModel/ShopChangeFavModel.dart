class ShopChangeFavModel
{
  bool? status;
  String? message;
  ShopChangeFavModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
  }
}