import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/parents/add_child_screen.dart';
import 'package:autism/presentation/screens/home_screen.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:autism/presentation/widgets/parent/doctors_screen/drop_down_specialty.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteDoctorProfileScreen extends StatefulWidget {
  const CompleteDoctorProfileScreen({super.key});

  @override
  State<CompleteDoctorProfileScreen> createState() =>
      _CompleteDoctorProfileScreenState();
}

class _CompleteDoctorProfileScreenState
    extends State<CompleteDoctorProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveDoctorData() async {
    if (!_formKey.currentState!.validate()) return;
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      debugPrint('No user currently logged in');
      return;
    }

    try {
      await Supabase.instance.client.from('doctors').insert({
        'id': user.id,
        'specialty': selectedSpecialty!,
        'qualification': qualificationController.text.trim(),
        'bio': bioController.text.trim(),
        'clinic_address': clinicAddressController.text.trim(),
        'is_verified': false,
      });
      print('000000000000000000000000000000000000');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The data has been saved successfully')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return userRole == 'doctor' ? HomeScreen() : AddChildScreen();
          },
        ),
      );
    } catch (e) {
      debugPrint('Insert error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.035,
            vertical: 20,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                  const SizedBox(height: 20),
                  dropDownSpecialty(),

                  const SizedBox(height: 15),
                  CustomTextFormField(
                    controller: qualificationController,
                    hintText: 'Qualification',
                    icon: Icons.school,
                    validator: completeDoctor,
                    focusNode: qualificationControllerFocus,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    controller: bioController,
                    hintText: 'Bio',
                    icon: Icons.info,
                    validator: completeDoctor,
                    focusNode: bioControllerFocus,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    controller: clinicAddressController,
                    hintText: 'Clinic Address',
                    icon: Icons.location_on,
                    validator: completeDoctor,
                    focusNode: clinicAddressControllerFocus,
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      _saveDoctorData();
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
                          'Add',
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
      ),
    );
  }
}
