import 'package:shop_app/models/ShopModel/ShopUserModel.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates
{
 final ShopUserModel userModel;

  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}
class LoginShowPasswordState extends LoginStates{}