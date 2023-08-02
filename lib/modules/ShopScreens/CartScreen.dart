import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/conponents/components.dart';
import '../../shared/cubit/ShopCubit/ShopCubit.dart';
import '../../shared/cubit/ShopCubit/StatesCubit.dart';

class CartScreen extends StatelessWidget {

  var addressController = TextEditingController();
  var textKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        addressController.text = ShopCubit.get(context).getAddressModel!.data!.data![0].name!
            +'/'+ShopCubit.get(context).getAddressModel!.data!.data![0].city!
            +'/'+ShopCubit.get(context).getAddressModel!.data!.data![0].region!
            +'/'+ShopCubit.get(context).getAddressModel!.data!.data![0].details!;
        ShopCubit.get(context).EmptyTextField();
        print(ShopCubit.get(context).getAddressModel!.data!.data![0].name!);
        var cubit = ShopCubit.get(context);
        return Scaffold(
          key: textKey,
          appBar: AppBar(
            title: Text('Cart'),
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: addressController,
                    inputType: TextInputType.text,
                    labelText: 'Address',
                    preIcon: Icons.location_city,
                    isRead: true,

                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'Address must not be empty';
                      }
                      return null;
                    },
                    context: context),
              ),
              ConditionalBuilder(
                condition: state is! ShopLoadingCartState ,
                builder: (context)=>Container(
                  height: 570,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildCartItem(cubit.cartModel!.data!.cartItems![index].product,context),
                      separatorBuilder:(context,index)=> myDivider(),
                      itemCount: cubit.cartModel!.data!.cartItems!.length),
                ),
                fallback:(context)=> Center(child: CircularProgressIndicator()),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: defaultButton(
                  radius: 20,
                    height: 50,
                    function: ()
                    {},
                    text: 'Add Order'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCartItem( model,context,
      {
        bool isSearch = true,
      })=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 130,
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120,

                ),
                if(model.discount !=0 && isSearch)
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
          ),
          SizedBox(width: 10,),
          Expanded(
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
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Text(
                    model.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      height: 1.2,
                      color: Colors.grey
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(model.discount != 0 && isSearch)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()
                        {
                          ShopCubit.get(context).ChangeFavorites(model.id!);
                          // print(shopChangeFavModel!.status);
                          // print(shopChangeFavModel!.message);
                          //print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: ShopCubit.get(context).favorites[model.id!]! ? Colors.red: Colors.grey[200],
                          child: Icon(
                            Icons.favorite,
                            color:Colors.white,
                          ),
                        )),
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
    ),
  );
}
