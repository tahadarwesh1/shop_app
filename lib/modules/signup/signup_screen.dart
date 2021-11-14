import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/signup/cubit/cubit.dart';
import 'package:shop_app/modules/signup/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (BuildContext context, state) {
            if (state is RegisterSuccessesState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                toast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCCESS,
                );
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value) {
                  token = state.loginModel.data.token;

                  navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
                });
              } else {
                toast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (BuildContext context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register now to browse our all hot offers',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.mail_outline,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email Address';
                            }
                            if (value.contains('@') != true) {
                              return 'Please Enter valid Email Address';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          label: 'Name',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: RegisterCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (value.length < 5) {
                              return 'Password is too short';
                            }
                          },

                          // onFieldSubmitted: (value) {
                          //   if (formKey.currentState!.validate()) {
                          //     RegisterCubit.get(context).userData(
                          //       email: emailController.text,
                          //         password: passwordController.text,
                          //         name: nameController.text,
                          //         phone: phoneController.text,
                          //     );
                          //   }
                          // },
                          suffixIcon: RegisterCubit.get(context).suffixIcon,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLodingState,
                          builder: (context) => defaultButton(
                            title: 'Rigester',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
