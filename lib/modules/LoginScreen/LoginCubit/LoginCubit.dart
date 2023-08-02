import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopUserModel.dart';
import 'package:shop_app/modules/LoginScreen/LoginCubit/LoginStates.dart';
import 'package:shop_app/shared/network/remote/DioHelper/Dio_Helper.dart';

import '../../../shared/network/end_point.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  ShopUserModel? model;
  void UserLogin({
    required String email,
    required String password,
})
  {
    //email : body1admin@gmail.com
    //pas : 123456
    emit(LoginLoadingState());
    Dio_Helper.postData(
        url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        }).then((value) {
         model= ShopUserModel.fromJson(value.data);
         // print(model!.status);
          //print(model!.message);
          //print(model!.data!.token);
          emit(LoginSuccessState(model!));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  bool isPasswordShow = true;
  void PasswordShowed()
  {
    isPasswordShow=!isPasswordShow;
    emit(LoginShowPasswordState());
  }
}