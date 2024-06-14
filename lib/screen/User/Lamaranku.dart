import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartuLamaran.dart';
import 'package:kerjain/models/kerjas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LamarankuPage extends StatefulWidget {
  @override
  _LamarankuPageState createState() => _LamarankuPageState();
}

class _LamarankuPageState extends State<LamarankuPage> {
  late Future<List<Kerjas>> futureKerjas;
  String? idUser;

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idUser = value!;
        // Panggil API setelah mendapatkan idUser
        futureKerjas = Kerjas.connectAPI(idUser!);
      });
    });
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Kerjas>>(
        future: futureKerjas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<Kerjas> kerjasList = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 64, bottom: 10),
                    child: Container(
                      child: Text(
                        'Lamaranku',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Text('Daftar Lamaran',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2,
                            ),
                            itemCount: kerjasList.length,
                            itemBuilder: (context, index) {
                              final kerjas = kerjasList[index];
                              return KartuLamaran(
                                pekerjaan: kerjas.nama_posisi,
                                onPressed: () {},
                                gajiDari: kerjas.id_perusahaan,
                                gajiHingga: kerjas.id_lowongan,
                                status: kerjas.status,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
