import 'package:shop_app/models/ShopModel/ShopUserModel.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates
{
 final ShopUserModel userModel;

  RegisterSuccessState(this.userModel);
}
class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}
class RegisterShowPasswordState extends RegisterStates{}