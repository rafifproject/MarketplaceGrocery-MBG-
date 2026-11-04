import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/product_beef_assets.dart';

Widget buildBeefImage(
  String assetPath, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.contain,
  Color? color,
}) {
  return Image.asset(
    assetPath,
    width: width,
    height: height,
    fit: fit,
    color: color,
    errorBuilder: (context, error, stackTrace) {
      final b64 = beefAssetBase64[assetPath];
      if (b64 != null) {
        return Image.memory(
          base64Decode(b64),
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
      }
      return SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(Icons.image_outlined, size: 36, color: Color(0xFF94A3B8)),
        ),
      );
    },
  );
}
