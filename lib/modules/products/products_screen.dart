import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/cateogries_model/cateogries_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).homeModel != null &&
              LayoutCubit.get(context).cateogriesModel != null,
          builder: (context) => productsBuilder(
              LayoutCubit.get(context).homeModel!,
              LayoutCubit.get(context).cateogriesModel!,
              context),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CateogriesModel cateogriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(
                          e.image,
                        ),
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(
                  seconds: 7,
                ),
                autoPlayAnimationDuration: Duration(
                  milliseconds: 1800,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(cateogriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5.0,
                      ),
                      itemCount: cateogriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.66,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      buildGrideProduct(model.data.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel dataModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              dataModel.image,
            ),
            height: 130.0,
            width: 130.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 130.0,
            color: Colors.black.withOpacity(.8),
            child: Text(
              dataModel.name.toTitleCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget buildGrideProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red[400],
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}\n',
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          LayoutCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              (LayoutCubit.get(context).favorites[model.id])!
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 18,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
