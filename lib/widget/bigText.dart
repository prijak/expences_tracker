import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  int MaxLines;

  BigText(
      {super.key,
      this.color = const Color(0xFF000000),
      required this.text,
      this.size = 0,
      this.MaxLines = 1,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: MaxLines == 1 ? 1 : MaxLines,
      overflow: overFlow,
      style: GoogleFonts.lato(
        fontSize: size == 0 ? 20 : size,
        color: color,
      ),
    );
  }
}
