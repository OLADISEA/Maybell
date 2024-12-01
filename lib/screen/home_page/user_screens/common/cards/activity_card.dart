import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../common/entities/colors.dart';
import '../models/account_activity.dart';


class ActivityChart extends StatefulWidget {
  const ActivityChart({super.key});

  @override
  State<ActivityChart> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  final List<AccountActivity> activities = [


    AccountActivity(0.55, "Completed", AppColors.mainColor),
    AccountActivity(0.3, "In-Progress", Color(0XFF263238)),
    AccountActivity(0.15, "Not Started", Color(0XFF455A64)),
  ];

  late Timer timer;
  double fullAngle = 0.0;
  double secondsToComplete = 5.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1000~/60), (timer) {
      setState(() {
        fullAngle += 360.0 / (secondsToComplete * 1000~/60);
        if(fullAngle >= 360.0){
          fullAngle = 360.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      child: CustomPaint(
        painter: ChartPainter(activities,fullAngle),
        child: Container(
          height: 120.h,
          width: 140,
        ),
      ),
    );
  }
}


final linePaint = Paint()..color = Colors.black38..strokeWidth = 2.0..style = PaintingStyle.stroke;
final midPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
final textFieldTextBigStyle = TextStyle(
  color: Colors.black38,
  fontWeight: FontWeight.bold,
  fontSize: 14.sp,
);
const labelStyle = TextStyle(
  color:  Colors.black,
  fontSize: 12.0,
);
class ChartPainter extends CustomPainter{
  final List<AccountActivity> activities;
  final double fullAngle;
  ChartPainter(this.activities, this.fullAngle);
  @override
  void paint(Canvas canvas, Size size){
    final c = Offset(size.width/2.0, size.height/2.0);
    final radius = size.width * 0.9;
    final rect = Rect.fromCenter(center: c, width: radius, height: radius);
    var startAngle = 75.8;
    canvas.drawArc(rect, startAngle, fullAngle * pi/180.0, false, linePaint);

    activities.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawSector(canvas, di, rect, startAngle,sweepAngle);
      startAngle += sweepAngle;
    });
    startAngle = -75.0;
    activities.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawLine(canvas, c, radius, startAngle);
      startAngle += sweepAngle;
      });

    startAngle = 75.0;
    activities.forEach((di) {
      final sweepAngle = di.value * fullAngle * pi / 180.0;
      drawLabels(canvas, c, radius, startAngle,sweepAngle,di.label);
      startAngle += sweepAngle;
    });

    //draw the middle/circle
    canvas.drawCircle(c, radius * 0.3, midPaint);
    
    //draw title
    drawTextCentered(canvas, c, "600", textFieldTextBigStyle, radius * 0.6,(Size sz){});
  }

  void drawLabels(Canvas canvas, Offset c, double radius, double startAngle, double sweepAngle, String label) {
    final r = radius * 0.4;
    final dx = r * cos(startAngle + sweepAngle/2.0);
    final dy = r * sin(startAngle + sweepAngle/2.0);
    final position = c + Offset(dx,dy);
    //drawTextCentered(canvas, position, label, labelStyle, 100.0,(Size sz){
     // final rect = Rect.fromCenter(center: c + position, width: sz.width, height: sz.height+ 5);
     // final rrect= RRect.fromRectAndRadius(rect, Radius.circular(5));
     // canvas.drawRRect(rrect, midPaint);
    //});
  }
  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align){
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(text: span,textAlign: align,textDirection: TextDirection.ltr);

    //ellipsis:"...");
    tp.layout(minWidth: 0,maxWidth: maxWidth);
    return tp;
  }
  Size drawTextCentered(Canvas canvas, Offset position, String text, TextStyle style, double maxWidth,Function(Size sz) bgCb){
    final tp = measureText(text, style, maxWidth, TextAlign.center);
    final pos = position + Offset(-tp.width/2.0,-tp.height/2.0);
    bgCb(tp.size);

    tp.paint(canvas, pos);
    return tp.size;
  }
  void drawLine(Canvas canvas,Offset c,double radius,double startAngle){
    //draw Lines
    final dx = radius/2.0 * cos(startAngle);
    final dy = radius/2.0 * sin(startAngle);
    final p2 = c + Offset(dx, dy);
    canvas.drawLine(c, p2, linePaint);
  }
  void drawSector(Canvas canvas,AccountActivity di, Rect rect, double startAngle,double sweepAngle){
    final sweepAngle = di.value * 360 * pi/180.0;
    final paint = Paint()..style = PaintingStyle.fill..color = di.color;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}