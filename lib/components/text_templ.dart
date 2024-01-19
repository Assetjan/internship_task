import 'package:flutter/material.dart';

class TextTempl extends StatefulWidget {
  final String text;
  final double fontsize;
  final FontWeight fontWeight;
  final Color color;

  const TextTempl(
      {Key? key,
      required this.text,
      required this.fontsize,
      required this.fontWeight,
      required this.color})
      : super(key: key);

  @override
  State<TextTempl> createState() => _TextTemplState();
}

class _TextTemplState extends State<TextTempl> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontsize,
        fontWeight: widget.fontWeight,
        color: widget.color,
      ),
    );
  }
}
