import 'package:flutter/material.dart';

class SocialMediaRow extends StatelessWidget {
  final String image;
  final Function onTap;

  const SocialMediaRow({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(); // Call the onTap function when the icon is tapped
      },
      child: Image.asset(
        image,

      ),
    );
  }
}
