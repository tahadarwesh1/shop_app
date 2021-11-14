import 'package:shop_app/models/login_model/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLodingState extends RegisterStates {}

class RegisterSuccessesState extends RegisterStates {
  final LoginModel loginModel;
  RegisterSuccessesState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterStates {}
