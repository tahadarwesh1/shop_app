import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/cateogries_model/cateogries_model.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(LayoutBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(LayoutLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      print(favorites);

      emit(LayoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutErrorState());
    });
  }

  CateogriesModel? cateogriesModel;

  void getCategoriesData() {
    emit(LayoutLoadingState());
    DioHelper.getData(
      url: GET_CATEOGRIES,
      token: token,
    ).then((value) {
      cateogriesModel = CateogriesModel.fromJson(value.data);

      emit(CateogriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CateogriesErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ChangeFavoritesLoadingState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(GetFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  LoginModel? userData;

  void getUserData() {
    emit(UserDataLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data.name.toString());

      emit(UserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserDataErrorState());
    });
  }

  void updateUserData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UserUpdateDataLoadingState());

    DioHelper.putData(
      url: UPDATE,
      data: {
        'email': email,
        'name': name,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userData = LoginModel.fromJson(value.data);
      print(userData!.data.name.toString());

      emit(UserUpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserUpdateDataErrorState());
    });
  }
}
