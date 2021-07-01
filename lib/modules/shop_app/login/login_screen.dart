import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:news_app/modules/shop_app/login/cubit/states.dart';
import 'package:news_app/modules/shop_app/register/register_screen.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/componants/constants.dart';


class LoginScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    // Form Key
    var formKey = GlobalKey<FormState>();
    // Controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state)
        {

          return Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'log in'.toUpperCase(),
              ),
              centerTitle: true,
              backgroundColor: backgroundColor,
              brightness: Brightness.light,
              backwardsCompatibility: false,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: backgroundColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 25,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            'Let’s sign you in',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            'Welcome back, you’ve been missed!',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: socialButton(
                                  assetName: 'assets/images/Icons-icon-google.png',
                                  onPressed: () {},
                                  text: 'Google',
                                  isUpperCase: false,
                                  border: Color(0xFFDE4D3B),
                                  textColor: Color(0xFFDE4D3B),
                                  fontSize: 14,
                                  width: 140,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: socialButton(
                                  assetName: 'assets/images/Icons-icon-facebook.png',
                                  onPressed: () {},
                                  text: 'Facebook',
                                  isUpperCase: false,
                                  fontSize: 14,
                                  border: Color(0xFF4267B2),
                                  textColor: Color(0xFF4267B2),
                                  width: 140,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1.5,
                                width: 50,
                                color: Colors.grey[400],
                              ),
                              SizedBox(width: 5),
                              Text(
                                'OR',
                                style: TextStyle(
                                    color: Colors.grey[400]
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 1.5,
                                width: 50,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                          defaultFormField(
                            controller: emailController,
                            validation: (String value) {
                              if(value.isEmpty){
                                return 'please enter your email address';
                              }
                            },
                            labelText: 'Email Address',
                            type: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                              controller: passwordController,
                              validation: (String value) {
                                if(value.isEmpty){
                                  return 'Password is too short';
                                }
                              },
                              labelText: 'Password',
                              type: TextInputType.emailAddress,
                              secure: true,
                              suffix: Icons.visibility,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! LoginLoadingState,
                            widgetBuilder:(context) => defaultButton(
                              onPressed: () {
                                if(formKey.currentState.validate()){
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'sign in',
                              isUpperCase: true,
                              background: primaryColor,
                              textColor: Colors.white,
                              height: 50,
                            ),
                            fallbackBuilder: (BuildContext context) => Center(
                              child:  CircularProgressIndicator(),
                              ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account?',
                              ),
                              defaultTextButton(
                                text: 'Sign Up',
                                fontWeight: FontWeight.bold,
                                textColor: primaryColor,
                                onPressed: () {
                                  navigateTo(context, RegisterScreen(),);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
