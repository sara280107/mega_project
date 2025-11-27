import 'package:flutter/material.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Iram Irfan Fakir";
  String phone = "2342135332";
  String email = "iramfaki@gmail.com";
  String vehicle = "MH09";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back, color: Colors.black),

        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () async {
              final updatedData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    name: name,
                    phone: phone,
                    email: email,
                    vehicle: vehicle,
                  ),
                ),
              );

              if (updatedData != null) {
                setState(() {
                  name = updatedData["name"];
                  phone = updatedData["phone"];
                  email = updatedData["email"];
                  vehicle = updatedData["vehicle"];
                });
              }
            },
            icon: Icon(Icons.edit, color: Colors.black),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),

            // ⭐ PROFILE AVATAR (from your second code)
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person,
                    size: 55, color: Colors.grey.shade600),
              ),
            ),

            SizedBox(height: 30),

            _buildLabel("Name"),
            _buildInfoBox(name),

            _buildLabel("Phone No"),
            _buildInfoBox(phone),

            _buildLabel("Email"),
            _buildInfoBox(email),

            _buildLabel("Vehicle No"),
            _buildInfoBox(vehicle),

            SizedBox(height: 30),

            // Logout button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "Logout ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                Icon(Icons.exit_to_app, size: 22, color: Colors.red),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 12, bottom: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
      ),
    );
  }
}
