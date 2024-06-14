import 'package:flutter/material.dart';
import 'package:kerjain/models/perusahaan.dart';

class KartuHome extends StatefulWidget {
  const KartuHome({
    Key? key,
    required this.pekerjaan,
    required this.lokasi,
    required this.gajiDari,
    required this.gajiHingga,
    required this.slot,
    required this.perusahaan, // Ubah tipe data menjadi Perusahaan
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final String lokasi;
  final String gajiDari;
  final String gajiHingga;
  final String perusahaan; // Perusahaan sebagai objek Perusahaan
  final String slot;
  final Function() onPressed;
  final Color colors;

  @override
  _KartuHomeState createState() => _KartuHomeState();
}

class _KartuHomeState extends State<KartuHome> {
  Perusahaan _perusahaan = Perusahaan();

  @override
  void initState() {
    super.initState();
    Perusahaan.connectAPI(widget.perusahaan).then((value) {
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
        height: 212,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(5, 26, 73, 1),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.black, // Outline color
            width: 1, // Outline width
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.pekerjaan,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _perusahaan.nama ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '0 / ${widget.slot}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      widget.lokasi,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.gajiDari} - ${widget.gajiHingga}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Align(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      print(_perusahaan); // Contoh: Akses informasi perusahaan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(5, 26, 73, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Detail',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                      ],
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
