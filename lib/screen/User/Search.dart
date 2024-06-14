import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/services/lowongan_service.dart'; // Sesuaikan dengan lokasi file layanan
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late Future<List<Lowongan>> _futureLowongan;

  @override
  void initState() {
    super.initState();
    _futureLowongan = LowonganService
        .fetchLowongan(); // Memanggil layanan untuk mengambil data lowongan
  }

  void search(String searchText) {
    setState(() {
      _searchText = searchText;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64, bottom: 10),
              child: Container(
                child: Text(
                  'Search',
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 25),
                    child: TextField(
                      controller: _searchController,
                      onChanged: search,
                      decoration: InputDecoration(
                        suffixIcon: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(5, 26, 73, 1),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hasil Pencarian',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder<List<Lowongan>>(
                    future: _futureLowongan,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      } else {
                        List<Lowongan> lowongans = snapshot.data!;
                        List<Lowongan> filteredLowongans = lowongans
                            .where((lowongan) => lowongan.namaPosisi
                                .toLowerCase()
                                .contains(_searchText.toLowerCase()))
                            .toList();
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2,
                            ),
                            itemCount: filteredLowongans.length,
                            itemBuilder: (context, index) {
                              return Kartu(
                                pekerjaan: filteredLowongans[index].namaPosisi,
                                onPressed: () {},
                                textButton: "Lamar Sekarang",
                                gajiDari: formatRupiah(
                                    filteredLowongans[index].gajiDari),
                                gajiHingga: formatRupiah(
                                    filteredLowongans[index].gajiHingga),
                                perusahaan:
                                    filteredLowongans[index].idPerusahaan,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
