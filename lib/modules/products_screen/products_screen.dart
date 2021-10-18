import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/cubit.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/component.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeChangeFavoriteSuccessState){
          if(!state.model.status!){
            showToast(message: state.model.message!, state: ToastState.Error);
          }
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return cubit.homeModel != null && cubit.categoriesModel != null
            ? productsBuilder(cubit.homeModel!, cubit.categoriesModel!,cubit)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel,cubit) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image!}'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCategoriesItem(
                            categoriesModel.data!.date[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data!.date.length),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.56,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(model.data!.products.length,
                    (index) => buildGridProducts(model.data!.products[index],cubit))),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
          width: 100,
          height: 100,
        ),
        Container(
          child: Text(
            model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black.withOpacity(.6),
          width: 100,
        )
      ],
    );
  }

  Widget buildGridProducts(Products model,cubit) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              model.discount != 0
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    )
                  : SizedBox()
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                          color: Colors.blueAccent, fontSize: 12, height: 1.5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    model.discount != 0
                        ? Text(
                            '${model.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                height: 1.5,
                                decoration: TextDecoration.lineThrough),
                          )
                        : SizedBox(),
                    Spacer(),
                    IconButton(
                        onPressed: () {cubit.changeFavorite(model.id!);},
                        icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:!cubit.favorite[model.id]? Colors.grey:Colors.blue,
                            child: Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.white,
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
