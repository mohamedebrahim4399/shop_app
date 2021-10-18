import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/home_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/bloc/Register_cubit.dart';
import 'package:shop_app/modules/register/bloc/Register_states.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/constant/constants.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.data.status!) {
              print(state.data.message);
              print(state.data.data!.token);
              token =state.data.data!.token!;CacheHelper.saveData(
                  key: 'token', value: state.data.data!.token)
                  .then((value) {
                token =state.data.data!.token!;
                    Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);});
            } else {
              showToast(
                  message: state.data.message!, state: ToastState.Error);
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to browse our office',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please inter your name address';
                              }
                            },
                            label: 'User Name',
                            prefix: Icon(Icons.person)),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please inter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icon(Icons.email_outlined)),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: Icon(cubit.suffix)),
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please inter the password';
                              }
                            },
                            isSecure: cubit.isPassword,
                            label: 'Password',
                            prefix: Icon(Icons.lock_outlined),),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please inter your phone address';
                              }
                            },
                            label: 'Phone',
                            prefix: Icon(Icons.phone)),
                        SizedBox(
                          height: 30,
                        ),
                        state is! RegisterLoadingState
                            ? defaultButton(
                            text: 'Register',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    pass: passwordController.text);
                              }
                            })
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Have an account?'),
                            defaultTextButton(
                                text: 'Login',
                                function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()));
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
