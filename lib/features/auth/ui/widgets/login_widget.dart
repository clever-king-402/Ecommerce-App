import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/routes.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/auth/ui/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/ui/screens/signup_page.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:page_transition/page_transition.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocListener<LoginCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoadingState) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is CommonSuccessState) {
          Fluttertoast.showToast(msg: "Login SuccessFull");
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.homePage, (route) => false);
        } else if (state is CommonErrorState) {
          Fluttertoast.showToast(msg: "Login Failed");
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: CustomTheme.primaryColor),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
                  CustomRoundedButtom(
                    title: "LOGIN",
                    onPressed: () async{
                      if (_formKey.currentState!.saveAndValidate()) {
                       final _ =await context.read<LoginCubit>().login(
                            email: _formKey.currentState!.value["email"],
                            password: _formKey.currentState!.value["password"]);

                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Don't have account?",
                      style: _textTheme.bodyText2,
                      children: [
                        TextSpan(
                          text: " Sign Up",
                          style: _textTheme.bodyText2!.copyWith(
                            color: CustomTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: SignupPages(),
                                  type: PageTransitionType.fade,
                                ),
                              );
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
