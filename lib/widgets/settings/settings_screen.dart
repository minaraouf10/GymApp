import 'package:align_ai/widgets/components.dart';
import 'package:align_ai/widgets/cubit/cubit.dart';
import 'package:align_ai/widgets/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  var addressController = TextEditingController();
  var genderController = TextEditingController();
  var gymNameController = TextEditingController();

  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserData();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        if (model != null) {
          userNameController.text = model.userName;
          emailController.text = model.email;
          phoneController.text = model.phone;
          firstNameController.text = model.firstName;
          lastNameController.text = model.lastName;
          heightController.text = model.height;
          weightController.text = model.weight;
          addressController.text = model.address;
          genderController.text = model.gender;
          gymNameController.text = model.gymName;
        }

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    SizedBox(height: 50),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Profile Data',
                        style: TextStyle(
                          color: Color(0xFFFE7C7C),
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: firstNameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'First Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: lastNameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Last Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: userNameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'User Name',
                      prefix: Icons.verified_user,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: heightController,
                      type: TextInputType.number,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Height must not be empty';
                        }
                        return null;
                      },
                      label: 'Height',
                      prefix: Icons.height,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: weightController,
                      type: TextInputType.number,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Weight must not be empty';
                        }
                        return null;
                      },
                      label: 'Weight',
                      prefix: Icons.monitor_weight,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: genderController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Gender must not be empty';
                        }
                        return null;
                      },
                      label: 'Gender',
                      prefix: Icons.male,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: addressController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Address must not be empty';
                        }
                        return null;
                      },
                      label: 'Address',
                      prefix: Icons.house,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: gymNameController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Gym Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Gym Name',
                      prefix: Icons.sports_gymnastics,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
