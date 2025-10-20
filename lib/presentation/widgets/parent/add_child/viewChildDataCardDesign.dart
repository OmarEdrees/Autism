import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////
////////////      _infoCard_addChildScreen       /////////////
//////////////////////////////////////////////////////////////
Widget _infoCard(IconData icon, String value, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ),

      Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsApp().primaryColor.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorsApp().primaryColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value.isNotEmpty ? value : '—',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////
//////////      viewChildData_addChildScreen       ///////////
//////////////////////////////////////////////////////////////
Future<dynamic> viewChildData(BuildContext context, ChildModel child) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // صورة الطفل
                Center(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.deepOrange.withOpacity(0.1),
                    backgroundImage:
                        (child.imageUrl != null && child.imageUrl!.isNotEmpty)
                        ? NetworkImage(child.imageUrl!)
                        : null,
                    child: (child.imageUrl == null || child.imageUrl!.isEmpty)
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.orange,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: const Text(
                    'Child Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                _infoCard(Icons.person, child.name, 'name'),
                _infoCard(Icons.wc, child.typeGender, 'Gender'),

                _infoCard(Icons.cake, child.birthdate, 'birthdate'),
                _infoCard(Icons.cake, '${child.age}', 'age'),
                _infoCard(
                  Icons.medical_information,
                  child.diagnosis,
                  'diagnosis',
                ),
                _infoCard(Icons.interests, child.hobbies, 'hobbies'),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
                        'Close',
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
      );
    },
  );
}
