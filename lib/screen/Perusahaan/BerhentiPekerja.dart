import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kerjain/models/kandidat.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:kerjain/services/kandidat_service.dart';

class Berhentipekerja extends StatefulWidget {
  @override
  _BerhentipekerjaState createState() => _BerhentipekerjaState();
}

class _BerhentipekerjaState extends State<Berhentipekerja> {
  late Future<Lowongan> dataLowongan;
  late Future<List<Kandidat>> futureKandidat;
  String? idLowongan;
  late String idPerusahaan;
  Perusahaan _perusahaan = Perusahaan();

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idPerusahaan = value ?? '';
        if (idPerusahaan.isNotEmpty) {
          Perusahaan.connectAPI(idPerusahaan).then((value) {
            setState(() {
              _perusahaan = value;
            });
          });
        }
      });
    });

    // Panggil fetchLowongan di sini setelah idLowongan didapatkan dari Get.parameters
    idLowongan = Get.parameters['id'];
    dataLowongan = LowonganService.connectAPI(idLowongan!);
    futureKandidat = fetchKandidat(idLowongan!);
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idPerusahaan');
  }

  Future<List<Kandidat>> fetchKandidat(String idLowongan) async {
    final url = Uri.parse(
        'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/pegawai/$idLowongan');
    final response = await http.get(url);

    print('Fetching candidates for lowongan ID: $idLowongan');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Kandidat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load candidates');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
              return Column(
                children: [
                  Expanded(
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      maxChildSize: 1.0,
                      builder: (context, controller) => SingleChildScrollView(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lowongan.namaPosisi,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _perusahaan.nama,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              FutureBuilder<List<Kandidat>>(
                                future: futureKandidat,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                        child: Text(
                                      'No candidates available',
                                      style: TextStyle(color: Colors.white),
                                    ));
                                  } else {
                                    List<Kandidat> candidates = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: candidates.length,
                                      itemBuilder: (context, index) {
                                        Kandidat candidate = candidates[index];
                                        return CandidateCard(
                                          name: candidate.nama,
                                          email: candidate.email,
                                          description: candidate.deskripsi,
                                          idUser: candidate.id,
                                          idLowongan: idLowongan!,
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 80,
                              ), // Provide space for the fixed button
                            ],
                          ),
                        ),
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

class CandidateCard extends StatelessWidget {
  final String name;
  final String email;
  final String description;
  final String idUser;
  final String idLowongan;

  CandidateCard({
    required this.name,
    required this.email,
    required this.description,
    required this.idUser,
    required this.idLowongan,
  });

  Future<void> berhentiPekerja(BuildContext context) async {
    try {
      final url = Uri.parse(
          'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/selesai/$idLowongan/$idUser');
      final response = await http.put(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pegawai Diberhentikan')),
        );
        print('Pegawai diberhentikan');
      } else {
        // Handle error case if needed
        print('Gagal menolak kandidat');
      }
    } catch (e) {
      // Handle any exceptions that occur
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(email),
            SizedBox(height: 10.0),
            Text(description),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => berhentiPekerja(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Berhentikan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
