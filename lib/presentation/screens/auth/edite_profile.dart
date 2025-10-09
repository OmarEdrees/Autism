import 'dart:io';

import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditeProfile extends StatefulWidget {
  const EditeProfile({super.key});

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edite Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // صورة البروفايل
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : null,
                    child: selectedImage == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey[700],
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: editeProfileName,
                  hintText: 'Full Name',
                  icon: Icons.person,
                  validator: addChildNameValidator,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: editProfileEmail,
                  hintText: 'Email',
                  icon: Icons.email,
                  validator: emailValidator,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: editProfileTagName,
                  hintText: 'Tag Name',
                  icon: Icons.person,
                  validator: addChildNameValidator,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, selectedImage);
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
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
