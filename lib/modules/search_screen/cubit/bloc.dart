import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_boint.dart';
import 'package:shop_app/shared/constant/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  
  SearchCubit():super(SearchInitialState());
  
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;
  void searchData(data){
    emit(SearchLoadingState());
    DioHelper.postDate(
      token: token,
        url: SEARCH, data: {
      'text':data,
    }).then((value) {
      print(value.data);
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error);
      emit(SearchErrorState());
    });
  }
}