
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int index=0;

  void changePage(int pageIndex){
    index=pageIndex;
    emit(ChangePage());
  }

  bool isLast=false;
}