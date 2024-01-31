import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/routes.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/auth/ui/cubit/register_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/model/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupWidgets extends StatefulWidget {
  const SignupWidgets({Key? key}) : super(key: key);

  @override
  State<SignupWidgets> createState() => _SignupWidgetsState();
}

class _SignupWidgetsState extends State<SignupWidgets> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<RegisterCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonErrorState) {
          print(state.message);
          Fluttertoast.showToast(msg: state.message);
        } else if (state is CommonSuccessState) {
          Fluttertoast.showToast(msg: "Registered Successfully");
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.homePage, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: CustomTheme.primaryColor),
        body: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    fieldName: "name",
                    label: "Full name",
                    hintText: "Enter Full Name",
                    controller: _fullNameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Full Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    fieldName: "phone",
                    label: "Phone Number",
                    hintText: "Enter Phone Number",
                    controller: _phoneNumberController,
                    textInputType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Phone Number cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    fieldName: "address",
                    label: "Address",
                    hintText: "Enter Address",
                    controller: _addressController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Address cannot be empty";
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    fieldName: "email",
                    label: "Email Address",
                    hintText: "Enter Email Address",
                    controller: _emailController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Email field cannot be empty";
                      }
                      final _isvalid = EmailValidator.validate(val);
                      if (_isvalid) {
                        return null;
                      } else {
                        return "Enter valid email address";
                      }
                    },
                  ),
                  CustomTextField(
                    fieldName: "password",
                    label: "Password",
                    hintText: "Enter Password",
                    controller: _passwordController,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    fieldName: "cpassword",
                    label: "Confirm Password",
                    hintText: "Enter Confirm Password",
                    controller: _confirmPasswordController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Confirm Password field cannot be empty";
                      } else if (val.length < 4) {
                        return "Password field must be at least 4 character long";
                      } else if (val != _passwordController.text) {
                        return "Password doesnot matched";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                  ),
                  CustomRoundedButtom(
                    title: "SIGNUP",
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final inputData = User(
                            fullName: _formKey.currentState!.value["name"],
                            password: _formKey.currentState!.value["password"],
                            phoneNumber: _formKey.currentState!.value["phone"],
                            address: _formKey.currentState!.value["address"],
                            email: _formKey.currentState!.value["email"]);
                        final dataValid = context
                            .read<RegisterCubit>()
                            .registerUser(user: inputData);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Already have account?",
                      style: _textTheme.bodyText2,
                      children: [
                        TextSpan(
                          text: " Sign In",
                          style: _textTheme.bodyText2!.copyWith(
                            color: CustomTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                            },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
