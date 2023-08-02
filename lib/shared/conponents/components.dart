import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../cubit/ShopCubit/ShopCubit.dart';
import '../cubit/appCubit/AppCubit.dart';


Widget defaultButton({
  double   width = double.infinity,
  double   height = 40.0,
  double   radius = 0.0,
  Color    background = Colors.blue ,
  bool     isUpperCase = true,
  required Function() function ,
  required String text,
}
)=>Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(radius,),
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text( isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String labelText,
  required IconData preIcon,
   IconData? sufIcon,
  Function? onSubmitted,
  Function? onChang,
  Function? onTap,
  Function? suffixOnPressed,
  required Function validate,
  bool isPassword = false,
  bool isClickable = true,
  bool isRead = false,
  required context,


})=>TextFormField(

  controller: controller,
  keyboardType: inputType ,
  obscureText: isPassword,
  enabled: isClickable,
  readOnly: isRead,
  onFieldSubmitted: (s){
    onSubmitted!(s);
  },
  onChanged: (s){
    onChang!(s);
  },
  validator:(s){
    return validate(s);
  },
  onTap: ()
  {
    onTap!();
  },
  decoration: InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(),

    prefixIcon: Icon(
      preIcon,
    ),
    suffixIcon: IconButton(
      onPressed:(){
        suffixOnPressed!();
      } ,
      icon: Icon(
        sufIcon,
      ),
    ),
  ),
);

Widget buildTaskItem(Map model,context,{Color doneColor = Colors.black45,Color archiveColor = Colors.black45})=>Dismissible(
  key: Key(model['id'].toString()),
  child: Container(

    padding: EdgeInsets.all(20),

    child: Row(

      children:

      [

        CircleAvatar(
          backgroundColor: Colors.black54,
          radius: 40.0,
          child: Text(
              model['time'],
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),

        SizedBox(width: 20.0,),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children:

            [

              Text(

                model['title'],

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                model['date'],

                style: TextStyle(

                    color: Colors.grey

                ),

              ),

            ],

          ),

        ),

        SizedBox(width: 20.0,),

        IconButton(
            onPressed:()
            {
            },

            icon: Icon(Icons.done_all),

            color:doneColor ,

        ),

        IconButton(

          onPressed:()

          {
          },

          icon: Icon(Icons.archive_outlined),

            color:archiveColor,

        ),



      ],

    ),

  ),
  onDismissed: (direction)
  {
  },
);

Widget buildNewsItem(Map model,context)=>InkWell(
  onTap: (){

  },
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children:

      [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15,),

            image: DecorationImage(

              image: NetworkImage('${model['urlToImage']!=null?model['urlToImage']:'https://i.pinimg.com/originals/7c/1c/a4/7c1ca448be31c489fb66214ea3ae6deb.jpg'}'),

              fit: BoxFit.cover,

            ),

          ),),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.start,

              children:

              [

                Expanded(

                  child: Text(

                    '${model['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    overflow: TextOverflow.ellipsis,

                    maxLines: 3,

                  ),

                ),

                Text(

                  '${model['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                    fontWeight: FontWeight.w600,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
    end: 5.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

void NavigationTo(context,widget)=>Navigator.push(context,
  MaterialPageRoute(
    builder:(context)=>widget ,
  ),);

Widget ArticleBuilder(List list,context,{isBool = true})=>ConditionalBuilder(
  condition: list.length > 0 ,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:(context,index)=> buildFavItem(list[index],context,isSearch: false),
      separatorBuilder:(context,index)=> myDivider(),
      itemCount: list.length > 10? list.length-4:list.length-1
  ),
  fallback:(context)=> isBool? Container(): Center(child: LinearProgressIndicator()),
);

void NavigationAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(context,
  MaterialPageRoute(
    builder:(context)=>widget ,
  ),
        (Route<dynamic>route)=>false,
    );
void PrintFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {print(match.group(0)); });
}
Widget buildFavItem( model,context,
{
  bool isSearch = true,
})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
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
