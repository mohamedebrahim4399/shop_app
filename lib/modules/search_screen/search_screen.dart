import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/cubit/bloc.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {},
                      label: 'search',
                      onSubmit: (text){
                        cubit.searchData(text);
                      },
                      onChange: (value){
                        cubit.searchData(value);
                      },
                      prefix: Icon(Icons.search)),
                 SizedBox(height: 20,),
                 state is SearchLoadingState? LinearProgressIndicator():SizedBox(),
                 cubit.searchModel !=null? Expanded(
                   child: ListView.separated(
                        itemBuilder: (context, index) => buildSearchProducts(
                            cubit.searchModel!.data!.data[index], cubit),
                        separatorBuilder: (context, index) => Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.shade400,
                            ),
                        itemCount: cubit.searchModel!.data!.data.length),
                 ):SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchProducts(Product model, cubit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 150,
              height: 150,
            ),
            Expanded(
              child: Padding(
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
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          model.price.toString(),
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              cubit.changeFavorite(model.id);
                            },
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
