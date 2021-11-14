import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearch({required String text}) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
}
