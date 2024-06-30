import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class NumberTextField extends StatefulWidget {
  final Color color;
  final double width;

  NumberTextField({required this.color, required this.width});

  @override
  _NumberTextFieldState createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  final TextEditingController _controller = TextEditingController();
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text.replaceAll(',', '');
      try {
        final int number = int.parse(text.isEmpty ? '0' : text);
        final formattedText = _formatter.format(number);
        _controller.value = _controller.value.copyWith(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      } catch (e) {
        print('Error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 50,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.color.withOpacity(0.25),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}