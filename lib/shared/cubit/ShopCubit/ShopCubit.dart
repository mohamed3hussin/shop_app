import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/ShopCartModel.dart';
import 'package:shop_app/models/ShopModel/GetAddressModel.dart';
import 'package:shop_app/models/ShopModel/ShopAddressModel.dart';
import 'package:shop_app/models/ShopModel/ShopCategoriesModel.dart';
import 'package:shop_app/models/ShopModel/ShopChangeFavModel.dart';
import 'package:shop_app/models/ShopModel/ShopFavModel.dart';
import 'package:shop_app/models/ShopModel/ShopProductModel.dart';
import 'package:shop_app/models/ShopModel/ShopUserModel.dart';
import 'package:shop_app/modules/ShopScreens/CategoriesScreen.dart';
import 'package:shop_app/modules/ShopScreens/FavoritesScreen.dart';
import 'package:shop_app/modules/ShopScreens/SettingesScreen.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';
import 'package:shop_app/shared/cubit/appCubit/AppCubit.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';
import 'package:shop_app/shared/network/remote/DioHelper/Dio_Helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/ShopModel/ShopChangeCartModel.dart';
import '../../../modules/ShopScreens/HomeScreen.dart';
import '../../conponents/components.dart';
import '../../conponents/constans.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> shopScreens=
  [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void ChangeNavBar(index)
  {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }


  ShopProductModel? shopProductModel;
  Map<int,bool>favorites = {};
  Map<int,bool> cart = {};
  void GetHomeData()
  {
    emit(ShopLoadingHomeState());
    Dio_Helper.getData(
        url: HOME,
        token: CacheHelper.getData(key: 'token')
    ).then((value)
    {
      shopProductModel = ShopProductModel.fromJson(value.data);
      print(shopProductModel!.data!.banners[0].image);
      print(shopProductModel!.data);
      shopProductModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id! : element.inFavorites!
        });
        cart.addAll(
            {
              element.id! : element.inCart!
            });
      });

      print(favorites.toString());
      print(cart.toString());
     // print(shopProductModel.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error)
    {
      print(error);
      emit(ShopErrorHomeState(error));
    });
  }
  ShopCategoriesModel? shopCategoriesModel;
  void GetCategoriesData()
  {
    //emit(ShopLoadingCategoriesState());
    Dio_Helper.getData(
        url: GET_CATEGORIES,
        token: isToken
    ).
    then((value)
    {
      shopCategoriesModel = ShopCategoriesModel.fromJson(value.data);
      //print(shopCategoriesModel!.data!.dataModel![0].name);
      // print(shopProductModel.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState(error));
    });
  }

  ShopChangeFavModel? shopChangeFavModel;
  void ChangeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavColorState());
    Dio_Helper.postData(
        url: FAVORITES,
        data:
        {
          'product_id':productId
        },
        token: CacheHelper.getData(key: 'token')
    ).then((value)
    {
      shopChangeFavModel = ShopChangeFavModel.fromJson(value.data);
      print(value.data);
      if(!shopChangeFavModel!.status!)
      {
        favorites[productId] = !favorites[productId]!;

      }
      else{GetFavoritesData();}
      emit(ShopSuccessChangeFavState(shopChangeFavModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavState(error.toString()));
    });
  }
  ShopChangeCartModel? shopChangeCartModel;
  void ChangeCart(int productId)
  {
    cart[productId] = !cart[productId]!;
    emit(ShopChangeCartColorState());
    Dio_Helper.postData(
        url: CART,
        data:
        {
          'product_id':productId
        },
        token: CacheHelper.getData(key: 'token')
    ).then((value)
    {
      shopChangeCartModel = ShopChangeCartModel.fromJson(value.data);
      print(value.data);
      if(!shopChangeCartModel!.status!)
      {
        cart[productId] = !cart[productId]!;

      }
      else{GetCartData();}
      emit(ShopSuccessChangeCartState(shopChangeCartModel!));
    }).catchError((error)
    {
      cart[productId] = !cart[productId]!;
      emit(ShopErrorChangeCartState(error.toString()));
    });
  }
  FavoritesModel? favoritesModel;
  void GetFavoritesData()
  {
    emit(ShopLoadingFavState());
    Dio_Helper.getData(
        url: FAVORITES,
        token: CacheHelper.getData(key: 'token')
    ).
    then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorFavoritesState(error));
    });
  }
  CartModel? cartModel;
  void GetCartData()
  {
    emit(ShopLoadingCartState());
    Dio_Helper.getData(
        url: CART,
        token: CacheHelper.getData(key: 'token')
    ).
    then((value)
    {
      cartModel = CartModel.fromJson(value.data);

      print(value.toString());
      emit(ShopSuccessCartState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCartState(error));
    });
  }
  ShopUserModel? shopUserModel;
  void GetUserData()
  {
    emit(ShopLoadingProfileState());
    Dio_Helper.getData(
        url: PROFILE,
        token: CacheHelper.getData(key: 'token')
    ).
    then((value)
    {
      shopUserModel = ShopUserModel.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessProfileState(shopUserModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProfileState(error));
    });
  }

  void UpdateUserData(
  {
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateState());
    Dio_Helper.updateData(
      url: UPDATE_PROFILE,
      token: CacheHelper.getData(key: 'token'),
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      }
    ).
    then((value)
    {
      shopUserModel = ShopUserModel.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessUpdateState(shopUserModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateState(error));
    });
  }

  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();




  void EmptyTextField()
  {
    nameController.text = '';
    cityController.text  = '';
    regionController.text  = '';
    detailsController.text  = '';
    emit(ShopEmptyTextField());
  }

  AddressModel? addressModel;
  void UserAddress(
      {
        required String name,
        required String city,
        required String region,
        required String details,
      })
  {
    emit(ShopLoadingAddressState());
    Dio_Helper.postData(
        url: ADDRESS,
        token: CacheHelper.getData(key: 'token'),
        data:
        {
          'name':name,
          'city':city,
          'region':region,
          'details':details,
          'latitude': 30.0616863,
          'longitude': 31.3260088,
        }
    ).
    then((value)
    {
      addressModel = AddressModel.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessAddressState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorAddressState(error));
    });
  }
  GetAddressModel? getAddressModel;
  void GetAddress()
  {
    emit(ShopLoadingGetAddressState());
    Dio_Helper.getData(
        url: ADDRESS,
        token: CacheHelper.getData(key: 'token')
    ).then((value)
    {
      getAddressModel = GetAddressModel.fromJson(value.data);
      print('-------------------------------------------');
      print(value.toString());
      emit(ShopSuccessGetAddressState());
    }).catchError((error)
    {
      emit(ShopErrorGetAddressState(error));
    });
  }

  File? imagePick;





}