import 'package:flutter/material.dart';

class Kartu extends StatelessWidget {
  const Kartu({
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
        height: 212,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color.fromRGBO(5, 26, 73, 1),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pekerjaan,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // Mengganti kata yang tidak pantas dengan kata yang relevan
            Text(
              'Deskripsi pekerjaan 1',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Deskripsi pekerjaan 2',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
