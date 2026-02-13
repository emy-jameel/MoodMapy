import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 130);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class HeaderClipperTow extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0016667, size.height * 0.0028571);
    path_0.lineTo(size.width * 0.0011000, size.height * 0.5729571);
    path_0.quadraticBezierTo(size.width * 0.1658667, size.height * 0.5621000, size.width * 0.2437750, size.height * 0.6165429);
    path_0.cubicTo(
      size.width * 0.333,
      size.height * 0.6729,
      size.width * 0.423458,
      size.height * 0.79,
      size.width * 0.492667,
      size.height * 0.823429,
    );
    path_0.quadraticBezierTo(size.width * 0.8, size.height * 0.9, size.width * 0.9994417, size.height * 0.5702143);
    path_0.lineTo(size.width, size.height * -0.0128571);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
