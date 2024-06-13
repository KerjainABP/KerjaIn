import 'package:flutter/material.dart';
import 'package:kerjain/Widget/kartu.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/services/lowongan_service.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  late Future<List<Lowongan>> futureLowongan = LowonganService.fetchLowongan();
  final List<Lowongan> lowonganList = [];

  @override
  void initState() {
    super.initState();
    futureLowongan.then((value) {
      setState(() {
        lowonganList.addAll(value);
      });
    });
  }

  final TextEditingController _namaPosisiController = TextEditingController();
  final TextEditingController _deskripsiPekerjaanController =
      TextEditingController();
  final TextEditingController _kualifikasiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _gajiDariController = TextEditingController();
  final TextEditingController _gajiHinggaController = TextEditingController();

  void _showAddLowonganDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Lowongan Baru'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _namaPosisiController,
                  decoration: InputDecoration(labelText: 'Nama Posisi'),
                ),
                TextField(
                  controller: _deskripsiPekerjaanController,
                  decoration: InputDecoration(labelText: 'Deskripsi Pekerjaan'),
                ),
                TextField(
                  controller: _kualifikasiController,
                  decoration: InputDecoration(labelText: 'Kualifikasi'),
                ),
                TextField(
                  controller: _lokasiController,
                  decoration: InputDecoration(labelText: 'Lokasi'),
                ),
                TextField(
                  controller: _gajiDariController,
                  decoration: InputDecoration(labelText: 'Gaji Dari'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _gajiHinggaController,
                  decoration: InputDecoration(labelText: 'Gaji Hingga'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Lowongan newLowongan = Lowongan(
                  id: "",
                  namaPosisi: _namaPosisiController.text,
                  deskripsiPekerjaan: _deskripsiPekerjaanController.text,
                  kualifikasi: _kualifikasiController.text,
                  lokasi: _lokasiController.text,
                  open:
                      1, // Assuming 'open' is an integer representing a boolean state
                  slotPosisi: 1, // Example slot position
                  gajiDari: int.parse(_gajiDariController.text),
                  gajiHingga: int.parse(_gajiHinggaController.text),
                  idPerusahaan: 'COMP12345', // Example company ID
                  createdAt: DateTime.now().toIso8601String(),
                  updatedAt: DateTime.now().toIso8601String(),
                );

                await LowonganService.addLowongan(newLowongan);

                setState(() {
                  futureLowongan = LowonganService.fetchLowongan();
                });

                Navigator.of(context).pop();
                _namaPosisiController.clear();
                _deskripsiPekerjaanController.clear();
                _kualifikasiController.clear();
                _lokasiController.clear();
                _gajiDariController.clear();
                _gajiHinggaController.clear();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tugas 12"),
      ),
      body: FutureBuilder<List<Lowongan>>(
        future: futureLowongan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final lowongs = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,

              physics:
                  NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 12, // Horizontal spacing between columns
                mainAxisSpacing: 12, // Vertical spacing between rows
              ),
              itemCount: lowongs.length,
              itemBuilder: (context, index) {
                final lowong = lowongs[index];
                return Card(
                  child: Kartu(pekerjaan: lowong.namaPosisi, onPressed: () {}),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLowonganDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
