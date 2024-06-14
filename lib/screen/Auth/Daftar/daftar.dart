import 'package:flutter/material.dart';
import 'package:kerjain/screen/Auth/Login/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  _DaftarState createState() => _DaftarState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();
final TextEditingController _dobController = TextEditingController();

Future<void> registerUser(BuildContext context) async {
  if (_passwordController.text != _confirmPasswordController.text) {
    // Show error message if passwords do not match
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return;
  }

  final url = Uri.parse('https://bekerjain-production.up.railway.app/api/registeruser');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'nama': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'tanggal_lahir': _dobController.text,
    }),
  );

  if (response.statusCode == 201) {
    // Handle successful response
    print('User registered successfully');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } else {
    // Handle error response
    print('Failed to register user: ${response.body}');
  }
}

class _DaftarState extends State<Daftar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/kerjain.png'),
                    const SizedBox(
                      height: 17,
                    ),
                    Container(
                      child: const Text(
                        "Buat Akun Anda",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Beragam lowongan dari berbagai bidang menanti Anda. ',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(5, 26, 73, 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 44),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _nameController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Nama',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _dobController,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Ulang Tahun',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 24),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      onPressed: () => registerUser(context),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Daftar",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Create account action
                                  },
                                  child: Center(
                                    child: Text(
                                      "Sudah punya akun?",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color.fromRGBO(125, 135, 151, 1),
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
