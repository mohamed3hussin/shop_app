import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterCubit/RegisterCubit.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterCubit/RegisterStates.dart';
import 'package:shop_app/modules/ShopScreens/AddressScreen.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';

import '../../shared/conponents/components.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state)
        {
          if(state is RegisterSuccessState)
            {
              if(state.userModel.status==true)
                {
                  print(state.userModel.data!.token);
                  print(state.userModel.message);
                  CacheHelper.saveData(key: 'token', value: state.userModel.data!.token).
                  then((value)
                  {

                    Fluttertoast.showToast(
                        msg: "${state.userModel.message}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 12.0
                    );
                    NavigationAndFinish(context, AddressScreen());
                  });
                }
              else
                {
                  print(state.userModel.message);
                  Fluttertoast.showToast(
                      msg: "${state.userModel.message}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red[700],
                      textColor: Colors.white,
                      fontSize: 12.0
                  );
                }
            }
        },
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:
                      [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: nameController,
                          labelText: 'name',
                          preIcon: Icons.person,
                          inputType: TextInputType.name,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {

                              return 'Name Most Not Empty';
                            }
                            else{
                              return null;}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: phoneController,
                          labelText: 'phone',
                          preIcon: Icons.phone_android_outlined,
                          inputType: TextInputType.phone,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {

                              return 'Phone Most Not Empty';
                            }
                            else{
                              return null;}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: emailController,
                          labelText: 'email',
                          preIcon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {

                              return 'Email Most Not Empty';
                            }
                            else{
                              return null;}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context: context,
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          labelText: 'password',
                          preIcon: Icons.lock,
                          sufIcon: cubit.isPasswordShow? Icons.visibility:Icons.visibility_off,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {

                              return 'Password Most Not Empty';
                            }
                            else{
                              return null;}
                          },
                          suffixOnPressed: ()
                          {
                            cubit.PasswordShowed();
                          },
                          onSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              cubit.UserRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          isPassword: cubit.isPasswordShow,

                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:(context)=>defaultButton(
                            text: 'Register',
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.UserRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            radius: 10.0,
                            isUpperCase: false,
                            height: 50,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
