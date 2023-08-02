import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/ShopModel/ShopCategoriesModel.dart';
import 'package:shop_app/models/ShopModel/ShopChangeFavModel.dart';
import 'package:shop_app/models/ShopModel/ShopProductModel.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';
import 'package:shop_app/shared/cubit/appCubit/AppCubit.dart';

import '../../shared/network/local/shared/CacheHelper.dart';

class HomeScreen extends StatelessWidget {
  ShopChangeFavModel? shopChangeFavModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state)
     {
       if(state is ShopSuccessChangeFavState)
       {
         if(state.shopChangeFavModel.status==true)
         {
           print(state.shopChangeFavModel.status);
           print(state.shopChangeFavModel.message);

         }
         else
         {
           print(state.shopChangeFavModel.message);
           Fluttertoast.showToast(
               msg: "${state.shopChangeFavModel.message}",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.black.withOpacity(0.4),
               textColor: Colors.white,
               fontSize: 12.0
           );
         }
       }
     },
     builder: (context,state)
     {
       var cubit = ShopCubit.get(context);

       return ConditionalBuilder(
           condition: cubit.shopProductModel !=null && cubit.shopCategoriesModel != null,
           builder:(context)=> ProductItem(cubit.shopProductModel!,cubit.shopCategoriesModel!,context),
           fallback:(context)=> Center(child: CircularProgressIndicator()));
     },
    );
  }
  Widget ProductItem(ShopProductModel model,ShopCategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
            items: model.data!.banners.map((e) =>
                Image(image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )).toList() ,
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,

            )),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 100,
                child: ListView.separated(
                    physics:BouncingScrollPhysics() ,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=> CategoriesList(categoriesModel.data!.data![index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount: categoriesModel.data!.data!.length
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.75,
            children: List.generate(
                model.data!.products.length,
                    (index) => ItemBuilder(model.data!.products[index],context)),
          ),
        ),
      ],
    ),
  );
  Widget ItemBuilder(ProductsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200,

            ),
            if(model.discount !=0)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text('DISCOUNT',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.2,
                  ),
                ),
                height: 35,
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    '${model.price!.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color:AppCubit.get(context).isDark==true?Colors.deepOrange :Colors.blue,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model.discount !=0)
                  Text(
                    '${model.oldPrice!.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),


                ],
              ),
              SizedBox(height: 5,),
              Row(
                children:
                [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).ChangeFavorites(model.id!);

                        // print(shopChangeFavModel!.status);
                        // print(shopChangeFavModel!.message);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.red: Colors.grey[200],
                        child: Icon(
                          Icons.favorite,
                          color:Colors.white,
                        ),
                      )),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).ChangeCart(model.id!);

                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: ShopCubit.get(context).cart[model.id]! ? Colors.blue: Colors.grey[200],
                        child: Icon(
                          Icons.add_shopping_cart_outlined,
                          color:Colors.white,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),

  );
  Widget CategoriesList(DataCategoriesModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15,),
          image: DecorationImage(
            image: NetworkImage(model.image!),
            fit: BoxFit.cover,
          ),

        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.black.withOpacity(0.6),
        ),
        width: 100,
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontSize: 12),
        ),
      ),
    ],
  );
}
