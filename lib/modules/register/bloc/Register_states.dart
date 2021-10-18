import 'package:shop_app/models/loginModel.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel data;
  RegisterSuccessState(this.data);
}
class RegisterErrorState extends RegisterStates{}
class RegisterChangePasswordVisibilityState extends RegisterStates{}