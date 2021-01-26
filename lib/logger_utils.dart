import 'package:ansicolor/ansicolor.dart';
import 'dart:developer' as logger;

class Logger {
  // Sample of abstract logging function
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => print('** $text. isError: [$isError]'));
  }
}

AnsiPen pen = new AnsiPen()..green(bold: true);

void printI(String message) {
  //print(pen(message));
  //Future.microtask(() => print(pen(message)));
  logger.log(pen(message));
}

AnsiPen penRed = AnsiPen()..red(bold: false);

void printE(String message) {
  //print(penRed(message));
  //Future.microtask(() => print(penRed(message)));
  logger.log(penRed(message));
}
