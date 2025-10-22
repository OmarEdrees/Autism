import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////
////////////           DropDownSpecialty           ///////////
//////////////////////////////////////////////////////////////

final List<String> autismDoctorSpecialties = [
  "Pediatric Neurologist",
  "Child Psychiatrist",
  "Developmental and Behavioral Pediatrician",
  "Pediatrician",
  "Speech and Language Therapist",
  "Occupational Therapist",
  "Applied Behavior Analyst (ABA Therapist)",
  "Clinical Psychologist",
  "Physiotherapist",
  "Special Education Specialist",
  "Music Therapist",
  "Art Therapist",
  "Social Worker",
  "Nutritionist",
  "Geneticist",
  "Occupational Health Specialist",
];

Widget dropDownSpecialty() => const DropDownSpecialty();

class DropDownSpecialty extends StatefulWidget {
  const DropDownSpecialty({Key? key}) : super(key: key);

  @override
  State<DropDownSpecialty> createState() => _DropDownSpecialtyState();
}

class _DropDownSpecialtyState extends State<DropDownSpecialty> {
  String? _localSelectedSpecialty;

  @override
  void initState() {
    super.initState();
    _localSelectedSpecialty = selectedSpecialty;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 👈 خليه ياخد كل المساحة لتجنب overflow

      child: DropdownButtonFormField<String>(
        isExpanded: true, // 👈 يمنع ظهور overflow
        isDense: true, // 👈 يقلل المسافات الداخلية
        decoration: InputDecoration(
          labelText: 'Specialty',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFFFF7F3E)),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.medical_services, color: ColorsApp().primaryColor),
                const SizedBox(width: 8),
                Container(
                  height: 24,
                  width: 1,
                  color: Colors.grey, // الخط الفاصل
                ),
              ],
            ),
          ),

          // contentPadding: const EdgeInsets.symmetric(
          //   horizontal: 12,
          //   vertical: 10,
          // ),
        ),
        value: _localSelectedSpecialty,
        items: autismDoctorSpecialties.map((specialty) {
          return DropdownMenuItem(
            value: specialty,
            child: Text(
              specialty,
              overflow: TextOverflow.ellipsis, // 👈 يخلي النص الطويل بثلاث نقط
              maxLines: 1,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _localSelectedSpecialty = value;
            selectedSpecialty = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a specialty';
          }
          return null;
        },
      ),
    );
  }
}
