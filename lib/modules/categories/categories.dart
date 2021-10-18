import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/cubit.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';

class Categories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit cubit =HomeCubit.get(context);
        return ListView.separated(itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image(image: NetworkImage(cubit.categoriesModel!.data!.date[index].image!),
                width: 100,
                height: 100,),
                SizedBox(width: 10,),
                Text(cubit.categoriesModel!.data!.date[index].name!,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined))

              ],
            ),
          );
        }, separatorBuilder: (context, index) =>Container(
          color: Colors.grey.shade400,
          height: 1,
          width: double.infinity,
        ), itemCount: cubit.categoriesModel!.data!.date.length);
      },
    );
  }
}
