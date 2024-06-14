import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KelolaIklanPage(),
    );
  }
}

class KelolaIklanPage extends StatefulWidget {
  @override
  _KelolaIklanPageState createState() => _KelolaIklanPageState();
}

class _KelolaIklanPageState extends State<KelolaIklanPage> {
  late Future<Lowongan> dataLowongan;
  String? idLowongan;
  String? idUser;

  TextEditingController namaJobController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController gajiDariController = TextEditingController();
  TextEditingController gajiHinggaController = TextEditingController();
  TextEditingController kualifikasiController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController slotController = TextEditingController();

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
      dataLowongan = Future.error('Invalid ID');
    }

    // Set initial values for TextEditingControllers if data is available
    if (dataLowongan != null) {
      dataLowongan.then((lowongan) {
        namaJobController.text = lowongan.namaPosisi;
        deskripsiController.text = lowongan.deskripsiPekerjaan;
        gajiDariController.text = lowongan.gajiDari.toString();
        gajiHinggaController.text = lowongan.gajiHingga.toString();
        kualifikasiController.text = lowongan.kualifikasi;
        lokasiController.text = lowongan.lokasi;
        slotController.text = lowongan.slotPosisi.toString();
      });
    }
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idPerusahaan');
  }

  void handleSubmit(
      BuildContext context, String userID, String idLowongan) async {
    var updatedJobData = {
      'nama_posisi': namaJobController.text,
      'deskripsi_pekerjaan': deskripsiController.text,
      'gaji_dari': gajiDariController.text,
      'gaji_hingga': gajiHinggaController.text,
      'kualifikasi': kualifikasiController.text,
      'slot_posisi': slotController.text,
      'lokasi': lokasiController.text,
      'open': true,
    };

    try {
      final response = await http.put(
        Uri.parse(
            'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/edit/$idLowongan'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedJobData),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil memperbarui pekerjaan'),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Gagal memperbarui pekerjaan'),
              content: Text('Gagal memperbarui pekerjaan, silakan coba lagi'),
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
      print("Gagal memperbarui pekerjaan: $error");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gagal memperbarui pekerjaan'),
            content: Text('Gagal memperbarui pekerjaan, silakan coba lagi'),
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
        child: Column(
          children: [
            Expanded(
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.8,
                maxChildSize: 1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF081127),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Backend Developer',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tokopedia',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: lokasiController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Slot Posisi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: slotController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gaji Dari',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: gajiHinggaController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gaji Hingga',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: gajiDariController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Deskripsi Pekerjaan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: deskripsiController,
                            maxLines: 5,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kualifikasi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: kualifikasiController,
                            maxLines: 5,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              handleSubmit(context, idUser!, idLowongan!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2949F1),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Simpan Perubahan'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
