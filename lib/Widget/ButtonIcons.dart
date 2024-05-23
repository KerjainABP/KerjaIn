import "package:flutter/material.dart";

class ButtonIcons extends StatelessWidget {
  const ButtonIcons({
    Key? key,
    required this.iconData,
    required this.onPressed,
    this.colors = Colors.white,
  }) : super(key: key);
  final IconData iconData;
  final Function() onPressed;
  final Color colors;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Icon(
          iconData,
          color: colors,
        ),
      ),
    );
  }
}