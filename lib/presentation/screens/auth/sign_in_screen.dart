import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_SocialButton.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:autism/logic/services/supabase_services.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.035,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      'assets/images/autism-high-resolution-logo.png',
                      height: 175,
                      width: 175,
                    ),
                  ),
                  Text(
                    'Sign In Your Account',
                    style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: 27,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    validator: emailValidator,
                    controller: emailController,
                    hintText: 'Enter Your Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    validator: passwordValidator,
                    controller: passController,
                    hintText: 'Enter Your Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFFFF7F3E)),
                      SizedBox(width: 5),
                      Text('Remmember me', style: TextStyle(fontSize: 13)),
                      Spacer(),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFFF7F3E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      SupabaseServices().signIn(context);
                      print('0000000000000000000000000000000000000000');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF7F3E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        imagePath: 'assets/images/google.png',
                        onTap: () {
                          print("Google tapped");
                        },
                      ),

                      SocialButton(
                        imagePath: 'assets/images/facebook.png',
                        onTap: () {
                          print("Facebook tapped");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey[350],
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),

                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                          emailController.clear();
                          passController.clear();
                        },
                        child: Text(
                          " Sign Up",
                          style: TextStyle(color: Color(0xFFFF7F3E)),
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
  }
}
