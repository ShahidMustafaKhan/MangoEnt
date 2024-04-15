import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../utils/theme/colors_constant.dart';

// //
// //
// // class RPSCustomPainter extends CustomPainter {
// // @override
// // void paint(Canvas canvas, Size size) {
// //
// //
// // Path path_1 = Path();
// // path_1.moveTo(size.width*0.5013333,size.height*0.7928913);
// // path_1.cubicTo(size.width*0.5477867,size.height*0.7928913,size.width*0.5854453,size.height*0.5507884,size.width*0.5854453,size.height*0.2521391);
// // path_1.cubicTo(size.width*0.5854453,size.height*0.1311864,size.width*0.6032400,size.height*-0.0002579130,size.width*0.6253467,size.height*0.01376400);
// // path_1.lineTo(size.width*0.9752133,size.height*0.2356913);
// // path_1.cubicTo(size.width*0.9893440,size.height*0.2446551,size.width,size.height*0.3097203,size.width,size.height*0.3870420);
// // path_1.lineTo(size.width,size.height*1.025123);
// // path_1.cubicTo(size.width,size.height*1.123304,size.width*0.9853547,size.height*1.202896,size.width*0.9672907,size.height*1.202896);
// // path_1.lineTo(size.width*0.03271040,size.height*1.202896);
// // path_1.cubicTo(size.width*0.01464493,size.height*1.202896,0,size.height*1.123304,0,size.height*1.025123);
// // path_1.lineTo(0,size.height*0.3870420);
// // path_1.cubicTo(0,size.height*0.3097203,size.width*0.01065579,size.height*0.2446551,size.width*0.02478707,size.height*0.2356913);
// // path_1.lineTo(size.width*0.3771173,size.height*0.01220106);
// // path_1.cubicTo(size.width*0.3993333,size.height*-0.001890290,size.width*0.4172213,size.height*0.1305874,size.width*0.4172213,size.height*0.2521391);
// // path_1.cubicTo(size.width*0.4172213,size.height*0.5507884,size.width*0.4548800,size.height*0.7928913,size.width*0.5013333,size.height*0.7928913);
// // path_1.close();
// //
// // Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
// // paint_1_fill.color = Color(0xff252626).withOpacity(1.0);
// // canvas.drawPath(path_1,paint_1_fill);
// //
// // }
// //
// // @override
// // bool shouldRepaint(covariant CustomPainter oldDelegate) {
// // return true;
// // }
// // }
//
//
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:mango_ent/utils/constants/colors_constant.dart';
//
//
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5013333, size.height * 0.7928913);
    path_0.cubicTo(
        size.width * 0.5477867,
        size.height * 0.7928913,
        size.width * 0.5854453,
        size.height * 0.5507884,
        size.width * 0.5854453,
        size.height * 0.2521391);
    path_0.cubicTo(
        size.width * 0.5854453,
        size.height * 0.1311864,
        size.width * 0.6032400,
        size.height * -0.0002579130,
        size.width * 0.6253467,
        size.height * 0.01376400);
    path_0.lineTo(size.width * 0.9752133, size.height * 0.2356913);
    path_0.cubicTo(size.width * 0.9893440, size.height * 0.2446551, size.width,
        size.height * 0.3097203, size.width, size.height * 0.3870420);
    path_0.lineTo(size.width, size.height * 1.025123);
    path_0.cubicTo(size.width, size.height * 1.123304, size.width * 0.9853547,
        size.height * 1.202896, size.width * 0.9672907, size.height * 1.202896);
    path_0.lineTo(size.width * 0.03271040, size.height * 1.202896);
    path_0.cubicTo(size.width * 0.01464493, size.height * 1.202896, 0,
        size.height * 1.123304, 0, size.height * 1.025123);
    path_0.lineTo(0, size.height * 0.3870420);
    path_0.cubicTo(
        0,
        size.height * 0.3097203,
        size.width * 0.01065579,
        size.height * 0.2446551,
        size.width * 0.02478707,
        size.height * 0.2356913);
    path_0.lineTo(size.width * 0.3771173, size.height * 0.01220106);
    path_0.cubicTo(
        size.width * 0.3993333,
        size.height * -0.001890290,
        size.width * 0.4172213,
        size.height * 0.1305874,
        size.width * 0.4172213,
        size.height * 0.2521391);
    path_0.cubicTo(
        size.width * 0.4172213,
        size.height * 0.5507884,
        size.width * 0.4548800,
        size.height * 0.7928913,
        size.width * 0.5013333,
        size.height * 0.7928913);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5013333, size.height * 0.7928913);
    path_1.cubicTo(
        size.width * 0.5477867,
        size.height * 0.7928913,
        size.width * 0.5854453,
        size.height * 0.5507884,
        size.width * 0.5854453,
        size.height * 0.2521391);
    path_1.cubicTo(
        size.width * 0.5854453,
        size.height * 0.1311864,
        size.width * 0.6032400,
        size.height * -0.0002579130,
        size.width * 0.6253467,
        size.height * 0.01376400);
    path_1.lineTo(size.width * 0.9752133, size.height * 0.2356913);
    path_1.cubicTo(size.width * 0.9893440, size.height * 0.2446551, size.width,
        size.height * 0.3097203, size.width, size.height * 0.3870420);
    path_1.lineTo(size.width, size.height * 1.025123);
    path_1.cubicTo(size.width, size.height * 1.123304, size.width * 0.9853547,
        size.height * 1.202896, size.width * 0.9672907, size.height * 1.202896);
    path_1.lineTo(size.width * 0.03271040, size.height * 1.202896);
    path_1.cubicTo(size.width * 0.01464493, size.height * 1.202896, 0,
        size.height * 1.123304, 0, size.height * 1.025123);
    path_1.lineTo(0, size.height * 0.3870420);
    path_1.cubicTo(
        0,
        size.height * 0.3097203,
        size.width * 0.01065579,
        size.height * 0.2446551,
        size.width * 0.02478707,
        size.height * 0.2356913);
    path_1.lineTo(size.width * 0.3771173, size.height * 0.01220106);
    path_1.cubicTo(
        size.width * 0.3993333,
        size.height * -0.001890290,
        size.width * 0.4172213,
        size.height * 0.1305874,
        size.width * 0.4172213,
        size.height * 0.2521391);
    path_1.cubicTo(
        size.width * 0.4172213,
        size.height * 0.5507884,
        size.width * 0.4548800,
        size.height * 0.7928913,
        size.width * 0.5013333,
        size.height * 0.7928913);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = AppColors.navBarColor.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.9752133, size.height * 0.2356913);
    path_2.lineTo(size.width * 0.9754827, size.height * 0.2230797);
    path_2.lineTo(size.width * 0.9752133, size.height * 0.2356913);
    path_2.close();
    path_2.moveTo(size.width * 0.02478707, size.height * 0.2356913);
    path_2.lineTo(size.width * 0.02451621, size.height * 0.2230797);
    path_2.lineTo(size.width * 0.02478707, size.height * 0.2356913);
    path_2.close();
    path_2.moveTo(size.width * 0.5831093, size.height * 0.2521391);
    path_2.cubicTo(
        size.width * 0.5831093,
        size.height * 0.5458580,
        size.width * 0.5461440,
        size.height * 0.7801928,
        size.width * 0.5013333,
        size.height * 0.7801928);
    path_2.lineTo(size.width * 0.5013333, size.height * 0.8055884);
    path_2.cubicTo(
        size.width * 0.5494293,
        size.height * 0.8055884,
        size.width * 0.5877813,
        size.height * 0.5557188,
        size.width * 0.5877813,
        size.height * 0.2521391);
    path_2.lineTo(size.width * 0.5831093, size.height * 0.2521391);
    path_2.close();
    path_2.moveTo(size.width * 0.6250747, size.height * 0.02637652);
    path_2.lineTo(size.width * 0.9749413, size.height * 0.2483043);
    path_2.lineTo(size.width * 0.9754827, size.height * 0.2230797);
    path_2.lineTo(size.width * 0.6256160, size.height * 0.001151526);
    path_2.lineTo(size.width * 0.6250747, size.height * 0.02637652);
    path_2.close();
    path_2.moveTo(size.width * 0.9749413, size.height * 0.2483043);
    path_2.cubicTo(
        size.width * 0.9878960,
        size.height * 0.2565203,
        size.width * 0.9976640,
        size.height * 0.3161638,
        size.width * 0.9976640,
        size.height * 0.3870420);
    path_2.lineTo(size.width * 1.002336, size.height * 0.3870420);
    path_2.cubicTo(
        size.width * 1.002336,
        size.height * 0.3032768,
        size.width * 0.9907920,
        size.height * 0.2327899,
        size.width * 0.9754827,
        size.height * 0.2230797);
    path_2.lineTo(size.width * 0.9749413, size.height * 0.2483043);
    path_2.close();
    path_2.moveTo(size.width * 0.9976640, size.height * 0.3870420);
    path_2.lineTo(size.width * 0.9976640, size.height * 1.025123);
    path_2.lineTo(size.width * 1.002336, size.height * 1.025123);
    path_2.lineTo(size.width * 1.002336, size.height * 0.3870420);
    path_2.lineTo(size.width * 0.9976640, size.height * 0.3870420);
    path_2.close();
    path_2.moveTo(size.width * 0.9672907, size.height * 1.190197);
    path_2.lineTo(size.width * 0.03271040, size.height * 1.190197);
    path_2.lineTo(size.width * 0.03271040, size.height * 1.215594);
    path_2.lineTo(size.width * 0.9672907, size.height * 1.215594);
    path_2.lineTo(size.width * 0.9672907, size.height * 1.190197);
    path_2.close();
    path_2.moveTo(size.width * 0.002336448, size.height * 1.025123);
    path_2.lineTo(size.width * 0.002336448, size.height * 0.3870420);
    path_2.lineTo(size.width * -0.002336448, size.height * 0.3870420);
    path_2.lineTo(size.width * -0.002336448, size.height * 1.025123);
    path_2.lineTo(size.width * 0.002336448, size.height * 1.025123);
    path_2.close();
    path_2.moveTo(size.width * 0.002336448, size.height * 0.3870420);
    path_2.cubicTo(
        size.width * 0.002336448,
        size.height * 0.3161638,
        size.width * 0.01210424,
        size.height * 0.2565203,
        size.width * 0.02505792,
        size.height * 0.2483043);
    path_2.lineTo(size.width * 0.02451621, size.height * 0.2230797);
    path_2.cubicTo(
        size.width * 0.009207307,
        size.height * 0.2327899,
        size.width * -0.002336448,
        size.height * 0.3032768,
        size.width * -0.002336448,
        size.height * 0.3870420);
    path_2.lineTo(size.width * 0.002336448, size.height * 0.3870420);
    path_2.close();
    path_2.moveTo(size.width * 0.02505792, size.height * 0.2483043);
    path_2.lineTo(size.width * 0.3773893, size.height * 0.02481348);
    path_2.lineTo(size.width * 0.3768480, size.height * -0.0004114145);
    path_2.lineTo(size.width * 0.02451621, size.height * 0.2230797);
    path_2.lineTo(size.width * 0.02505792, size.height * 0.2483043);
    path_2.close();
    path_2.moveTo(size.width * 0.5013333, size.height * 0.7801928);
    path_2.cubicTo(
        size.width * 0.4565227,
        size.height * 0.7801928,
        size.width * 0.4195573,
        size.height * 0.5458580,
        size.width * 0.4195573,
        size.height * 0.2521391);
    path_2.lineTo(size.width * 0.4148853, size.height * 0.2521391);
    path_2.cubicTo(
        size.width * 0.4148853,
        size.height * 0.5557188,
        size.width * 0.4532373,
        size.height * 0.8055884,
        size.width * 0.5013333,
        size.height * 0.8055884);
    path_2.lineTo(size.width * 0.5013333, size.height * 0.7801928);
    path_2.close();
    path_2.moveTo(size.width * 0.3773893, size.height * 0.02481348);
    path_2.cubicTo(
        size.width * 0.3875013,
        size.height * 0.01839797,
        size.width * 0.3968133,
        size.height * 0.04518290,
        size.width * 0.4037173,
        size.height * 0.08950710);
    path_2.cubicTo(
        size.width * 0.4106267,
        size.height * 0.1338788,
        size.width * 0.4148853,
        size.height * 0.1945116,
        size.width * 0.4148853,
        size.height * 0.2521391);
    path_2.lineTo(size.width * 0.4195573, size.height * 0.2521391);
    path_2.cubicTo(
        size.width * 0.4195573,
        size.height * 0.1882159,
        size.width * 0.4148720,
        size.height * 0.1218333,
        size.width * 0.4072827,
        size.height * 0.07310087);
    path_2.cubicTo(
        size.width * 0.3996880,
        size.height * 0.02432101,
        size.width * 0.3889467,
        size.height * -0.008087203,
        size.width * 0.3768480,
        size.height * -0.0004114145);
    path_2.lineTo(size.width * 0.3773893, size.height * 0.02481348);
    path_2.close();
    path_2.moveTo(size.width * 0.03271040, size.height * 1.190197);
    path_2.cubicTo(
        size.width * 0.01593531,
        size.height * 1.190197,
        size.width * 0.002336448,
        size.height * 1.116291,
        size.width * 0.002336448,
        size.height * 1.025123);
    path_2.lineTo(size.width * -0.002336448, size.height * 1.025123);
    path_2.cubicTo(
        size.width * -0.002336448,
        size.height * 1.130317,
        size.width * 0.01335453,
        size.height * 1.215594,
        size.width * 0.03271040,
        size.height * 1.215594);
    path_2.lineTo(size.width * 0.03271040, size.height * 1.190197);
    path_2.close();
    path_2.moveTo(size.width * 0.9976640, size.height * 1.025123);
    path_2.cubicTo(
        size.width * 0.9976640,
        size.height * 1.116291,
        size.width * 0.9840640,
        size.height * 1.190197,
        size.width * 0.9672907,
        size.height * 1.190197);
    path_2.lineTo(size.width * 0.9672907, size.height * 1.215594);
    path_2.cubicTo(
        size.width * 0.9866453,
        size.height * 1.215594,
        size.width * 1.002336,
        size.height * 1.130317,
        size.width * 1.002336,
        size.height * 1.025123);
    path_2.lineTo(size.width * 0.9976640, size.height * 1.025123);
    path_2.close();
    path_2.moveTo(size.width * 0.5877813, size.height * 0.2521391);
    path_2.cubicTo(
        size.width * 0.5877813,
        size.height * 0.1948130,
        size.width * 0.5920160,
        size.height * 0.1345919,
        size.width * 0.5988880,
        size.height * 0.09054812);
    path_2.cubicTo(
        size.width * 0.6057520,
        size.height * 0.04655406,
        size.width * 0.6150133,
        size.height * 0.01999391,
        size.width * 0.6250747,
        size.height * 0.02637652);
    path_2.lineTo(size.width * 0.6256160, size.height * 0.001151526);
    path_2.cubicTo(
        size.width * 0.6135733,
        size.height * -0.006487812,
        size.width * 0.6028853,
        size.height * 0.02566319,
        size.width * 0.5953253,
        size.height * 0.07412406);
    path_2.cubicTo(
        size.width * 0.5877707,
        size.height * 0.1225354,
        size.width * 0.5831093,
        size.height * 0.1885130,
        size.width * 0.5831093,
        size.height * 0.2521391);
    path_2.lineTo(size.width * 0.5877813, size.height * 0.2521391);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.04933333, size.height * -24.46043),
        Offset(size.width * 0.4845520, size.height * 2.670652), [
      const Color.fromRGBO(255, 255, 255, 0.15),
      const Color.fromRGBO(255, 255, 255, 0.15)
    ], [
      0.68,
      85.63
    ]);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff252626)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
