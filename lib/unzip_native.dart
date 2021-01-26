import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'logger_utils.dart';

class UnzipNative {
  static const MethodChannel methodChannel = MethodChannel('my_zip_decoder');

  Future<bool> extractToDir({@required File zipFile, @required Directory directory}) async {
    methodChannel.setMethodCallHandler((call) {
      if (call.method == 'process') {
        final int process = call.arguments;
        printI('process : $process');
        return Future.value(process);
      }
      return Future.value();
    });

    bool result = false;
    try {
      result = await methodChannel.invokeMethod('unzip', <String, dynamic>{
        "zipPath": zipFile.path,
        "extractPath": directory.path,
      });
    } catch (e) {
      printE(e.toString());
    }
    return result;
  }
}
