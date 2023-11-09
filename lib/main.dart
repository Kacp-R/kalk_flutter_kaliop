import 'package:flutter/material.dart';
import 'package:kalk_flutter_kaliop/kalk.dart';

void main() {
  runApp(KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Kalkulator(),
    );
  }
}
