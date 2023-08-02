import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/conponents/components.dart';
import 'package:shop_app/shared/cubit/ShopCubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopCubit/StatesCubit.dart';

import '../../layout/ShopLayout/ShopLayout.dart';

class AddressScreen extends StatelessWidget {
  var textKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit= ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsetsDirectional.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      Text(
                          'YOUR ADDRESS',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        context: context,
                        labelText: 'name',
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Name not be null';
                          }
                        },
                        inputType: TextInputType.text,
                        preIcon: Icons.work,
                        controller: cubit.nameController,
                      ),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        context: context,
                        labelText: 'city',
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'city not be null';
                          }
                        },
                        inputType: TextInputType.text,
                        preIcon: Icons.location_city,
                        controller: cubit.cityController,
                      ),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        context: context,
                        labelText: 'region',
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'region not be null';
                          }
                        },
                        inputType: TextInputType.text,
                        preIcon: Icons.location_searching_sharp,
                        controller: cubit.regionController,
                      ),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        context: context,
                        labelText: 'details',
                        validate: (String ? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'details not be null';
                          }
                        },
                        inputType: TextInputType.text,
                        preIcon: Icons.details,
                        controller: cubit.detailsController,
                      ),
                      SizedBox(height: 20.0,),
                      defaultButton(
                          height: 50,
                          radius: 15,
                          function: ()
                          {

                            if(formKey.currentState!.validate())
                            {
                              cubit.UserAddress(
                                name: cubit.nameController.text,
                                city: cubit.cityController.text,
                                region: cubit.regionController.text,
                                details: cubit.detailsController.text,
                              );
                              cubit.EmptyTextField();
                              NavigationAndFinish(context, ShopLayout());
                            }
                          },
                          text: 'Add Address')

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
