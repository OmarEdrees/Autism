import 'dart:io';
import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  String? selectedAutismType;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  dropDown() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Type of Autism',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFF7F3E)),
        ),
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.psychology_alt, color: ColorsApp().primaryColor),
      ),
      value: selectedAutismType,
      items:
          [
            'Classic Autism',
            'Asperger’s',
            'PDD-NOS',
            'Rett Syndrome',
            'Childhood Disintegrative',
          ].map((type) {
            return DropdownMenuItem(value: type, child: Text(type));
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedAutismType = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a type of autism';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                  SizedBox(height: 15),
                  Text(
                    "Choose a picture",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    focusNode: addChildNameFocus,
                    validator: addChildNameValidator,
                    controller: addChildName,
                    hintText: 'Enter the name',
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 15),
                  CustomTextFormField(
                    focusNode: addChildAgeFocus,
                    validator: addChildAgeValidator,
                    controller: addChildAge,
                    hintText: 'Enter the age',
                    icon: Icons.cake, // أيقونة مناسبة للعمر
                  ),

                  const SizedBox(height: 15),
                  dropDown(),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        context.read<ChildrenCubit>().addChild(
                          ChildModel(
                            name: addChildName.text,
                            age: addChildAge.text,
                            type: selectedAutismType!,
                            image: selectedImage,
                          ),
                        );
                      });
                      print(
                        '/////////////////////////////////////////////////////////////////',
                      );
                      print(childrenList);

                      // تنظيف الحقول
                      addChildName.clear();
                      addChildAge.clear();
                      selectedImage = null;
                      selectedAutismType = null;
                      Navigator.pop(context);
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
        );
      },
      backgroundColor: const Color(0xFFFF7F3E),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

// import 'dart:io';

// import 'package:autism/logic/services/colors_app.dart';
// import 'package:autism/logic/services/variables_app.dart';
// import 'package:autism/presentation/widgets/auth/sign_up_in_customTextFields.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class FloatingActionButtonWidget extends StatefulWidget {
//   const FloatingActionButtonWidget({super.key});

//   @override
//   State<FloatingActionButtonWidget> createState() =>
//       _FloatingActionButtonWidgetState();
// }

// class _FloatingActionButtonWidgetState
//     extends State<FloatingActionButtonWidget> {
//   String? selectedAutismType;
//   File? _selectedImage; // الصورة المختارة
//   final ImagePicker _picker = ImagePicker(); // كائن لاختيار الصور

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path); // حفظ الصورة
//       });
//     }
//   }

//   dropDown() {
//     return DropdownButtonFormField<String>(
//       isExpanded: true,
//       decoration: InputDecoration(
//         labelText: 'Type of Autism',
//         border: OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xFFFF7F3E)),
//         ),
//         labelStyle: TextStyle(color: Colors.grey[600]),
//         prefixIcon: Icon(Icons.psychology_alt, color: ColorsApp().primaryColor),
//       ),
//       value: selectedAutismType,
//       items:
//           [
//             'Classic Autism',
//             'Asperger’s',
//             'PDD-NOS',
//             'Rett Syndrome',
//             'Childhood Disintegrative',
//           ].map((type) {
//             return DropdownMenuItem(value: type, child: Text(type));
//           }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedAutismType = value;
//         });
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a type of autism';
//         }
//         return null;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         setState(() {
//           showDialog(
//             context: context,
//             //barrierDismissible: false, // ما يختفي لما يضغط خارج النافذة
//             builder: (context) {
//               return Dialog(
//                 insetPadding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 40,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         GestureDetector(
//                           onTap: _pickImage,
//                           child: CircleAvatar(
//                             radius: 75,
//                             backgroundColor: Colors.grey[300],
//                             backgroundImage: _selectedImage != null
//                                 ? FileImage(_selectedImage!)
//                                 : null,
//                             child: _selectedImage == null
//                                 ? Icon(
//                                     Icons.camera_alt,
//                                     size: 40,
//                                     color: Colors.grey[700],
//                                   )
//                                 : null,
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         Text(
//                           "Choose a picture",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         CustomTextFormField(
//                           validator: addChildNameValidator,
//                           controller: addChildName,
//                           hintText: 'Enter the name',
//                           icon: Icons.person,
//                         ),
//                         SizedBox(height: 20),
//                         CustomTextFormField(
//                           validator: addChildAgeValidator,
//                           controller: addChildAge,
//                           hintText: 'Enter the age',
//                           icon: Icons.cake, // أيقونة مناسبة للعمر
//                         ),
//                         SizedBox(height: 30),
//                         dropDown(),
//                         SizedBox(height: 30),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               childrenList.add({
//                                 "name": addChildName.text,
//                                 "age": addChildAge.text,
//                                 "type": selectedAutismType ?? "",
//                                 "image": _selectedImage,
//                               });
//                             });

//                             // تنظيف الحقول
//                             addChildName.clear();
//                             addChildAge.clear();
//                             _selectedImage = null;
//                             selectedAutismType = null;
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: double.infinity,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Color(0xFFFF7F3E),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Add',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//       },
//       backgroundColor: ColorsApp().primaryColor,
//       child: Icon(Icons.add, color: Colors.white),
//     );
//   }
// }
