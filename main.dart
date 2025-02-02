import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '0';

  void _buttonPressed(String text) {
    setState(() {
      if (text == 'AC') {
        input = '';
        output = '0';
      } else if (text == '=') {
        _calculate();
      } else {
        input += text;
      }
    });
  }

  void _calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        output = eval.toString();
      });
    } catch (e) {
      setState(() {
        output = 'Error';
      });
    }
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return GestureDetector(
      onTap: () => _buttonPressed(text),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(40),
        ),
        alignment: Alignment.center,
        width: 80,
        height: 80,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    output,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('AC', Colors.grey, Colors.black),
                  _buildButton('%', Colors.grey, Colors.black),
                  _buildButton('÷', Colors.orange, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('7', Colors.grey[850]!, Colors.white),
                  _buildButton('8', Colors.grey[850]!, Colors.white),
                  _buildButton('9', Colors.grey[850]!, Colors.white),
                  _buildButton('×', Colors.orange, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('4', Colors.grey[850]!, Colors.white),
                  _buildButton('5', Colors.grey[850]!, Colors.white),
                  _buildButton('6', Colors.grey[850]!, Colors.white),
                  _buildButton('-', Colors.orange, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('1', Colors.grey[850]!, Colors.white),
                  _buildButton('2', Colors.grey[850]!, Colors.white),
                  _buildButton('3', Colors.grey[850]!, Colors.white),
                  _buildButton('+', Colors.orange, Colors.white),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton('0', Colors.grey[850]!, Colors.white),
                  _buildButton('.', Colors.grey[850]!, Colors.white),
                  _buildButton('=', Colors.orange, Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
