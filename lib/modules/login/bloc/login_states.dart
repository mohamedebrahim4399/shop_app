import 'package:shop_app/models/loginModel.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel data;
  LoginSuccessState(this.data);
}
class LoginErrorState extends LoginStates{}
class LoginChangePasswordVisibilityState extends LoginStates{}