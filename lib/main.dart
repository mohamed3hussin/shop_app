import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/shared/conponents/constans.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/appCubit/AppCubit.dart';
import 'package:shop_app/shared/cubit/appCubit/AppStates.dart';
import 'package:shop_app/shared/cubit/observed/observe.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';
import 'package:shop_app/shared/network/remote/DioHelper/Dio_Helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'ShopApp/OnBoarding/OnBoardingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await CacheHelper.init();
  Widget widget;
  var isDark = CacheHelper.getData(key: 'isDark');

  var isOnBoarding = CacheHelper.getData(key: 'onBoarding');
  var isToken = CacheHelper.getData(key: 'token');
  print(isToken);
  if(isOnBoarding != null)
  {
    if(isToken != null)
    {
      widget = ShopLayout();
    }
    else{widget = LoginScreen();}
  }
  else{widget = OnBoardingScreen();}
  print(isOnBoarding);

  runApp(MyApp(
    isDark: isDark,
    startScreen: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startScreen;
  MyApp({this.startScreen,this.isDark});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: ( context)=>AppCubit()),
        BlocProvider(create: (context)=>ShopCubit()..GetHomeData()..GetCategoriesData()..GetFavoritesData()..GetUserData()..GetCartData()..GetAddress())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: lightMode,
            darkTheme: darkMode,
            themeMode: ThemeMode.light,
            home: startScreen
          );
        },
      ),
    );
  }
}


