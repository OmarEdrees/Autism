import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/add_child.dart';
import 'package:autism/presentation/screens/auth/edite_profile.dart';
import 'package:autism/presentation/screens/auth/sign_in_screen.dart';
import 'package:autism/presentation/widgets/profile/buildListTile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Supabase.instance.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
              emailController.clear();
              passController.clear();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // صورة البروفايل
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey[300],
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : const AssetImage(
                            'assets/images/autism-high-resolution-logo.png',
                          )
                          as ImageProvider, // ضع صورتك هنا
              ),
              const SizedBox(height: 15),
              Text(
                editeProfileName.text.isEmpty
                    ? "Enter Your Name"
                    : editeProfileName.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                editProfileTagName.text.isEmpty
                    ? "Enter Your Tag Name"
                    : editProfileTagName.text,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  final newImage = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditeProfile()),
                  );

                  if (newImage != null) {
                    setState(() {
                      selectedImage = newImage;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          height: 400,
          padding: EdgeInsets.only(top: 10),

          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildListTile(
                icon: Icons.face,
                title: "children",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddChild()),
                  );
                },
              ),
              divider(),
              buildListTile(
                icon: Icons.settings,
                title: "Settings",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              divider(),
              buildListTile(
                icon: Icons.lock,
                title: "Change password",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              divider(),
              buildListTile(
                icon: Icons.card_giftcard_sharp,
                title: "Refer friends",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              divider(),
              buildListTile(
                icon: Icons.info,
                title: "About",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              divider(),
              buildListTile(
                icon: Icons.phone,
                title: "Contact us",
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
