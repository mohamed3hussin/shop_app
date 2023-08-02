import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/conponents/components.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';

import '../../shared/network/local/shared/CacheHelper.dart';
import '../LoginScreen/LoginScreen.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {},
      builder: (context,state)
      {
        var model = ShopCubit.get(context).shopUserModel;
        nameController.text=model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return  Center(
          child: SingleChildScrollView(
            child: ConditionalBuilder(
              condition: ShopCubit.get(context).shopUserModel != null,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children:
                    [
                      Text(
                        'Profile Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(height: 40,),
                      if(state is ShopLoadingUpdateState)
                        LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      defaultFormField(
                          controller: nameController,
                          inputType: TextInputType.name,
                          labelText: 'name',
                          preIcon: Icons.person,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          context: context),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          labelText: 'email',
                          preIcon: Icons.email_outlined,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          context: context),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller: phoneController,
                          inputType: TextInputType.number,
                          labelText: 'phone',
                          preIcon: Icons.phone_android_outlined,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          context: context),
                      SizedBox(height: 20,),
                      defaultButton(
                        function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).UpdateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                          }
                        },
                        text: 'UpDate',
                        isUpperCase: false,
                        radius: 10,
                        height:45 ,
                        //background: Colors.blue,
                      ),
                      SizedBox(height: 20,),
                      defaultButton(

                          function: ()
                          {
                            CacheHelper.removeData(key: 'token').then((value)
                            {
                              if(value)
                              {
                                ShopCubit.get(context).currentIndex=0;
                                NavigationAndFinish(context, LoginScreen());
                              }
                            });
                          },
                          text: 'Logout',
                          isUpperCase: false,
                          radius: 10,
                          height:45 ,
                          //background: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );

  }
}