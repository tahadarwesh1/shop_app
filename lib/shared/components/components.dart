import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultTextField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  required String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool isPassword = false,
  IconData? suffixIcon,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      style: TextStyle(
        color: defaultColor,
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
          label: Text(
            label,
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     20.0,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     20.0,
          //   ),
          // ),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffixIcon,
            ),
          )),
    );

Widget defaultButton({
  required String title,
  required void Function()? onPressed,
}) =>
    MaterialButton(
      minWidth: double.infinity,
      height: 50.0,
      color: defaultColor,
      onPressed: onPressed,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
void toast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildProductItem(
  model,
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice && model.discount != null)
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
            SizedBox(
              width: 15.0,
            ),
            Expanded(
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
                      if (model.discount != 0 &&
                          isOldPrice &&
                          model.discount != null)
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
                             ( LayoutCubit.get(context)
                                      .favorites[model.id])!
                                  ? defaultColor
                                  : Colors.grey,
                              // defaultColor,
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
      ),
    );
