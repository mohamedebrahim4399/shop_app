import 'package:shop_app/models/change_favorite_model.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class HomeChangeIndexState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{}
class HomeSuccessCategoriesState extends HomeStates{}
class HomeErrorCategoriesState extends HomeStates{}
class HomeChangeFavoriteState extends HomeStates{}
class HomeChangeFavoriteSuccessState extends HomeStates{
  final ChangeFavoriteModel model;
  HomeChangeFavoriteSuccessState(this.model);
}
class HomeChangeFavoriteErrorState extends HomeStates{}
class HomeSuccessGetFavoriteState extends HomeStates{}
class HomeErrorGetFavoriteState extends HomeStates{}
class HomeSuccessGetUserState extends HomeStates{}
class HomeErrorGetUserState extends HomeStates{}
class HomeLoadingUpdateUserState extends HomeStates{}
class HomeSuccessUpdateUserState extends HomeStates{}
class HomeErrorUpdateUserState extends HomeStates{}