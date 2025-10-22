import 'dart:io';

import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/presentation/screens/parents/add_child_screen.dart';
import 'package:autism/presentation/screens/doctors/complete_doctor_profile_screen.dart';
import 'package:autism/presentation/screens/home_screen.dart';
import 'package:autism/presentation/widgets/bottom_navigation_bar.dart';
import 'package:autism/presentation/widgets/on_boarding/on_boarding_models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//////////////////////////////////////////////////////////////
///////            List of onboarding steps            ///////
//////////////////////////////////////////////////////////////
List<OnBoardingScreenWidget> steps = [
  OnBoardingScreenWidget(
    title: "Welcome to Autism Care",
    body:
        "Connecting parents and doctors to provide better support for every child with autism.",
    image: "assets/lottie/Connection.json",
  ),
  OnBoardingScreenWidget(
    title: "Personalized Child Profiles",
    body:
        "Easily add your child’s information—diagnosis, hobbies, and needs—so doctors can tailor their care.",
    image: "assets/lottie/searching_for_profile.json",
  ),
  OnBoardingScreenWidget(
    title: "Seamless Support",
    body:
        "Book sessions, chat, and connect with specialists through secure video and voice calls.",
    image: "assets/lottie/Support.json",
  ),
];

//////////////////////////////////////////////////////////////
/////         TextEditingController variables          ///////
//////////////////////////////////////////////////////////////
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController fullNameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController addChildName = TextEditingController();
final TextEditingController addChildAge = TextEditingController();
final TextEditingController addChildhobbies = TextEditingController();
final TextEditingController addChilddiagnosis = TextEditingController();
final TextEditingController addChildbirthdate = TextEditingController();
final TextEditingController editeProfileName = TextEditingController();
final TextEditingController editProfileEmail = TextEditingController();
final TextEditingController editProfileTagName = TextEditingController();
final TextEditingController specialtyController = TextEditingController();
final TextEditingController qualificationController = TextEditingController();
final TextEditingController bioController = TextEditingController();
final TextEditingController clinicAddressController = TextEditingController();
final TextEditingController doctorsScreenSearch = TextEditingController();

//////////////////////////////////////////////////////////////
//////////////         FocusNode            //////////////////
//////////////////////////////////////////////////////////////
final FocusNode emailFocus = FocusNode();
final FocusNode passFocus = FocusNode();
final FocusNode confirmPassFocus = FocusNode();
final FocusNode fullNameFocus = FocusNode();
final FocusNode phoneFocus = FocusNode();
final FocusNode addChildNameFocus = FocusNode();
final FocusNode addChildAgeFocus = FocusNode();
final FocusNode addChildhobbiesFocus = FocusNode();
final FocusNode addChilddiagnosisFocus = FocusNode();
final FocusNode addChildbirthdateFocus = FocusNode();
final FocusNode editProfileNameFocus = FocusNode();
final FocusNode editProfileEmailFocus = FocusNode();
final FocusNode editProfileTagNameFocus = FocusNode();
final FocusNode specialtyControllerFocus = FocusNode();
final FocusNode qualificationControllerFocus = FocusNode();
final FocusNode bioControllerFocus = FocusNode();
final FocusNode clinicAddressControllerFocus = FocusNode();
final FocusNode doctorsScreenSearchFocus = FocusNode();

//////////////////////////////////////////////////////////////
//////////////         validator            //////////////////
//////////////////////////////////////////////////////////////

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  // Regex للتحقق من صيغة الإيميل
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null;
}

///////////////////////////////////////////////////////////////////

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  return null;
}

String? confirmPasswordValidator(
  String? value,
  TextEditingController passController,
) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != passController.text) {
    return 'Passwords do not match';
  }
  return null;
}

////////////////////////////////////////////////////////////

String? addChildNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the name';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }
  return null;
}

/////////////////////////////////////////////////////////////

String? addChildAgeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the age';
  }

  final age = int.tryParse(value);
  if (age == null) {
    return 'Please enter a valid number';
  }

  if (age < 3) {
    return 'Age must be 3 years or older';
  }

  if (age > 120) {
    return 'Please enter a reasonable age';
  }

  return null;
}

/////////////////////////////////////////////////////////////
String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter phone number';
  }
  // رقم الهاتف يجب أن يكون من 10 أرقام
  if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
    return 'Please enter a valid 11-digit phone number';
  }
  return null;
}

///////////////////////////////////////////////////////////////

String? completeDoctor(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please fill the field';
  }
  return null;
}

//////////////////////////////////////////////////////////////
/////              List to store children              ///////
//////////////////////////////////////////////////////////////
List<ChildModel> childrenList = [];

//////////////////////////////////////////////////////////////
/////              select image variables              ///////
//////////////////////////////////////////////////////////////
final ImagePicker picker = ImagePicker();
File? selectedImage;

//////////////////////////////////////////////////////////////
/////             select doctor or parent              ///////
//////////////////////////////////////////////////////////////
String userRole = '';

void onSignUpSuccess(BuildContext context) {
  if (userRole == 'doctor') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CompleteDoctorProfileScreen(),
      ),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainBottomNav()),
    );
  }
}

//////////////////////////////////////////////////////////////
/////////             selectedGender              ////////////
//////////////////////////////////////////////////////////////
String? selectedGender;

//////////////////////////////////////////////////////////////
/////////            selectedSpecialty            ////////////
//////////////////////////////////////////////////////////////
String? selectedSpecialty;
