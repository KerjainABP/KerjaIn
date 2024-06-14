import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/screen/DetailJob/DetailJobUser.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobDeskripsiScreen extends StatefulWidget {
  @override
  _JobDeskripsiScreenState createState() => _JobDeskripsiScreenState();
}

class _JobDeskripsiScreenState extends State<JobDeskripsiScreen> {
  late Future<Lowongan> dataLowongan;
  String? idLowongan;
  String? idUser;
  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idUser = value!;
      });
    });
    idLowongan = Get.parameters['id'];
    if (idLowongan != null) {
      dataLowongan = LowonganService.connectAPI(idLowongan!);
    } else {
      // Assign a default value or handle the null case appropriately
      dataLowongan = Future.error('Invalid ID');
    }
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  void handleSubmit(
      BuildContext context, String userID, String idLowongan) async {
    try {
      var data = {'id_user': userID, 'id_lowongan': idLowongan};

      final response = await http.post(
        Uri.parse('https://bekerjain-production.up.railway.app/api/user/apply'),
        headers: {
          'Content-Type':
              'application/json', // Menambahkan header 'Content-Type'
        },
        body: jsonEncode(data), // Mengonversi data menjadi format JSON
      );

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil melamar pekerjaan'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/dashboardUser');
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Gagal melamar pekerjaan'),
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
      }
    } catch (error) {
      print("Gagal melamar pekerjaan: $error");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gagal melamar pekerjaan'),
            content: Text('Gagal melamar pekerjaan, silakan coba lagi'),
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
    }
  }

  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatCurrency.format(number);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail Job',
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
        child: FutureBuilder<Lowongan>(
          future: dataLowongan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            } else {
              Lowongan lowongan = snapshot.data!;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.8,
                          minChildSize: 0.8,
                          maxChildSize: 1.0,
                          builder: (context, controller) =>
                              SingleChildScrollView(
                            controller: controller,
                            child: Container(
                              height: screenHeight - 55,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF081127),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JobDetailScreen()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Detail'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromRGBO(217, 217, 217, 1),
                                          foregroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text('Perusahaan'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    lowongan.namaPosisi,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Perusahaan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    'Deskripsi Perusahaan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    lowongan.deskripsiPekerjaan,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),

                                  SizedBox(
                                      height:
                                          80), // Provide space for the fixed button
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        handleSubmit(context, idUser!, lowongan.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2949F1),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Lamar Pekerjaan',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
