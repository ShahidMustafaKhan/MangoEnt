import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTapped;

  CustomKeyboard({Key? key, required this.onKeyTapped}) : super(key: key);

  final Map<String, String> numberLetters = {
    '1': '',
    '2': 'ABC',
    '3': 'DEF',
    '4': 'GHI',
    '5': 'JKL',
    '6': 'MNO',
    '7': 'PQRS',
    '8': 'TUV',
    '9': 'WXYZ',
    '0': '',
    'x': '',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyboardButton('1'),
              _buildKeyboardButton('2'),
              _buildKeyboardButton('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyboardButton('4'),
              _buildKeyboardButton('5'),
              _buildKeyboardButton('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildKeyboardButton('7'),
              _buildKeyboardButton('8'),
              _buildKeyboardButton('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 102.w),
              _buildKeyboardButton('0'),
              Container(
                width: 102.w,
                child: Center(
                  child: _buildKeyboardButton('x'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(String label) {
    bool isBackspace = label == 'x';
    return Container(
      width: isBackspace ? 36 : 102,
      height: isBackspace ? 30 : 65,
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () => onKeyTapped(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff363339),
          shape: RoundedRectangleBorder(
            borderRadius: isBackspace
                ? BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    bottomLeft: Radius.circular(50.r))
                : BorderRadius.circular(20),
          ),
          elevation: 2,
          padding: EdgeInsets.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            if (numberLetters[label]!.isNotEmpty) ...[
              SizedBox(height: 2),
              Text(
                numberLetters[label]!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
