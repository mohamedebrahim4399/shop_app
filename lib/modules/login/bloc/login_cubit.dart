import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/login/bloc/login_states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_boint.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword=true;

  IconData suffix=Icons.visibility_off_outlined;

  void userLogin({required email, required pass}) async {
    emit(LoginLoadingState());
    await DioHelper.postDate(url: LOGIN, data: {
      'email': email,
      'password': pass,
    }).then((value) {
      print(value);
      emit(LoginSuccessState(LoginModel.formJson(value.data)));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  void changePasswordVisibility(){
    isPassword =!isPassword;
    suffix =isPassword ? Icons.visibility_off_outlined: Icons.visibility;
    emit(LoginChangePasswordVisibilityState());

  }
}
