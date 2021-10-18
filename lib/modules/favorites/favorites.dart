import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/cubit.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';
import 'package:shop_app/models/favorite_model.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => buildFavoriteProducts(cubit.favoriteModel!.data!.data[index],cubit),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                ),
            itemCount: cubit.favoriteModel!.data!.data.length);
      },
    );
  }

  Widget buildFavoriteProducts(FavoriteData model,cubit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                      model.product!.image!),
                  width: 150,
                  height: 150,
                ),
                model.product!.discount != 0
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        model.product!.discount != 0
                            ? Text(
                                model.product!.oldPrice.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    height: 1.5,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : SizedBox(),
                        Spacer(),
                        IconButton(
                            onPressed: () {cubit.changeFavorite(model.product!.id);},
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
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
            ),
          ],
        ),
      ),
    );
  }
}
