// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom {
  ///[ Custom Text Widgit]
  static Text text({
    String? text,
    TextAlign? textAlign,
    double? fontSize = 14,
    FontWeight? fontWeight,
    Color? colors = const Color(0xffe6e1e4),
  }) {
    return Text(
      text!,
      textAlign: textAlign,
      style: GoogleFonts.openSans(
        // fontSize: 26,
        // fontWeight: FontWeight.w600,

        fontSize: fontSize,
        fontWeight: fontWeight,
        color: colors,
      ),
    );
  }

  ///[ Custom TextStyle Widgit]
  static TextStyle style({
    TextAlign? textAlign,
    double? fontSize = 14,
    FontWeight? fontWeight,
    Color? colors = const Color(0xffe6e1e4),
  }) {
    return GoogleFonts.openSans(
      // fontSize: 26,
      // fontWeight: FontWeight.w600,

      fontSize: fontSize,
      fontWeight: fontWeight,
      color: colors,
    );
  }

  ///[ Custom TextFormField Widgit]
  static TextFormField textField({
    Widget? label,
    FloatingLabelBehavior? floatingLabelBehavior,
    String? hintText,
    TextStyle? hintStyle,
    bool? filled = true,
    Color? fillColor = const Color(0xFF5A5083),
    Color? cursorColor = const Color(0xffe6e1e4),
    InputBorder? border,
    Widget? prefix,
    Icon? prefixIcon,
    Widget? suffix,
    Icon? suffixIcon,
    FloatingLabelAlignment? floatingLabelAlignment =
        FloatingLabelAlignment.start,
    bool? alignLabelWithHint = true,
    bool obscureText = false,
    InputDecoration? decoration,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Widget? error,
  }) {
    ////////////////////////////////////////////
    ////default border style
    border ??= OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20.0),
    );
    ////////////////////////////////////////////
    ////default label style
    // label ??= Custom.text(
    //   text: "EMAIL",
    //   fontSize: 14,
    //   fontWeight: FontWeight.w400,
    // );
    ////////////////////////////////////////////
    ////default decoration
    decoration ??= InputDecoration(
      filled: filled,
      fillColor: fillColor,
      border: border,
      prefix: prefix,
      hintText: hintText,
      prefixIcon: prefixIcon,
      hintStyle: hintStyle,
      floatingLabelBehavior:
          floatingLabelBehavior ?? FloatingLabelBehavior.never,
      label: label,
      floatingLabelAlignment: floatingLabelAlignment,
      alignLabelWithHint: alignLabelWithHint,
      error: error,
    );
    ////////////////////////////////////////////

    return TextFormField(
      obscureText: obscureText,
      cursorColor: cursorColor,
      controller: controller,
      validator: validator,
      decoration: decoration,
    );
  }
  //
}
