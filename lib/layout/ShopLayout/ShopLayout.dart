import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/LoginScreen/LoginCubit/LoginStates.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/modules/ShopScreens/CartScreen.dart';
import 'package:shop_app/modules/ShopScreens/SearchScreen.dart';

import 'package:shop_app/shared/conponents/components.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';
import 'package:shop_app/shared/cubit/appCubit/AppCubit.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';

class ShopLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {},
      builder: (context,state){
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('salla'),
            actions:
            [

              IconButton(
                  onPressed:()
                  {
                    NavigationTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
              // IconButton(
              //     onPressed:(){
              //       AppCubit.get(context).ChangeThemMode();
              //
              //     },
              //     icon: Icon(Icons.brightness_4)),
            ],
          ),
          body: cubit.shopScreens[cubit.currentIndex],

          floatingActionButton:FloatingActionButton
            (
            onPressed:()
            {
              NavigationTo(context, CartScreen());
            },
            child: Icon(Icons.shopping_cart),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.ChangeNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ]
            ,),
        );
      },
    );
  }
}
