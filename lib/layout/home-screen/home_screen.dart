import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/cubit.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getHomeData()..getFavoriteData()..getCategoriesData()..getUserData(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                }, icon: Icon(Icons.search),),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),
              ],
            ),
          );
        },
      ),
    );
  }
}
