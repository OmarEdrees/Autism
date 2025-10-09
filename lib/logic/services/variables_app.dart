import 'dart:io';

import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/presentation/widgets/on_boarding/on_boarding_models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
final TextEditingController addChildName = TextEditingController();
final TextEditingController addChildAge = TextEditingController();
final TextEditingController editeProfileName = TextEditingController();
final TextEditingController editProfileEmail = TextEditingController();
final TextEditingController editProfileTagName = TextEditingController();

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

//////////////////////////////////////////////////////////////
/////              List to store children              ///////
//////////////////////////////////////////////////////////////
List<ChildModel> childrenList = [];

final ImagePicker picker = ImagePicker();
File? selectedImage;
