import 'package:flutter/material.dart';
import 'package:kerjain/models/lowongan.dart';
import 'package:kerjain/models/perusahaan.dart';
import 'package:kerjain/services/lowongan_service.dart';

class KartuProfile extends StatefulWidget {
  const KartuProfile({
    Key? key,
    required this.pekerjaan,
    required this.idPerusahaan,
    required this.idLowongan,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final String idPerusahaan;
  final String idLowongan;
  final Function() onPressed;
  final Color colors;

  @override
  _KartuProfileState createState() => _KartuProfileState();
}

class _KartuProfileState extends State<KartuProfile> {
  late Perusahaan _perusahaan;
  late Lowongan _lowongan;

  @override
  void initState() {
    super.initState();
    _perusahaan = Perusahaan();
    _lowongan = Lowongan();

    // Fetch data perusahaan ketika KartuLamaran diinisialisasi
    Perusahaan.connectAPI(widget.idPerusahaan).then((value) {
      if (mounted) {
        // Pastikan widget masih terpasang sebelum memanggil setState
        setState(() {
          _perusahaan = value;
        });
      }
    });
    LowonganService.connectAPI(widget.idLowongan).then((value) {
      if (mounted) {
        // Pastikan widget masih terpasang sebelum memanggil setState
        setState(() {
          _lowongan = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: 172,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color.fromRGBO(5, 26, 73, 1),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.black, // Outline color
            width: 1, // Outline width
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.pekerjaan,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              _perusahaan.nama ??
                  'Loading...', // Menampilkan pesan Loading jika nama null
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Text(
                  _lowongan.lokasi ??
                      'Loading...', // Menampilkan pesan Loading jika lokasi null
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
