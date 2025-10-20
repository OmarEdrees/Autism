import 'package:autism/logic/services/colors_app.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/widgets/parent/doctors_screen/card_gridView_widget.dart';
import 'package:flutter/material.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Doctors',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.medical_services, color: ColorsApp().primaryColor),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      controller: doctorsScreenSearch,
                      cursorColor: ColorsApp().primaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Search for doctors',

                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorsApp().primaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: ColorsApp().primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'All Doctors',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return CardGridViewWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
