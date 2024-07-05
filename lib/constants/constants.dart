import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export 'colors.dart';

final workSans = GoogleFonts.workSans();

Widget spacer({double? x = 5, double y = 5}) => SizedBox(width: x, height: y);

Size screen(BuildContext context) => MediaQuery.of(context).size;
