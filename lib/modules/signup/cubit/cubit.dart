import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/signup/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userData({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(RegisterLodingState());
    DioHelper.postData(
      url: REGISTER,
      lang: 'en',
      data: {
        'email': email,
        'name': name,
        'phone': phone,
        'password': password,
      },
    ).then((value) {

      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessesState(loginModel!));
    })
    .catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterPasswordVisibilityState());
  }

  void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
}
}
