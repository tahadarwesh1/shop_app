import 'package:shop_app/models/login_model/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLodingState extends LoginStates {}

class LoginSccusesState extends LoginStates {
  final LoginModel loginModel;
  LoginSccusesState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginPasswordVisibilityState extends LoginStates {}
