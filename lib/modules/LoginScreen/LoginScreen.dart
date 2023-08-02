import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/ShopLayout/ShopLayout.dart';
import 'package:shop_app/modules/LoginScreen/LoginCubit/LoginCubit.dart';
import 'package:shop_app/modules/LoginScreen/LoginCubit/LoginStates.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';

import '../../shared/conponents/components.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
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
                    NavigationAndFinish(context, ShopLayout());
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
          var cubit = LoginCubit.get(context);
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
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

                              return 'Email most not empty';
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

                              return 'Password most not empty';
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
                              cubit.UserLogin(
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
                          condition: state is! LoginLoadingState,
                          builder:(context)=>defaultButton(
                            text: 'login',
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                cubit.UserLogin(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text('Don\'t have account?'),
                            TextButton(
                              onPressed: ()
                              {
                                NavigationTo(context, RegisterScreen());
                              },
                              child: Text(
                                'Register Now',
                              ),
                            ),
                          ],
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
