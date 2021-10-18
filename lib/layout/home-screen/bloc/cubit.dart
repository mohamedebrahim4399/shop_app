import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites.dart';
import 'package:shop_app/modules/products_screen/products_screen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_boint.dart';
import 'package:shop_app/shared/constant/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    Categories(),
    Favorites(),
    Settings(),
  ];

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeChangeIndexState());
  }

  Map<int, bool> favorite = {};
  HomeModel? homeModel;
  Future getHomeData() async {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.formJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.inFavorites!});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeSuccessCategoriesState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorCategoriesState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite(int id) async {
    favorite[id] = !favorite[id]!;
    emit(HomeChangeFavoriteState());
    await DioHelper.postDate(token: token, url: FAVORITES, data: {
      'product_id': id,
    }).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.formJson(value.data);
      if (!favoriteModel!.status!) {
        favorite[id] = !favorite[id]!;
      }else{
        getFavoriteData();
      }
      emit(HomeChangeFavoriteSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      print(error);
      favorite[id] = !favorite[id]!;
      emit(HomeChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;
  void getFavoriteData() {
    DioHelper.getData(
      token: token,
        url: FAVORITES).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(HomeSuccessGetFavoriteState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorGetFavoriteState());
    });
  }

  LoginModel? userModel;
  void getUserData() {
    DioHelper.getData(
        token: token,
        url: PROFILE).then((value) {
      userModel = LoginModel.formJson(value.data);
      print(value.data.toString());
      emit(HomeSuccessGetUserState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorGetUserState());
    });
  }

  void updateUserData({required name,required email,required phone,}) {
    emit(HomeLoadingUpdateUserState());
    DioHelper.putDate(
        token: token,
        url: UPDATE_PROFILE,
    data: {
      'name':name,
      'email':email,
      'phone':phone,
    },
    ).then((value) {
      userModel = LoginModel.formJson(value.data);
      print(value.data.toString());
      emit(HomeSuccessUpdateUserState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorUpdateUserState());
    });
  }
}
