import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kerjain/screen/Auth/Login/loginPerusahaan.dart';

class DaftarPerusahaan extends StatefulWidget {
  const DaftarPerusahaan({Key? key}) : super(key: key);

  @override
  _DaftarPerusahaanState createState() => _DaftarPerusahaanState();
}

class _DaftarPerusahaanState extends State<DaftarPerusahaan> {
  TextEditingController _namaPerusahaanController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _tahunBerdiriController = TextEditingController();

  void dispose() {
    _namaPerusahaanController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _tahunBerdiriController.dispose();
    super.dispose();
  }

  Future<void> _registerCompany(BuildContext context) async {
    String url =
        'http://127.0.0.1:8000/api/registerperusahaan'; // Ganti dengan URL endpoint API register perusahaan Anda
    var body = {
      'nama': _namaPerusahaanController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'tahun_berdiri': _tahunBerdiriController.text,
      'tipe': "swasta"
    };

    // Kirim request ke API
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      // Berhasil mendaftar, mungkin tambahkan logika navigasi ke halaman selanjutnya
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenPerusahaan()),
      );
    } else {
      // Gagal mendaftar, mungkin tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal mendaftar. Silakan coba lagi.'),
      ));
    }
  }

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
                        "Buat Akun Perusahaan Anda",
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
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
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
                                SizedBox(
                                  height: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _namaPerusahaanController,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Nama Perusahaan',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Container(
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
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Container(
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
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Container(
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
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Confirm Password',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _tahunBerdiriController,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Tahun Berdiri',
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
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
                                      onPressed: () =>
                                          _registerCompany(context),
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
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DaftarPerusahaan()));
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
