import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize:16,
              fontWeight:FontWeight.bold,
              color:Colors.black
            )
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}