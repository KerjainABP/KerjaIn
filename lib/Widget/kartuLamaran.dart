import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/services/lowongan_service.dart';

class KartuLamaran extends StatefulWidget {
  const KartuLamaran({
    Key? key,
    required this.pekerjaan,
    required this.gajiDari,
    required this.gajiHingga,
    required this.status,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final String gajiDari;
  final String gajiHingga;
  final String status;
  final Function() onPressed;
  final Color colors;

  @override
  _KartuLamaranState createState() => _KartuLamaranState();
}

class _KartuLamaranState extends State<KartuLamaran> {
  late Perusahaan _perusahaan;
  late Lowongan _lowongan;

  @override
  void initState() {
    super.initState();
    _perusahaan = Perusahaan();
    _lowongan = Lowongan();

    // Fetch data perusahaan ketika KartuLamaran diinisialisasi
    Perusahaan.connectAPI(widget.gajiDari).then((value) {
      if (mounted) {
        // Pastikan widget masih terpasang sebelum memanggil setState
        setState(() {
          _perusahaan = value;
        });
      }
    });
    LowonganService.connectAPI(widget.gajiHingga).then((value) {
      if (mounted) {
        // Pastikan widget masih terpasang sebelum memanggil setState
        setState(() {
          _lowongan = value;
        });
      }
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
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: 172,
        height: 400,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.black, // Outline color
            width: 1, // Outline width
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text(
                      widget.pekerjaan,
                      style: TextStyle(
                        color: Color.fromRGBO(5, 26, 73, 1),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Menggunakan data _perusahaan yang sudah diambil dari API
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _perusahaan
                          .nama, // Menggunakan nama perusahaan dari objek _perusahaan
                      style: TextStyle(
                        color: Color.fromRGBO(5, 26, 73, 1),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color.fromRGBO(5, 26, 73, 1),
                      ),
                      Text(
                        _lowongan
                            .lokasi, // Contoh lokasi statis, bisa diganti dengan data yang sesuai
                        style: TextStyle(
                          color: Color.fromRGBO(5, 26, 73, 1),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${formatRupiah(_lowongan.gajiDari)} - ${formatRupiah(_lowongan.gajiHingga)}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(5, 26, 73, 1),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 2,
              right: 5,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(widget.status),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to determine button background color based on status
  Color _getButtonColor(String status) {
    switch (status) {
      case 'diterima':
        return Colors.green; // Green color if status is 'diterima'
      case 'ditolak':
        return Colors.red; // Red color if status is 'ditolak'
      case 'applied':
        return Color.fromRGBO(
            5, 26, 73, 1); // Yellow color if status is 'applied'
      default:
        return Color.fromRGBO(5, 26, 73, 1); // Default color for other cases
    }
  }
}
