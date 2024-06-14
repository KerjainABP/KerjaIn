import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/services/lowongan_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IklankuPage extends StatefulWidget {
  @override
  _IklankuPageState createState() => _IklankuPageState();
}

class _IklankuPageState extends State<IklankuPage> {
  late Future<List<Lowongan>> futureLowongan;
  late String idPerusahaan;
  Perusahaan _perusahaan = Perusahaan();

  @override
  void initState() {
    super.initState();
    getIdUser().then((value) {
      setState(() {
        idPerusahaan = value ?? '';
        // Panggil API setelah mendapatkan idPerusahaan
        if (idPerusahaan.isNotEmpty) {
          Perusahaan.connectAPI(idPerusahaan).then((value) {
            setState(() {
              _perusahaan = value;
            });
          });
          futureLowongan = _fetchLowongan(idPerusahaan);
        }
      });
    });
  }

  String formatRupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatCurrency.format(number);
  }

  Future<List<Lowongan>> _fetchLowongan(String idPerusahaan) async {
    try {
      List<Lowongan> lowongan =
          await LowonganService.checkLowongan(idPerusahaan);
      return lowongan;
    } catch (e) {
      print('Error fetching lowongan: $e');
      throw e; // Rethrow error to handle it in FutureBuilder
    }
  }

  Future<String?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idPerusahaan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(217, 217, 217, 1),
        child: Stack(
          children: <Widget>[
            FutureBuilder<List<Lowongan>>(
              future: futureLowongan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  List<Lowongan> lowongan = snapshot.data!;
                  return Container(
                    margin: EdgeInsets.only(top: 100),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2,
                      ),
                      itemCount: lowongan.length,
                      itemBuilder: (context, index) {
                        final lowong = lowongan[index];
                        return Kartu(
                          pekerjaan: lowong.namaPosisi,
                          onPressed: () =>
                              Get.toNamed('/kelolaIklan/${lowong.id}'),
                          perusahaan: lowong.idPerusahaan,
                          gajiDari: formatRupiah(lowong.gajiDari),
                          gajiHingga: formatRupiah(lowong.gajiHingga),
                          textButton: "Kelola Iklan",
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white, // Warna latar belakang judul
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Iklanku',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
