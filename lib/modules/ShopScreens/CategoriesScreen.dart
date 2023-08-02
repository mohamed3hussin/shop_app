import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopCategoriesModel.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';

import '../../shared/conponents/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>ItemCat(cubit.shopCategoriesModel!.data!.data![index]),
            separatorBuilder:(context,index)=> myDivider(),
            itemCount: cubit.shopCategoriesModel!.data!.data!.length);
      },
    );
  }

}
Widget ItemCat(DataCategoriesModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children:
    [
      Image(
        image: NetworkImage(model.image!),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text(
        model.name!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
    ],
  ),
);