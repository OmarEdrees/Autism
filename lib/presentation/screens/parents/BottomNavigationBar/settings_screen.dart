import 'package:autism/logic/services/settings_services/settings_services.dart';
import 'package:autism/logic/services/variables_app.dart';
import 'package:autism/presentation/screens/parents/add_child_screen.dart';
import 'package:autism/presentation/screens/auth/edite_profile.dart';
import 'package:autism/presentation/screens/auth/sign_in_screen.dart';
import 'package:autism/presentation/widgets/profile/buildListTile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final profileService = ProfileService();
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    profileData = await profileService.getProfile();
    setState(() {});
  }

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
        child: Column(
          children: [
            // صورة البروفايل
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.grey[300],
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : NetworkImage(
                          profileData?['avatar_url'] ??
                              'assets/images/autism-high-resolution-logo.png',
                        )
                        as ImageProvider, // ضع صورتك هنا
            ),
            const SizedBox(height: 15),
            Text(
              profileData?['full_name'] ?? '',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              profileData?['phone'] ?? '',

              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditeProfile()),
                ).then((value) {
                  if (value == true) {
                    loadProfile(); // 👈 هذا سيعمل refresh تلقائي
                  }
                });
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
      bottomNavigationBar: Container(
        height: 350,
        padding: EdgeInsets.only(top: 10),

        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
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
                    MaterialPageRoute(builder: (context) => AddChildScreen()),
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
