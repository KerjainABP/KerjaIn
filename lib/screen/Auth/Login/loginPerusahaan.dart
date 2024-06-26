import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kerjain/Widget/ButtonIcons.dart';
import 'package:http/http.dart' as http;
import 'package:kerjain/screen/Auth/Daftar/daftarPerusahaan.dart';
import 'dart:convert';

import 'package:kerjain/screen/home.dart';
import 'package:kerjain/screen/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
import 'package:kerjain/Widgets/NavigationMenu.dart';
*/

class LoginScreenPerusahaan extends StatefulWidget {
  LoginScreenPerusahaan({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenPerusahaan> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isSecurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22,
                  ),
                  Image.asset('assets/kerjain.png'),
                  Container(
                    child: const Text('Perusahaan',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                    child: const Text(
                      "Halo, Selamat Datang",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 32),
                    width: 212,
                    child:
                        Text("Temukan Beragam Individu dari berbagai bidang."),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(5, 26, 73, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextField(
                                        controller: usernameController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              right: 40,
                                              left: 10,
                                              bottom: 10,
                                              top: 10),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 10,
                                        child: ButtonIcons(
                                          iconData: Icons.email_outlined,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text("Test"),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    TextField(
                                      controller: passwordController,
                                      style: TextStyle(color: Colors.white),
                                      obscureText: _isSecurePassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            right: 40,
                                            left: 10,
                                            bottom: 10,
                                            top: 10),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 10,
                                      child: ButtonIcons(
                                        iconData: _isSecurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        onPressed: () {
                                          setState(() {
                                            _isSecurePassword =
                                                !_isSecurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(8, 157, 254, 1),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            String email = usernameController.text;
                            String password = passwordController.text;

                            // Menyiapkan data yang akan dikirimkan ke API
                            var data = {'email': email, 'password': password};
                            // if (data != null) {
                            //   Navigator.push<void>(
                            //     context,
                            //     MaterialPageRoute<void>(
                            //         builder: (BuildContext context) =>
                            //             HomePerusahaan()),
                            //   );

                            // }

                            //sini
                            // Menyambungkan ke API dengan header 'Content-Type'
                            var response = await http.post(
                              Uri.parse(
                                  'https://bekerjain-production.up.railway.app/api/loginperusahaan'),
                              headers: {
                                'Content-Type':
                                    'application/json', // Menambahkan header 'Content-Type'
                              },
                              body: jsonEncode(
                                  data), // Mengonversi data menjadi format JSON
                            );
                            // Memeriksa respon dari API
                            if (response.statusCode == 200) {
                              print('Respon dari API: ${response.body}');
                              var responseData = jsonDecode(response.body);
                              var receivedIdUser = responseData['id'];

                              // Menyimpan idUser ke dalam SharedPreferences
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'idPerusahaan', receivedIdUser);
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      HomePerusahaan(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Gagal Masuk"),
                                ),
                              );
                              print(
                                  'Gagal terhubung ke API. Kode status: ${response.statusCode}');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DaftarPerusahaan()));
                      },
                      child: const Center(
                        child: Text(
                          "Buat Akun Baru",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(125, 135, 151, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
