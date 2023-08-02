class AddressModel
{
  bool? status;
  String? message;
  AddressData? data;

  AddressModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data=json['data'] !=null?AddressData.fromJson(json['data']):null;
  }
}
class AddressData
{
  String? name;
  String? city;
  String? region;
  String? details;
  int? id;
  //"latitude": 30.0616863,
  // 	"longitude": 31.3260088,
  double?latitude;
  double?longitude;
  AddressData.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    city=json['city'];
    region=json['region'];
    details=json['details'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}