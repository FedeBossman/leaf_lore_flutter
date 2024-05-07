import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

errorSnackBar(String message) {
  return SnackBar(content: Text(message), backgroundColor: LeafLoreColors.errorRed);
}