import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constant/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'bloc_observer.dart';
import 'layout/home-screen/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  var onBoarding =CacheHelper.getData(key: 'onBoarding');
   token =CacheHelper.getData(key: 'token')??'';
  runApp(MyApp(checkScreen(onBoarding: onBoarding, token: token)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget screen;
  MyApp(this.screen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: screen
    );
  }
}

Widget checkScreen({required onBoarding,required String token}){
  if(onBoarding !=null){
    if(token.isNotEmpty){
      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }else{
    return OnBoardingScreen();
  }
}

