import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/auth/sign_in_screen.dart';
import 'package:autism/presentation/screens/auth/sign_up_screen.dart';
import 'package:autism/presentation/screens/home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  //////////////////////////////////////////////////////////////
  /////////             Future of signup              //////////
  //////////////////////////////////////////////////////////////
  void signUp(BuildContext context) async {
    final response = await Supabase.instance.client.auth.signUp(
      email: emailController.text,
      password: passController.text,
      emailRedirectTo: 'autism://login-callback',
    );

    if (!context.mounted) return;

    if (response.user != null) {
      AwesomeDialog? dialog;

      dialog = AwesomeDialog(
        context: context,
        dismissOnTouchOutside: false,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: "Check your email",
        desc:
            "We sent you a confirmation link. Please verify your account before logging in.",
        btnOkOnPress: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
      )..show();
      dialog;

      print('Sign up successful');
    } else {
      print('Handle error');
    }
  }

  void signIn(BuildContext context) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passController.text,
      );

      if (response.user != null) {
        print('Login successful');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // إذا ما لقى الحساب
        _showSignUpDialog(context);
      }
    } catch (e) {
      if (e.toString().contains("Invalid login credentials")) {
        _showSignUpDialog(context);
      } else {
        AwesomeDialog? dialog;

        dialog = AwesomeDialog(
          context: context,
          dismissOnTouchOutside: false,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          btnOkOnPress: () {},
          desc: "Please verify your account before logging in",
        )..show();
        dialog;
        print('Error: $e');
      }
    }
  }

  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Account not found"),
          // contentTextStyle: TextStyle(

          // ),
          content: Text(
            "You don\'t have an account yet. Do you want to sign up?",
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                Navigator.pop(ctx); // إغلاق الديالوج
              },
              child: Text("Cancel", style: TextStyle(color: Colors.white)),
            ),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                Navigator.pop(ctx); // إغلاق الديالوج
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
                emailController.clear();
                passController.clear();
              },
              child: Text("Sign Up", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // void _showSignUpDialog(BuildContext context) async {
  //   await AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.warning,
  //     animType: AnimType.bottomSlide,
  //     title: 'Account not found',
  //     desc: 'You don\'t have an account yet. Do you want to sign up?',
  //     btnCancelOnPress: () {},
  //     btnOkText: "Sign Up",
  //     btnOkOnPress: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SignUpScreen()),
  //       );
  //     },
  //   ).show();
  // }
}
