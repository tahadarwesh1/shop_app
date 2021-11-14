import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/cateogries_model/cateogries_model.dart';
import 'package:shop_app/shared/constants.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = LayoutCubit.get(context);
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 1 / 1.5,
          children: List.generate(
            cubit.cateogriesModel!.data.data.length,
            (index) =>
                buildGrideCategory(cubit.cateogriesModel!.data.data[index]),
          ),
        );
      },
    );
  }

  Widget buildGrideCategory(DataModel dataModel) => Column(
        children: [
          Image(
            image: NetworkImage(
              dataModel.image,
            ),
            height: 180.0,
            width: 180.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            dataModel.name.toTitleCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ],
      );
}
