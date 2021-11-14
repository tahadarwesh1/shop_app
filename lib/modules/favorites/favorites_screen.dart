import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: LayoutCubit.get(context).favoritesModel!.data.data.isEmpty
              ? (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "There is no products in your favorite",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  )
              : (BuildContext context) => ListView.separated(
                    itemBuilder: (context, index) => buildProductItem(
                      LayoutCubit.get(context).favoritesModel!.data.data[index].product,
                      context,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.0,
                    ),
                    itemCount: LayoutCubit.get(context)
                        .favoritesModel!
                        .data
                        .data
                        .length,
                  ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

