class ShopCategoriesModel
{
  bool? status;
  CategoriesData? data;
  ShopCategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}
class CategoriesData
{
  int? currentPage;
  List<DataCategoriesModel>?data=[];
  CategoriesData.fromJson(Map<String,dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      data!.add(DataCategoriesModel.fromjason(element));
    });
  }
}
class DataCategoriesModel
{
  int ? id;
  String? name;
  String?image;
  DataCategoriesModel.fromjason(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}