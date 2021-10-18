import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/register/bloc/Register_states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_boint.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword=true;

  IconData suffix=Icons.visibility_off_outlined;

  void userRegister({required email, required pass,required name,required phone}) async {
    emit(RegisterLoadingState());
    await DioHelper.postDate(url: REGISTER, data: {
      'name':name,
      'email': email,
      'password': pass,
      'phone':phone,
    }).then((value) {
      print(value);
      emit(RegisterSuccessState(LoginModel.formJson(value.data)));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  void changePasswordVisibility(){
    isPassword =!isPassword;
    suffix =isPassword ? Icons.visibility_off_outlined: Icons.visibility;
    emit(RegisterChangePasswordVisibilityState());

  }
}
