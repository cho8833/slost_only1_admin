import 'package:flutter/material.dart';

class ProfileImageCircle extends StatelessWidget {
  const ProfileImageCircle({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: Container(
              color: Colors.black26,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.fitHeight,
                    )
                  : Container())),
    );
  }
}