import 'package:flutter/material.dart';
import 'package:kerjain/models/perusahaan.dart';

class Kartu extends StatefulWidget {
  const Kartu({
    Key? key,
    required this.pekerjaan,
    required this.onPressed,
    required this.gajiDari,
    required this.gajiHingga,
    required this.perusahaan,
    this.colors = Colors.white,
    required this.textButton,
  }) : super(key: key);

  final String pekerjaan;
  final String perusahaan;
  final String textButton;
  final String gajiDari;
  final String gajiHingga;
  final Function() onPressed;
  final Color colors;

  @override
  _KartuState createState() => _KartuState();
}

class _KartuState extends State<Kartu> {
  late Perusahaan _perusahaan;

  @override
  void initState() {
    super.initState();
    _perusahaan = Perusahaan();

    // Fetch data perusahaan ketika Kartu diinisialisasi
    Perusahaan.connectAPI(widget.perusahaan).then((value) {
      // Pastikan widget masih terpasang sebelum memanggil setState
      setState(() {
        _perusahaan = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: 172,
        height: 252,
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
                    padding: const EdgeInsets.only(top: 8),
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
                    padding: const EdgeInsets.only(top: 10),
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
                        'Bandung', // Contoh lokasi statis, bisa diganti dengan data yang sesuai
                        style: TextStyle(
                          color: Color.fromRGBO(5, 26, 73, 1),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${widget.gajiDari} - ${widget.gajiHingga}', // Contoh gaji statis, bisa diganti dengan data yang sesuai
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
                  widget.textButton,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(5, 26, 73, 1),
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
}
