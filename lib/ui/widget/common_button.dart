import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isDisable;
  final double? width;
  final EdgeInsets? margin;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? buttonHeight;
  final double? borderWidth;

  const CommonButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isDisable = false,
    this.width,
    this.margin,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.buttonHeight,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: isDisable ? () {} : onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 24),
        child: Container(
          height: buttonHeight ?? 48,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 24),
            color: backgroundColor ?? Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: fontWeight ?? FontWeight.bold,
                fontSize: fontSize ?? 14,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
