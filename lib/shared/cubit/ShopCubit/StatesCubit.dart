import 'package:shop_app/models/ShopModel/ShopChangeFavModel.dart';
import 'package:shop_app/models/ShopModel/ShopUserModel.dart';

import '../../../models/ShopModel/ShopChangeCartModel.dart';

abstract class ShopStates{}
//ShopChangeButtonSheetState
//ShopEmptyTextField
class ShopInitialState extends ShopStates{}
class ShopChangeNavBarState extends ShopStates{}
class ShopChangeButtonSheetState extends ShopStates{}
class ShopEmptyTextField extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}
class ShopErrorHomeState extends ShopStates
{
  String error;
  ShopErrorHomeState(this.error);
}
class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates
{
  String error;
  ShopErrorCategoriesState(this.error);
}
class ShopSuccessChangeFavState extends ShopStates
{
  final ShopChangeFavModel shopChangeFavModel;

  ShopSuccessChangeFavState(this.shopChangeFavModel);
}
class ShopChangeFavColorState extends ShopStates{}
class ShopErrorChangeFavState extends ShopStates
{
  String error;
  ShopErrorChangeFavState(this.error);
}
class ShopSuccessFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates
{
  String error;
  ShopErrorFavoritesState(this.error);
}
class ShopLoadingFavState extends ShopStates{}

class ShopSuccessProfileState extends ShopStates
{
  final ShopUserModel shopUserModel;

  ShopSuccessProfileState(this.shopUserModel);
}
class ShopErrorProfileState extends ShopStates
{
  String error;
  ShopErrorProfileState(this.error);
}
class ShopLoadingProfileState extends ShopStates{}

class ShopSuccessUpdateState extends ShopStates
{
  final ShopUserModel shopUserModel;

  ShopSuccessUpdateState(this.shopUserModel);
}
class ShopErrorUpdateState extends ShopStates
{
  final String error;

  ShopErrorUpdateState(this.error);

}
class ShopLoadingUpdateState extends ShopStates{}

class ShopSuccessAddressState extends ShopStates
{}
class ShopErrorAddressState extends ShopStates
{
  final String error;

  ShopErrorAddressState(this.error);

}
class ShopLoadingAddressState extends ShopStates{}

class ShopSuccessChangeCartState extends ShopStates
{
  final ShopChangeCartModel shopChangeCartModel;

  ShopSuccessChangeCartState(this.shopChangeCartModel);
}
class ShopChangeCartColorState extends ShopStates{}
class ShopErrorChangeCartState extends ShopStates
{
  final String error;

  ShopErrorChangeCartState(this.error);

}
class ShopSuccessCartState extends ShopStates{}
class ShopErrorCartState extends ShopStates
{
 final String error;

  ShopErrorCartState(this.error);

}
class ShopLoadingCartState extends ShopStates{}
class CartChangeButtonSheetState extends ShopStates{}
class CreateDatabaseStates extends ShopStates{}
class ImagePickerSuccessState extends ShopStates{}
class ImagePickerErrorState extends ShopStates
{
  final String error;

  ImagePickerErrorState(this.error);
}
class productInsertDatabase extends ShopStates{}
class ProductsGetDatabaseLoading extends ShopStates{}
class ProductGetDatabase extends ShopStates{}
class ShopSuccessGetAddressState extends ShopStates{}
class ShopErrorGetAddressState extends ShopStates
{
  final String error;

  ShopErrorGetAddressState(this.error);



}
class ShopLoadingGetAddressState extends ShopStates{}




