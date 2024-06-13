import 'package:flutter/material.dart';

class KartuLamaran extends StatelessWidget {
  const KartuLamaran({
    Key? key,
    required this.pekerjaan,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);

  final String pekerjaan;
  final Function() onPressed;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
                      pekerjaan,
                      style: TextStyle(
                        color: Color.fromRGBO(5, 26, 73, 1),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Mengganti kata yang tidak pantas dengan kata yang relevan
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Tokopedia',
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
                        'Bandung',
                        style: TextStyle(
                          color: Color.fromRGBO(5, 26, 73, 1),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Rp 1.000.000 - Rp 2.000.000',
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
                onPressed: onPressed,
                child: Text('Di Proses',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),),
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
