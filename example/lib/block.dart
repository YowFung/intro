import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final Size? size;
  final double? fontSize;

  const Block({
    super.key,
    required this.label,
    this.size,
    this.color,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size?.width,
      height: size?.height,
      padding: const EdgeInsets.all(10),
      alignment: size == null ? null : Alignment.center,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize ?? 16.0,
          color: textColor ?? Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
