import 'dart:ffi';

import 'package:laier/common/color_hex.dart';
import 'package:flutter/material.dart';

class SystemInfo {
  SystemInfo._privateConstructor();

  static final SystemInfo _instance = SystemInfo._privateConstructor();

  static SystemInfo shared() {
    return _instance;
  }

  //system info
  late Double statusBarHeight;
  late Double bottomBarHeight;
  Color themeColor = HexColor.fromHex('2bae85');
  Color subthemeColor = HexColor.fromHex('bec4e2');
  Color backgroundColor = HexColor.fromHex('f5f5f5');
  Color loginbackgroundColor = HexColor.fromHex('f4f4f6');
}
