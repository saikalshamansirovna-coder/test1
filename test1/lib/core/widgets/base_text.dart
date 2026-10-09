import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Единый текст приложения (шрифт Orbitron). Меняйте параметры в одном месте.
class BaseText extends StatelessWidget {
  const BaseText(
    this.text, {
    super.key,
    this.size = 14,
    this.color = AppColors.textPrimary,
    this.weight = FontWeight.w700,
    this.maxLines,
    this.align,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int? maxLines;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => Text(
        text,
        maxLines: maxLines,
        textAlign: align,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        style: GoogleFonts.orbitron(fontSize: size, color: color, fontWeight: weight),
      );
}
