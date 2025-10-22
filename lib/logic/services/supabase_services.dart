import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/auth/sign_up_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  //////////////////////////////////////////////////////////////
  /////////             Future of signup              //////////
  //////////////////////////////////////////////////////////////
  final supabase = Supabase.instance.client;
  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
  ) async {
    final response = await Supabase.instance.client.auth.signUp(
      email: emailController.text,
      password: passController.text,
      // emailRedirectTo: 'autism://login-callback',
    );

    if (!context.mounted) return;
    if (response.user != null) {
      onSignUpSuccess(context);

      print('Sign up successful');
    } else {
      print('Handle error');
    }
  }

  //////////////////////////////////////////////////////////////
  /////////             Future of signin              //////////
  //////////////////////////////////////////////////////////////
  Future<void> signIn(BuildContext context) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passController.text,
      );

      if (response.user != null) {
        print('Login successful');
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

  //////////////////////////////////////////////////////////////
  /////////           _showSignUpDialog               //////////
  //////////////////////////////////////////////////////////////
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

  //////////////////////////////////////////////////////////////
  /////////          Future of deleteChild            //////////
  //////////////////////////////////////////////////////////////
  Future<void> deleteChild(String childId, BuildContext context) async {
    try {
      final response = await Supabase.instance.client
          .from('children')
          .delete()
          .eq('id', childId); // شرط الحذف حسب id الطفل

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Child deleted successfully')),
        );

        // ✅ إعادة تحميل البيانات بعد الحذف
        await context.read<ChildrenCubit>().fetchChildrenForCurrentUser();
      }
    } catch (e) {
      debugPrint('Delete error: $e');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting child: $e')));
    }
  }
}
