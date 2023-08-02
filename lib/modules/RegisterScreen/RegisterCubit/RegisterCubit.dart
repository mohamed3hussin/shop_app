import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopUserModel.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterCubit/RegisterStates.dart';
import 'package:shop_app/shared/network/remote/DioHelper/Dio_Helper.dart';

import '../../../shared/network/end_point.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  ShopUserModel? model;
  void UserRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
})
  {
    emit(RegisterLoadingState());
    Dio_Helper.postData(
        url: REGISTER,
        data:
        {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
        }).then((value) {
         model= ShopUserModel.fromJson(value.data);
         // print(model!.status);
          //print(model!.message);
          //print(model!.data!.token);
          emit(RegisterSuccessState(model!));
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
  bool isPasswordShow = true;
  void PasswordShowed()
  {
    isPasswordShow=!isPasswordShow;
    emit(RegisterShowPasswordState());
  }
}