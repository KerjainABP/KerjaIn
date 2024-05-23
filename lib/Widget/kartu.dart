import "package:flutter/material.dart";

class kartu extends StatelessWidget {
  const kartu({
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
            borderRadius: BorderRadius.circular(17)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pekerjaan,
            style: TextStyle(
              color: Colors.white,
            ),),
            Text('kontol',
              style: TextStyle(
                color: Colors.white,
              ),),
            Text('memek',
              style: TextStyle(
                color: Colors.white,
              ),),
          ],
        ),
      ),
    );
  }
}