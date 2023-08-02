class ShopChangeCartModel
{
  bool? status;
  String? message;
  ShopChangeCartModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
  }
}