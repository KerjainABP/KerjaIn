import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/screen/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuatIklanScreen(),
    );
  }
}

class BuatIklanScreen extends StatefulWidget {
  @override
  _BuatIklanScreenState createState() => _BuatIklanScreenState();
}

class _BuatIklanScreenState extends State<BuatIklanScreen> {
  late String idPerusahaan;
  bool isLoading = false;
  Perusahaan _perusahaan = Perusahaan();

  final TextEditingController posisiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController gajiDariController = TextEditingController();
  final TextEditingController gajiHinggaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController kualifikasiController = TextEditingController();

  @override
  void dispose() {
    posisiController.dispose();
    lokasiController.dispose();
    gajiDariController.dispose();
    gajiHinggaController.dispose();
    deskripsiController.dispose();
    kualifikasiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idPerusahaan = value!;
        // Panggil API setelah mendapatkan idUser
        Perusahaan.connectAPI(idPerusahaan).then((value) {
          setState(() {
            _perusahaan = value;
          });
        });
      });
    });
  }

  Future<void> submitIklan() async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl =
        "http://127.0.0.1:8000/api/pt/newlowongan/$idPerusahaan";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama_posisi': posisiController.text,
        'lokasi': lokasiController.text,
        'gaji_dari': gajiDariController.text,
        'gaji_hingga': gajiHinggaController.text,
        'deskripsi_pekerjaan': deskripsiController.text,
        'kualifikasi': kualifikasiController.text,
        'id_perusahaan': idPerusahaan,
        "slot_posisi": "10",
      }),
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iklan berhasil dibuat!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePerusahaan()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Gagal membuat iklan. Kode status: ${response.statusCode}')),
      );
    }
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idPerusahaan');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getIdUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Error loading user ID')),
          );
        }

        idPerusahaan = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Buat Iklan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF081127),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              child: TextField(
                                controller: posisiController,
                                decoration: InputDecoration(
                                  hintText: 'Posisi Pekerjaan',
                                  hintStyle: TextStyle(color: Colors.white54),
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              _perusahaan.nama,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.white),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                      controller: lokasiController,
                                      decoration: InputDecoration(
                                        hintText: 'Lokasi',
                                        hintStyle:
                                            TextStyle(color: Colors.white54),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.money_sharp, color: Colors.white),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                      controller: gajiDariController,
                                      decoration: InputDecoration(
                                        hintText: 'Gaji Dari',
                                        hintStyle:
                                            TextStyle(color: Colors.white54),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: gajiHinggaController,
                                      decoration: InputDecoration(
                                        hintText: 'Gaji Hingga',
                                        hintStyle:
                                            TextStyle(color: Colors.white54),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Isi Deskripsi Pekerjaan',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: deskripsiController,
                          decoration: InputDecoration(
                            hintText: 'Deskripsi Pekerjaan',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 5,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kualifikasi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: kualifikasiController,
                          decoration: InputDecoration(
                            hintText: 'Kualifikasi Pekerjaan',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white12,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          maxLines: 5,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  await submitIklan();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF2949F1),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 140, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text('Buat Iklan'),
                              ),
                      ],
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
}
