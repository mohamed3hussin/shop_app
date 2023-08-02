import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopFavModel.dart';

import '../../shared/conponents/components.dart';
import '../../shared/cubit/ShopCubit/ShopCubit.dart';
import '../../shared/cubit/ShopCubit/StatesCubit.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavState ,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildFavItem(cubit.favoritesModel!.data!.favData![index].product!,context),
              separatorBuilder:(context,index)=> myDivider(),
              itemCount: cubit.favoritesModel!.data!.favData!.length),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}