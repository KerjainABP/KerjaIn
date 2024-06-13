import 'package:flutter/material.dart';

class KartuHome extends StatelessWidget {
  const KartuHome({
    Key? key,
    required this.pekerjaan,
    required this.lokasi,
    required this.gajiDari,
    required this.gajiHingga,
    required this.slot,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final String lokasi;
  final String gajiDari;
  final String gajiHingga;
  final String slot;
  final Function() onPressed;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pekerjaan,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Tokopedia',
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
                    '0 / $slot',
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
                    lokasi,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Text(
                "Rp $gajiDari - Rp $gajiHingga",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(5, 26, 73, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width:
                                  2), // Adjust space between icon and text as needed
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
