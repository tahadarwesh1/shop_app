import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/signup/signup_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSccusesState) {
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

                navigateAndFinish(context, ShopLayout(),);
              });
            } else {
              toast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to browse our all hot offers',
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
                          onChanged: (value) {
                            print(value);
                          },
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          isPassword: LoginCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            }
                            if (value.length < 5) {
                              return 'Password is too short';
                            }
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffixIcon: LoginCubit.get(context).suffixIcon,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLodingState,
                          builder: (context) => defaultButton(
                            title: 'login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SignUpScreen(),
                                );
                              },
                              child: Text(
                                'REGISTER',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
