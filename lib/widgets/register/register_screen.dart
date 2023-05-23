import 'dart:developer';
import 'package:align_ai/home_screen.dart';
import 'package:align_ai/main.dart';
import 'package:align_ai/widgets/components.dart';
import 'package:align_ai/widgets/constants.dart';
import 'package:align_ai/widgets/network/local/cache_helper.dart';
import 'package:align_ai/widgets/register/cubit/cubit.dart';
import 'package:align_ai/widgets/register/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var firstNameController =TextEditingController();
  var lastNameController =TextEditingController();
  var heightNameController =TextEditingController();
  var weightNameController =TextEditingController();
  var genderNameController =TextEditingController();
  var addressController =TextEditingController();
  var gymController =TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          // if (state is ShopRegisterSuccessState) {
          //   if (state.loginModel.status) {
          //     log(state.loginModel.message);
          //     log(state.loginModel.data.token);
          //
          //     CacheHelper.saveData(
          //         key: 'token',
          //         value: state.loginModel.data.token).then((value) => {
          //
          //       token = state.loginModel.data.token,
          //
          //       navigateAndFinish(context,HomeScreen(cameras))
          //     });
          //     showToast(
          //         text: state.loginModel.message, state: ToastState.SUCCESS);
          //
          //   } else {
          //     showToast(
          //         text: state.loginModel.message, state: ToastState.ERROR);
          //   }
          // }
        },
        builder: (context, state) => Scaffold(
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
                        'REGISER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: firstNameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your first name';
                          }
                        },
                        label: 'First Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: lastNameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your last name';
                          }
                        },
                        label: 'Last Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: userNameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your user name';
                          }
                        },
                        label: 'User Name',
                        prefix: Icons.verified_user,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: heightNameController,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your height';
                          }
                        },
                        label: 'Height',
                        prefix: Icons.height,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: weightNameController,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your weight';
                          }
                        },
                        label: 'Weight',
                        prefix: Icons.monitor_weight_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: genderNameController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your gender';
                          }
                        },
                        label: 'Gender',
                        prefix: Icons.male,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: addressController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your  address';
                          }
                        },
                        label: 'Address',
                        prefix: Icons.add_business_rounded,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: gymController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your gym';
                          }
                        },
                        label: 'GYM',
                        prefix: Icons.sports_gymnastics,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSbmitted: (value) {},
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your phone number';
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                name: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
