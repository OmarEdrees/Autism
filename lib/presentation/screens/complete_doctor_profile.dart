import 'package:autism/logic/services/sized_config.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteDoctorProfile extends StatefulWidget {
  const CompleteDoctorProfile({super.key});

  @override
  State<CompleteDoctorProfile> createState() => _CompleteDoctorProfileState();
}

class _CompleteDoctorProfileState extends State<CompleteDoctorProfile> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveDoctorData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.from('doctors').insert({
        //'id': "1",
        'specialty': specialtyController.text.trim(),
        'qualification': qualificationController.text.trim(),
        'bio': bioController.text.trim(),
        'clinic_address': clinicAddressController.text.trim(),
        'is_verified': false,
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حفظ البيانات بنجاح ✅')));
      //Navigator.pop(context);
    } catch (e) {
      debugPrint('Insert error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    specialtyController.dispose();
    qualificationController.dispose();
    bioController.dispose();
    clinicAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: specialtyController,
                    hintText: 'Specialty',
                    icon: Icons.medical_services,
                    validator: completeDoctor,
                    focusNode: specialtyControllerFocus,
                  ),
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

                  isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () {
                            _saveDoctorData;
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
