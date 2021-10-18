import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home-screen/bloc/cubit.dart';
import 'package:shop_app/layout/home-screen/bloc/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component/component.dart';

class Settings extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                state is HomeLoadingUpdateUserState ?LinearProgressIndicator():SizedBox(),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: nameController,
                  label: 'Name',
                  prefix: Icon(Icons.person),
                  type: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'name must be empty';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: emailController,
                  label: 'Email',
                  prefix: Icon(Icons.email),
                  type: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'email must be empty';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: phoneController,
                  label: 'Phone',
                  prefix: Icon(Icons.phone),
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'phone must be empty';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(

                  function: () {
                    HomeCubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);
                  },
                  text: 'UpDate',
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(

                  function: () {
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      }
                    });
                  },
                  text: 'logout',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
