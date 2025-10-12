import 'dart:io';
import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/logic/services/supabase_services.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final _picker = ImagePicker();
  final user = Supabase.instance.client.auth.currentUser;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<String?> _uploadImage(File file) async {
    try {
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final response = await Supabase.instance.client.storage
          .from('profiles_images') // اسم الـ bucket في Supabase
          .upload(fileName, file);

      final publicUrl = Supabase.instance.client.storage
          .from('profiles_images')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      debugPrint('Upload error: $e');
      return null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfilesData() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _uploadImage(_selectedImage!);
    }
    try {
      await Supabase.instance.client.from('profiles').insert({
        'id': user!.id,
        'email': emailController.text.trim(),
        'full_name': fullNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'avatar_url': imageUrl ?? '',
        'role': userRole,
      });

      if (user == null) {
        print('User is null. Did you sign up and verify email?');
      } else {
        print('User IDdddddddddddddddddddddddddddddddddd: ${user!.id}');
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حفظ البيانات بنجاح ✅')));
      print(
        '888888888888888888888888888888888888888888888888888888888888888888888',
      );
      //Navigator.pop(context);
    } catch (e) {
      debugPrint('Insert errorrrrrrrrrrrrrrrrrrrrrrr: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ? const Icon(Icons.camera_alt, size: 40)
                            : null,
                      ),
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
                  Container(
                    height: 200,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              focusNode: fullNameFocus,
                              validator: addChildNameValidator,
                              controller: fullNameController,
                              hintText: 'Enter Your full name',
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              focusNode: emailFocus,
                              validator: emailValidator,
                              controller: emailController,
                              hintText: 'Enter Your Email',
                              icon: Icons.email,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              focusNode: passFocus,
                              validator: passwordValidator,
                              controller: passController,
                              hintText: 'Enter Your Password',
                              icon: Icons.lock,
                              isPassword: true,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              focusNode: confirmPassFocus,
                              validator: (value) => confirmPasswordValidator(
                                value,
                                passController,
                              ),
                              controller: confirmPassController,
                              hintText: 'Confirm Password',
                              icon: Icons.lock,
                              isPassword: true,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              focusNode: phoneFocus,
                              validator: phoneValidator,
                              controller: phoneController,
                              hintText: 'Enter Your phone',
                              icon: Icons.phone,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        SupabaseServices().signUp(
                          context,
                          emailController.text.trim(),
                          passController.text.trim(),
                        );
                        _saveProfilesData();
                      } else {}
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
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                          emailController.clear();
                          passController.clear();
                          confirmPassController.clear();
                        },

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
    ;
  }
}
