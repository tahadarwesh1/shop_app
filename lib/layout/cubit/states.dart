import 'package:shop_app/models/login_model/login_model.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

class LayoutBottomNavState extends LayoutStates {}

class LayoutLoadingState extends LayoutStates {}

class LayoutSuccessState extends LayoutStates {}

class LayoutErrorState extends LayoutStates {}

class CateogriesSuccessState extends LayoutStates {}

class CateogriesErrorState extends LayoutStates {}

class ChangeFavoritesSuccessState extends LayoutStates {}

class ChangeFavoritesErrorState extends LayoutStates {}

class GetFavoritesSuccessState extends LayoutStates {}

class GetFavoritesErrorState extends LayoutStates {}

class GetFavoritesLoadingState extends LayoutStates {}

class ChangeFavoritesLoadingState extends LayoutStates {}

class UserDataSuccessState extends LayoutStates {}

class UserDataErrorState extends LayoutStates {}

class UserDataLoadingState extends LayoutStates {}

class UserUpdateDataSuccessState extends LayoutStates {

//   LoginModel loginModel;
//   UserUpdateDataSuccessState(this.loginModel);
}

class UserUpdateDataErrorState extends LayoutStates {}

class UserUpdateDataLoadingState extends LayoutStates {}
