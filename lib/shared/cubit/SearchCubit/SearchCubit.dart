import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopSearchModel.dart';
import 'package:shop_app/shared/cubit/SearchCubit/SearchStates.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/DioHelper/Dio_Helper.dart';

import '../../network/local/shared/CacheHelper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
  
  static SearchCubit get(context)=>BlocProvider.of(context);
  
  SearchModel? searchModel;
  void Search(String text)
  {
    emit(SearchLoadingState());
    Dio_Helper.postData(
        url: PRODUCTS_SEARCH,
        data:
        {
          'text':text,
        },
        token: CacheHelper.getData(key: 'token'),
    ).then((value)
    {
      searchModel =SearchModel.fromJson(value.data);
      print(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}