import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/cubit/cubiy.dart';
import 'package:shop_app/shared/cubit/states.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatelessWidget {

  var boardController=PageController();
  List<BoardingModel> boarding=[
    BoardingModel('assets/images/bording.jpg', 'On Board 1 Title', 'On Board 1 body'),
    BoardingModel('assets/images/bording.jpg', 'On Board 2 Title', 'On Board 2 body'),
    BoardingModel('assets/images/bording.jpg', 'On Board 3 Title', 'On Board 3 body'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state)=>Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(onPressed: (){
                  CacheHelper.saveData(key: 'onBoarding', value: true);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(rout)=>false);
                }, child: Text('SKIP'))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: boardController,
                      itemBuilder: (context,index)=>buildItem(boarding[index]),
                      onPageChanged: (index){
                        AppCubit.get(context).changePage(index);
                        if(index == boarding.length-1){
                          AppCubit.get(context).isLast=true;
                        }else{
                          AppCubit.get(context).isLast=false;
                        }
                      },
                      itemCount: boarding.length,
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AppCubit.get(context).index==index? Colors.blue:Colors.grey,
                            ),

                          ),
                          separatorBuilder: (context,index)=>SizedBox(width: 5,),
                          itemCount: boarding.length,
                        ),
                      ),
                      Spacer(),
                      FloatingActionButton(
                        onPressed: (){
                          if(AppCubit.get(context).isLast ==true){
                            CacheHelper.saveData(key: 'onBoarding', value: true);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(rout)=>false);
                          }else{
                            boardController.nextPage(
                              duration: Duration(milliseconds: 750,),
                              curve: Curves.fastLinearToSlowEaseIn,
                            );
                          }

                        },
                        child: Icon(Icons.arrow_forward_ios),)
                    ],
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
         ),
    );
  }

  Widget buildItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(height: 30,),
      Text('${model.title}',style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(height: 15,),
      Text('${model.body}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
    ],
  );
}


