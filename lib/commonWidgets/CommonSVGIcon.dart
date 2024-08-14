import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonSVGIcon extends StatelessWidget {
  final String? imageName;
  final String? imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit boxFit;
  final Alignment alignment;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final BlendMode colorBlendMode;
  final Clip clipBehavior;

  const CommonSVGIcon({
    super.key,
    required this.imageName,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.boxFit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.colorBlendMode = BlendMode.srcIn,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/$imagePath/$imageName.svg',
      width: width,
      height: height,
      color: color,
      fit: boxFit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
    );
  }
}
