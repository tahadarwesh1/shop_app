import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/signup/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = LayoutCubit.get(context).userData;

        emailController.text = model!.data.email;
        nameController.text = model.data.name.toTitleCase();
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: LayoutCubit.get(context).getUserData != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UserUpdateDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    label: 'Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    label: 'Email',
                    prefixIcon: Icons.mail_outline,
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    label: 'Phone',
                    prefixIcon: Icons.phone,
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    title: 'Update',
                    onPressed: () {
                      LayoutCubit.get(context).updateUserData(
                        email: emailController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    title: 'LOGOUT',
                    onPressed: () {
                      RegisterCubit.get(context).signOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
