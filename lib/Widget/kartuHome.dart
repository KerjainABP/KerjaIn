import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kerjain/models/kandidat.dart';
import 'package:kerjain/models/perusahaan.dart';

class KartuHome extends StatefulWidget {
  const KartuHome({
    Key? key,
    required this.pekerjaan,
    required this.lokasi,
    required this.gajiDari,
    required this.gajiHingga,
    required this.slot,
    required this.perusahaan,
    required this.idLowongan,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final String lokasi;
  final String gajiDari;
  final String gajiHingga;
  final String perusahaan; // Changed type to Perusahaan
  final String idLowongan; // Changed type to Perusahaan
  final String slot;
  final Function() onPressed;
  final Color colors;

  @override
  _KartuHomeState createState() => _KartuHomeState();
}

class _KartuHomeState extends State<KartuHome> {
  Perusahaan? _perusahaan;
  List<Kandidat> _kandidatList = [];

  @override
  void initState() {
    super.initState();
    Perusahaan.connectAPI(widget.perusahaan).then((value) {
      setState(() {
        _perusahaan = value;
      });
    });

    // Fetch the list of candidates
    fetchKandidat(widget.idLowongan).then((kandidatList) {
      setState(() {
        _kandidatList = kandidatList;
      });
    });
  }

  Future<List<Kandidat>> fetchKandidat(String idLowongan) async {
    final url = Uri.parse(
        'https://bekerjain-production.up.railway.app/api/pt/lowonganperusahaan/pendaftar/$idLowongan');
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
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        width: 172,
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  _perusahaan?.nama ?? "", // Use the Perusahaan object's name
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
                      '${_kandidatList.length} / ${widget.slot}',
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
          ],
        ),
      ),
    );
  }
}
