import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/home_screen.dart';
import 'package:shop_app/modules/login/bloc/login_cubit.dart';
import 'package:shop_app/modules/login/bloc/login_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/constant/constants.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.data.status!) {
                print(state.data.message);
                print(state.data.data!.token);
                CacheHelper.saveData(
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
            var cubit = LoginCubit.get(context);
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
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'Login now to browse our office',
                            style: Theme.of(context).textTheme.headline6,
                          ),
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
                              prefix: Icon(Icons.lock_outlined),
                              onSubmit: (vlaue) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      pass: passwordController.text);
                                }
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          state is! LoginLoadingState
                              ? defaultButton(
                                  text: 'Login',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
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
                              Text('don\'t have an account?'),
                              defaultTextButton(
                                  text: 'REGISTER',
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
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
        ));
  }
}
