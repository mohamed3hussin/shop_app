import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/LoginScreen/LoginScreen.dart';
import 'package:shop_app/shared/conponents/components.dart';
import 'package:shop_app/shared/network/local/shared/CacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/cubit/appCubit/AppCubit.dart';
class OnBoardingModel
{
  final String image;
  final String title;
  final String body;

  OnBoardingModel(this.image, this.title, this.body);
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> model =
  [
    OnBoardingModel('assets/images/shop1.webp', 'On Boarding Title1', 'On Boarding Body1'),
    OnBoardingModel('assets/images/shop2.webp', 'On Boarding Title2', 'On Boarding Body2'),
    OnBoardingModel('assets/images/shop3.png', 'On Boarding Title3', 'On Boarding Body3'),
  ];

  var boardController = PageController();
  bool isLast = false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value){
      NavigationAndFinish(context, LoginScreen());}
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(onPressed:submit,
            child: Text('Skip'),),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                  controller: boardController ,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (index)
                  {
                    if(index==model.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                    else
                      {
                        setState(() {
                          isLast=false;
                        });
                      }
                  },
                  itemBuilder:(context,index)=>onBoardingItem(model[index],context),
                  itemCount: model.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 2,
                      spacing: 5.0,
                    ),
                    count: model.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }
                    else
                      {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                  },

                  child: Icon(Icons.arrow_forward_ios_rounded),)
              ],
            ),

          ],
        ),
      ) ,
    );
  }

  Widget onBoardingItem(OnBoardingModel model,context)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      Text('${model.title}',
        style: Theme.of(context).textTheme.bodyText1,),
      SizedBox(height: 20,),
      Text('${model.body}',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      SizedBox(height: 30,)
    ],
  );
}
