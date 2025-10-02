import 'package:autism/core/utilies/sizes/sized_config.dart';
import 'package:autism/features/auth/sign_in/views/widgets/sign_in_customTextFields.dart';
import 'package:autism/features/auth/sign_in/views/widgets/sign_in_screen_body.dart';
import 'package:flutter/material.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({super.key});

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
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Text(
                    'Create An Account',
                    style: TextStyle(
                      letterSpacing: -0.5,
                      fontSize: 27,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomTextFormField(
                    hintText: 'Enter Your Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    hintText: 'Enter Your Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFFFF7F3E)),
                      SizedBox(width: 5),
                      Text('I agree to the ', style: TextStyle(fontSize: 12)),
                      Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF7F3E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' and ', style: TextStyle(fontSize: 12)),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF7F3E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF7F3E),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Or sign up with',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.1,
                              ), // لون الظل (مع شفافية)
                              blurRadius: 10, // مدى انتشار الظل
                              spreadRadius: 2, // قوة امتداد الظل
                              offset: Offset(
                                0,
                                5,
                              ), // اتجاه الظل (يمين/يسار, أعلى/أسفل)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/google.png'),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.1,
                              ), // لون الظل (مع شفافية)
                              blurRadius: 10, // مدى انتشار الظل
                              spreadRadius: 2, // قوة امتداد الظل
                              offset: Offset(
                                0,
                                5,
                              ), // اتجاه الظل (يمين/يسار, أعلى/أسفل)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/facebook.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
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
                        "Already have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreenBody(),
                          ),
                        ),
                        child: Text(
                          " Sign In",
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
