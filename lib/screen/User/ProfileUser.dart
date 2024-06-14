import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartuProfile.dart';
import 'package:kerjain/models/kerjas.dart';
import 'package:kerjain/models/user.dart';
import 'package:kerjain/screen/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserPage extends StatefulWidget {
  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  late String idUser;
  bool isEditMode = false;

  User user = User();
  List<Kerjas> riwayatPekerjaan = [];

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idUser = value!;
        User.connectAPI(idUser).then((value) {
          setState(() {
            user = value;
            _descriptionController.text = user.deskripsi;
            _emailController.text = user.email;
            _namaController.text = user.nama;
            _dobController.text = user.tanggal_lahir;
          });
        });
        getRiwayat();
      });
    });
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  Future<void> getRiwayat() async {
    final url = Uri.parse(
        'https://bekerjain-production.up.railway.app/api/user/experience/$idUser');
    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        setState(() {
          riwayatPekerjaan =
              jsonList.map((json) => Kerjas.fromJson(json)).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load work history')),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load work history')),
      );
    }
  }

  Future<void> updateProfile() async {
    final url = Uri.parse(
        'https://bekerjain-production.up.railway.app/api/user/edit/$idUser');
    var data = {
      'nama': _namaController.text,
      'email': _emailController.text,
      'tanggal_lahir': _dobController.text,
      'deskripsi': _descriptionController.text,
    };
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        setState(() {
          isEditMode = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _emailController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200, top: 80),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => kerjaSplash()),
                  );
                },
                icon: Icon(Icons.logout_outlined),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(5, 26, 73, 1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: _namaController,
                      enabled: isEditMode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {
                      setState(() {
                        isEditMode = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(right: 220),
              child: Text(
                'Deskripsi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    enabled: isEditMode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.7),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _emailController,
                    enabled: isEditMode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _dobController,
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                isEditMode
                    ? ElevatedButton(
                        onPressed: updateProfile,
                        child: Text('Update Profile'),
                      )
                    : Container(),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    'Riwayat pekerjaan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: riwayatPekerjaan.length,
                    itemBuilder: (context, index) {
                      final kerja = riwayatPekerjaan[index];
                      return KartuProfile(
                        pekerjaan: kerja.nama_posisi,
                        idLowongan: kerja.id_lowongan,
                        idPerusahaan: kerja.id_perusahaan,
                        onPressed: () {},
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
