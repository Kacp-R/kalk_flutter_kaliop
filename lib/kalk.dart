import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Kalkulator());
  }
  }

  class Kalkulator extends StatefulWidget {
  @override
    _KalkulatorState createState() => _KalkulatorState();
  }

class _KalkulatorState extends State<Kalkulator> {
  String _firstString = "";
  String _secondString = "";
  double _first = 0;
  double _second = 0;
  bool _dec = false;
  int _decC = 0;
  String _last = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Kalkulator")), backgroundColor: Color(0xFFFAFAFA),
    body: Column(
      children: [
      Expanded(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Color(0xFFFAFAEA),
                      child: InkWell(
                        onTap: () => copy(1),
                        child: Text(
                          _secondString,
                          style: TextStyle(
                            color: Color(0xFF000000), // custom color
                            fontSize: Theme.of(context).textTheme.displaySmall?.fontSize, // headline3 font size
                            fontWeight: Theme.of(context).textTheme.displaySmall?.fontWeight, // headline3 font weight
                            letterSpacing: Theme.of(context).textTheme.displaySmall?.letterSpacing, // headline3 letter spacing
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Color(0xFFFAFAEA),
                      child: InkWell(
                        onTap: () => copy(0),
                        child: Text(
                          _firstString,
                          style: TextStyle(
                            color: Color(0xFF000000), // custom color
                            fontSize: Theme.of(context).textTheme.displaySmall?.fontSize, // headline3 font size
                            fontWeight: Theme.of(context).textTheme.displaySmall?.fontWeight, // headline3 font weight
                            letterSpacing: Theme.of(context).textTheme.displaySmall?.letterSpacing, // headline3 letter spacing
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
        Row(
          children: [
            _buildButton('CL', () => func('cl')),
            _buildButton('DL', () => func('dl')),
            _buildButton('+/-', () => click(-2)),
          ],
        ),
        Row(
          children: [
            _buildButton('7', () => click(7)),
            _buildButton('8', () => click(8)),
            _buildButton('9', () => click(9)),
            _buildButton('/', () => func('/')),
          ],
        ),
        Row(
          children: [
            _buildButton('4', () => click(4)),
            _buildButton('5', () => click(5)),
            _buildButton('6', () => click(6)),
            _buildButton('*', () => func('*')),
          ],
        ),
        Row(
          children: [
            _buildButton('1', () => click(1)),
            _buildButton('2', () => click(2)),
            _buildButton('3', () => click(3)),
            _buildButton('-', () => func('-')),
          ],
        ),
        Row(
          children: [
            _buildButton('.', () => click(-1)),
            _buildButton('0', () => click(0)),
            _buildButton('=', () => func('=')),
            _buildButton('+', () => func('+')),
          ],
        ),
    ],
    ),
    );
  }

  Widget _buildButton(String buttonText, VoidCallback onPressed) {
    return buttonText == 'CL'
        ? Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEEEEEE),
              foregroundColor: Color(0xFF000000),
              minimumSize: const Size(20, 50)),
          child: Text(buttonText),
        ),
      ),
    )
        : Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEEEEEE),
              foregroundColor: Color(0xFF000000),
              minimumSize: const Size(20, 50)),
          child: Text(buttonText),
        ),
      ),
    );
  }

  void click(int input) {
    setState(() {
      if (input == -2) {
        if (_firstString == "") return;
        if (double.parse(_firstString) < 0) {
          _firstString = _firstString.substring(1, _firstString.length);
        } else {
          if (double.parse(_firstString) > 0) {
            _firstString = '-$_firstString';
          }
        }
        return;
      }
      if (input == -1) {
        if (_dec) return;
        _firstString += '.';
        _dec = true;
        _decC = _firstString.length;
        return;
      }
      _firstString += input.toString();
    });
  }

  void copy(int val) {
    if (val == 0)
      Clipboard.setData(ClipboardData(text: "$_firstString"));
    else
      Clipboard.setData(ClipboardData(text: "$_secondString"));
  }

  void func(String input) {
    setState(() {
      if (input == 'cl') {
        _first = 0;
        _second = 0;
        _firstString = '';
        _secondString = '';
        _dec = false;
      }
      if (input == 'dl') {
        if (_firstString.length > 0) {
          _firstString = _firstString.substring(0, _firstString.length - 1);
          if (_firstString.length + 1 == _decC) _dec = false;
        }
      } else {
        if (input == '=') {
          funcC(_last);
        } else {
          _last = input;
          funcC(input);
        }
      }
    });
  }

  void funcC(String inp) {
    if (_firstString == '' || inp == '') return;
    _first = double.parse(_firstString);
    if (_secondString != '') {
      _second = double.parse(_secondString);
      switch (inp) {
        case '+':
          {
            _first += _second;
          }
          break;
        case '-':
          {
            _first = _second - _first;
          }
          break;
        case '*':
          {
            _first *= _second;
          }
          break;
        case '/':
          {
            _first = _second / _first;
          }
          break;
      }
    }
    _dec = false;
    _second = _first;
    _secondString = _second.toString();
    _firstString = '';
  }
}