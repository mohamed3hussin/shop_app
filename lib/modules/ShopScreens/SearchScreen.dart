import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/ShopModel/ShopSearchModel.dart';
import 'package:shop_app/shared/conponents/components.dart';
import 'package:shop_app/shared/cubit/SearchCubit/SearchCubit.dart';
import 'package:shop_app/shared/cubit/SearchCubit/SearchStates.dart';

import '../../shared/cubit/ShopCubit/ShopCubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
          listener:(context,state){},
          builder: (context,stat)
          {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      defaultFormField(
                          controller: searchController,
                          inputType: TextInputType.text,
                          labelText: 'search',
                          preIcon: Icons.search,
                          validate:(String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Search Most Not Empty';
                            }
                            return null;
                          },
                          onSubmitted: (String text)
                          {
                            if(formKey.currentState!.validate())
                            {
                              SearchCubit.get(context).Search(text);
                            }
                          },
                          context: context),
                      SizedBox(height: 10,),
                      if(stat is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      if(stat is SearchSuccessState)
                      Expanded(
                        child: ArticleBuilder(SearchCubit.get(context).searchModel!.data!.searchData,context,isBool: false)
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      ),
    );
  }

}